// home_cubit.dart

import 'dart:developer';

import 'package:base_project/features/home/model/task_model.dart';
import 'package:base_project/features/home/model/team_model.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

import '../repo/home_repo.dart';
import 'state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final HomeRepo repo;

  HomeCubit({required this.repo}) : super(const HomeState());

  HubConnection? hubConnection;

  Future<void> init() async {
    try {
      emit(state.copyWith(isLoading: true));
      await Future.wait([
        _loadTeams(),
        _loadTasks(),
      ]);
      await _initSignalR();
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      log('HomeCubit.init error: $e');
    }
  }

  // ══════════════════════════════════════════════════════
  // API Calls
  // ══════════════════════════════════════════════════════

  Future<void> _loadTeams() async {
    final res = await repo.getTeams();
    if (res.isSuccess) {
      var teams = res.data ?? [];
      teams.sort((a, b) => b.score.compareTo(a.score));
      emit(state.copyWith(teams: teams));
    }
  }

  Future<void> _loadTasks() async {
    final res = await repo.getTasks();
    if (res.isSuccess) {
      final allTasks = res.data ?? [];
      emit(state.copyWith(
        dailyTasks: allTasks.where((t) => t.type == TaskType.daily).toList(),
        bonusTasks: allTasks.where((t) => t.type == TaskType.bonus).toList(),
        flashTasks: allTasks.where((t) => t.type == TaskType.flash).toList(),
      ));
    }
  }

  // ══════════════════════════════════════════════════════
  // SignalR
  // ══════════════════════════════════════════════════════

  Future<void> _initSignalR() async {
    hubConnection = HubConnectionBuilder()
        .withUrl(
      'http://localhost:5171/hubs/scoreboard',
      options: HttpConnectionOptions(
        transport: HttpTransportType.LongPolling,
        requestTimeout: 30000,
      ),
    )
        .withAutomaticReconnect()
        .build();

    _registerHandlers();

    await hubConnection!.start();
    emit(state.copyWith(isConnected: true));
    log('SignalR connected');
  }

  void _registerHandlers() {
    // ── ScoreUpdated(teamId, newScore) ──────────────────
    // Fired by PUT /api/teams/{id}/score
    hubConnection!.on('ScoreUpdated', (arguments) {
      if (arguments == null || arguments.length < 2) return;

      final int teamId   = arguments[0] as int;
      final int newScore = arguments[1] as int;

      _applySingleScoreUpdate(teamId, newScore);
    });

    // ── BulkScoreUpdate([{id, score}, ...]) ─────────────
    // Fired by PUT /api/teams/{id}/addpoints
    // The backend sends an IEnumerable<{Id, Score}> as the
    // first (and only) argument — SignalR wraps it in a
    // one-element outer list, and the inner value is a
    // List of Maps.
    hubConnection!.on('BulkScoreUpdate', (arguments) {
      log('BulkScoreUpdate raw: $arguments');
      if (arguments == null || arguments.isEmpty) return;

      // arguments = [ [ {id:1, score:100}, {id:3, score:80} ] ]
      final innerList = arguments[0] as List;

      var updatedTeams = [...state.teams];

      for (final entry in innerList) {
        final map      = Map<String, dynamic>.from(entry as Map);
        final int id   = map['id'] as int;
        final int score = map['score'] as int;

        updatedTeams = updatedTeams.map((team) {
          return team.id == id ? team.copyWith(score: score) : team;
        }).toList();
      }

      updatedTeams.sort((a, b) => b.score.compareTo(a.score));
      emit(state.copyWith(teams: updatedTeams));
    });

    // ── SuperPowerActivated(teamId, type) ───────────────
    // Fired by POST /api/teams/activate
    hubConnection!.on('SuperPowerActivated', (arguments) {
      log('SuperPowerActivated: $arguments');
      if (arguments == null || arguments.length < 2) return;

      final int    teamId      = arguments[0] as int;
      final String powerType   = arguments[1] as String;
      log('SuperPowerActivated: $teamId ${powerType}');
      _applyPowerStatusChange(
        teamId:    teamId,
        powerType: powerType,
        newStatus: 'Activated',
      );
    });

    // ── SuperPowerDeactivated(teamId, type) ─────────────
    // Fired by POST /api/teams/deactivate
    hubConnection!.on('SuperPowerDeactivated', (arguments) {
      log('SuperPowerDeactivated: $arguments');
      if (arguments == null || arguments.length < 2) return;

      final int    teamId    = arguments[0] as int;
      final String powerType = arguments[1] as String;

      _applyPowerStatusChange(
        teamId:    teamId,
        powerType: powerType,
        newStatus: 'Deactivated',
      );
    });

    // ── TaskAdded(task) ─────────────────────────────────
    hubConnection!.on('TaskAdded', (arguments) {
      if (arguments == null || arguments.isEmpty) return;

      final data    = Map<String, dynamic>.from(arguments[0] as Map);
      final newTask = TaskModel.fromJson(data);

      switch (newTask.type) {
        case TaskType.daily:
          emit(state.copyWith(
              dailyTasks: [...state.dailyTasks, newTask]));
          break;
        case TaskType.bonus:
          emit(state.copyWith(
              bonusTasks: [...state.bonusTasks, newTask]));
          break;
        case TaskType.flash:
          emit(state.copyWith(
              flashTasks: [...state.flashTasks, newTask]));
          break;
      }
    });

    // ── TaskDeleted(taskId) ─────────────────────────────
    hubConnection!.on('TaskDeleted', (arguments) {
      if (arguments == null || arguments.isEmpty) return;

      final int taskId = arguments[0] as int;

      emit(state.copyWith(
        dailyTasks: state.dailyTasks.where((t) => t.id != taskId).toList(),
        bonusTasks: state.bonusTasks.where((t) => t.id != taskId).toList(),
        flashTasks: state.flashTasks.where((t) => t.id != taskId).toList(),
      ));
    });
  }

  // ══════════════════════════════════════════════════════
  // Helpers
  // ══════════════════════════════════════════════════════

  /// Applies a single team score update + re-sorts.
  void _applySingleScoreUpdate(int teamId, int newScore) {
    final updated = state.teams.map((team) {
      return team.id == teamId ? team.copyWith(score: newScore) : team;
    }).toList()
      ..sort((a, b) => b.score.compareTo(a.score));

    emit(state.copyWith(teams: updated));
  }

  /// Mutates the `status` field of a matching superpower
  /// inside a team's `teamSuperPowers` list, then re-emits.
  void _applyPowerStatusChange({
    required int    teamId,
    required String powerType,
    required String newStatus,
  }) {
    log("applyyyyyyyy ");
    final updatedTeams = state.teams.map((team) {

      if (team.id != teamId) return team;

      final updatedPowers = team.teamSuperPowers.map((power) {
        if (power.type != powerType) return power;
   log("powerNAme ${power.type}");
        return TeamSuperPower(
          id:             power.id,
          teamId:         power.teamId,
          type:           power.type,
          status:         newStatus,           // ← only this changes
          activatedAt:    newStatus == 'Activated'
              ? DateTime.now().toUtc()
              : power.activatedAt,
          deactivatedAt:  newStatus == 'Deactivated'
              ? DateTime.now().toUtc()
              : power.deactivatedAt,
          targetTeamId:   power.targetTeamId,
          imageBase64:    power.imageBase64,
        );
      }).toList();

      return team.copyWith(teamSuperPowers: updatedPowers);
    }).toList();

    emit(state.copyWith(teams: updatedTeams));
  }

  @override
  Future<void> close() async {
    await hubConnection?.stop();
    super.close();
  }
}