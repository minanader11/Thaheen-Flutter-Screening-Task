import 'dart:developer';


import 'package:base_project/features/admin/model/task_model.dart';
import 'package:base_project/features/admin/model/team_model.dart';
import 'package:base_project/features/admin/model/team_super_power_model.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../repo/admin_repo.dart';
import 'admin_state.dart';

@injectable
class AdminCubit extends Cubit<AdminState> {
  final AdminRepo repo;

  AdminCubit({required this.repo}) : super(const AdminState());

  HubConnection? hubConnection;

  // ══════════════════════════════════════════════════════════════════
  // Init
  // ══════════════════════════════════════════════════════════════════

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    await Future.wait([_loadTeams(), _loadTasks()]);
    await _initSignalR();
    emit(state.copyWith(isLoading: false));
  }

  // ══════════════════════════════════════════════════════════════════
  // API Calls
  // ══════════════════════════════════════════════════════════════════

  Future<void> _loadTeams() async {
    final res = await repo.getTeams();
    if (res.isSuccess) {
      final sorted = [...(res.data ?? <TeamModel>[])]
        ..sort((a, b) => b.score.compareTo(a.score));
      emit(state.copyWith(teams: sorted));
    }
  }

  Future<void> _loadTasks() async {
    final res = await repo.getTasks();
    if (res.isSuccess) {
      final all = res.data ?? [];
      emit(state.copyWith(
        dailyTasks: all.where((t) => t.type == TaskType.daily).toList(),
        bonusTasks: all.where((t) => t.type == TaskType.bonus).toList(),
        flashTasks: all.where((t) => t.type == TaskType.flash).toList(),
      ));
    }
  }

  /// Add points to a team. Pass [targetTeamToMinus] when Minus power is active.
  Future<void> addPoints({
    required int teamId,
    required int points,
    int? targetTeamToMinus,
  }) async {
    emit(state.copyWith(addPointsStatus: AdminActionStatus.loading));
    final res = await repo.addPoints(
      teamId: teamId,
      points: points,
      targetTeamToMinus: targetTeamToMinus,
    );
    if (res.isSuccess) {
      emit(state.copyWith(addPointsStatus: AdminActionStatus.success));
      // Scores are refreshed via SignalR BulkScoreUpdate
    } else {
      emit(state.copyWith(
        addPointsStatus: AdminActionStatus.failure,
        errorMessage: res.error?.message ?? 'Failed to add points',
      ));
    }
  }

  Future<void> createTask({
    required String name,
    required String type,
    required String score,
  }) async {
    emit(state.copyWith(createTaskStatus: AdminActionStatus.loading));
    final res = await repo.createTask(name: name, type: type, score: score);
    if (res.isSuccess) {
      emit(state.copyWith(createTaskStatus: AdminActionStatus.success));
      // Task list refreshed via SignalR TaskAdded
    } else {
      emit(state.copyWith(
        createTaskStatus: AdminActionStatus.failure,
        errorMessage: res.error?.message ?? 'Failed to create task',
      ));
    }
  }

  Future<void> deleteTask(int taskId) async {
    emit(state.copyWith(deleteTaskStatus: AdminActionStatus.loading));
    final res = await repo.deleteTask(taskId);
    if (res.isSuccess) {
      emit(state.copyWith(deleteTaskStatus: AdminActionStatus.success));
      // Task list refreshed via SignalR TaskDeleted
    } else {
      emit(state.copyWith(
        deleteTaskStatus: AdminActionStatus.failure,
        errorMessage: res.error?.message ?? 'Failed to delete task',
      ));
    }
  }

  Future<void> activateSuperPower({
    required int teamId,
    required String type,
  }) async {
    emit(state.copyWith(activatePowerStatus: AdminActionStatus.loading));
    final res = await repo.activateSuperPower(teamId: teamId, type: type);
    if (res.isSuccess) {
      emit(state.copyWith(activatePowerStatus: AdminActionStatus.success));
    } else {
      emit(state.copyWith(
        activatePowerStatus: AdminActionStatus.failure,
        errorMessage: res.error?.message ?? 'Failed to activate power',
      ));
    }
  }

  Future<void> deactivateSuperPower(int teamId) async {
    emit(state.copyWith(deactivatePowerStatus: AdminActionStatus.loading));
    final res = await repo.deactivateSuperPower(teamId: teamId);
    if (res.isSuccess) {
      emit(state.copyWith(deactivatePowerStatus: AdminActionStatus.success));
    } else {
      emit(state.copyWith(
        deactivatePowerStatus: AdminActionStatus.failure,
        errorMessage: res.error?.message ?? 'Failed to deactivate power',
      ));
    }
  }

  // ══════════════════════════════════════════════════════════════════
  // SignalR — mirrors HomeCubit handlers
  // ══════════════════════════════════════════════════════════════════

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

    hubConnection!.onclose(({error}) {
      emit(state.copyWith(isConnected: false));
    });

    hubConnection!.onreconnected(({connectionId}) {
      emit(state.copyWith(isConnected: true));
    });

    _registerHandlers();

    await hubConnection!.start();
    emit(state.copyWith(isConnected: true));
    log('AdminCubit — SignalR connected');
  }

  void _registerHandlers() {
    // ── ScoreUpdated ─────────────────────────────────────
    hubConnection!.on('ScoreUpdated', (args) {
      if (args == null || args.length < 2) return;
      _applySingleScoreUpdate(args[0] as int, args[1] as int);
    });

    // ── BulkScoreUpdate ──────────────────────────────────
    hubConnection!.on('BulkScoreUpdate', (args) {
      if (args == null || args.isEmpty) return;
      final innerList = args[0] as List;
      var updated = [...state.teams];
      for (final entry in innerList) {
        final map = Map<String, dynamic>.from(entry as Map);
        final id = map['id'] as int;
        final score = map['score'] as int;
        updated = updated
            .map((t) => t.id == id ? t.copyWith(score: score) : t)
            .toList();
      }
      updated.sort((a, b) => b.score.compareTo(a.score));
      emit(state.copyWith(teams: updated));
    });

    // ── SuperPowerActivated ──────────────────────────────
    hubConnection!.on('SuperPowerActivated', (args) {
      if (args == null || args.length < 2) return;
      _applyPowerStatusChange(
        teamId: args[0] as int,
        powerType: args[1] as String,
        newStatus: 'Activated',
      );
    });

    // ── SuperPowerDeactivated ────────────────────────────
    hubConnection!.on('SuperPowerDeactivated', (args) {
      if (args == null || args.length < 2) return;
      _applyPowerStatusChange(
        teamId: args[0] as int,
        powerType: args[1] as String,
        newStatus: 'Deactivated',
      );
    });

    // ── TaskAdded ────────────────────────────────────────
    hubConnection!.on('TaskAdded', (args) {
      if (args == null || args.isEmpty) return;
      final task = TaskModel.fromJson(Map<String, dynamic>.from(args[0] as Map));
      switch (task.type) {
        case TaskType.daily:
          emit(state.copyWith(dailyTasks: [...state.dailyTasks, task]));
          break;
        case TaskType.bonus:
          emit(state.copyWith(bonusTasks: [...state.bonusTasks, task]));
          break;
        case TaskType.flash:
          emit(state.copyWith(flashTasks: [...state.flashTasks, task]));
          break;
      }
    });

    // ── TaskDeleted ──────────────────────────────────────
    hubConnection!.on('TaskDeleted', (args) {
      if (args == null || args.isEmpty) return;
      final taskId = args[0] as int;
      emit(state.copyWith(
        dailyTasks: state.dailyTasks.where((t) => t.id != taskId).toList(),
        bonusTasks: state.bonusTasks.where((t) => t.id != taskId).toList(),
        flashTasks: state.flashTasks.where((t) => t.id != taskId).toList(),
      ));
    });
  }

  // ══════════════════════════════════════════════════════════════════
  // Helpers
  // ══════════════════════════════════════════════════════════════════

  void _applySingleScoreUpdate(int teamId, int newScore) {
    final updated = state.teams
        .map((t) => t.id == teamId ? t.copyWith(score: newScore) : t)
        .toList()
      ..sort((a, b) => b.score.compareTo(a.score));
    emit(state.copyWith(teams: updated));
  }

  void _applyPowerStatusChange({
    required int teamId,
    required String powerType,
    required String newStatus,
  }) {
    final updatedTeams = state.teams.map((team) {
      if (team.id != teamId) return team;
      final updatedPowers = team.teamSuperPowers.map((power) {
        if (power.type != powerType) return power;
        return TeamSuperPower(
          id: power.id,
          teamId: power.teamId,
          type: power.type,
          status: SuperPowerStatus.fromJson(newStatus),
          activatedAt: newStatus == 'Activated'
              ? DateTime.now().toUtc()
              : power.activatedAt,
          deactivatedAt: newStatus == 'Deactivated'
              ? DateTime.now().toUtc()
              : power.deactivatedAt,
          targetTeamId: power.targetTeamId,
          imageBase64: power.imageBase64,
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
