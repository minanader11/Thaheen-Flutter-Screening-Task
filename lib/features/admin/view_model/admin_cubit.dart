import 'dart:developer';

import 'package:LJF_admin/features/admin/model/bank_certificate_model.dart';
import 'package:LJF_admin/features/admin/model/event_config_model.dart';
import 'package:LJF_admin/features/admin/model/task_model.dart';
import 'package:LJF_admin/features/admin/model/team_model.dart';
import 'package:LJF_admin/features/admin/model/team_super_power_model.dart';
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
    try{
    emit(state.copyWith(isLoading: true));
    await Future.wait([
      _loadTeams(),
      _loadTasks(),
      _loadBankCertificates(),
      _loadEventConfig(),
    ]);
    await _initSignalR();
    emit(state.copyWith(isLoading: false));
    } catch(e){
      log("errorrrrrSignalr ${e}");
    }
  }
  Future<void> reconnectSignalR() async {
    try {
      await hubConnection?.stop();
    } catch (e) {
      log('reconnectSignalR — stop error: $e');
    }
    await _initSignalR();
  }
  // ══════════════════════════════════════════════════════════════════
  // API Calls (existing)
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

  /// Add points to a team.
  /// Pass [targetTeamToMinus] when Minus power is active.
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
    } else {
      emit(state.copyWith(
        deleteTaskStatus: AdminActionStatus.failure,
        errorMessage: res.error?.message ?? 'Failed to delete task',
      ));
    }
  }

  /// Activate a superpower for a team.
  ///
  /// • [targetTeamToFreeze] — pass when [type] == 'freezer' (or re-activating Freezer)
  /// • [reActivatedType]    — pass when [type] == 'reActivation'
  Future<void> activateSuperPower({
    required int teamId,
    required String type,
    int? targetTeamToFreeze,
    String? reActivatedType,
  }) async {
    emit(state.copyWith(activatePowerStatus: AdminActionStatus.loading));
    log('AdminCubit.activateSuperPower: type=$type, freeze=$targetTeamToFreeze, reActivate=$reActivatedType');

    final res = await repo.activateSuperPower(
      teamId: teamId,
      type: type,
      targetTeamToFreeze: targetTeamToFreeze,
      reActivatedType: reActivatedType,
    );

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
  // NEW: Car progress
  // ══════════════════════════════════════════════════════════════════

  Future<void> updateCarProgress({
    required int teamId,
    required double percentage,
  }) async {
    emit(state.copyWith(updateCarProgressStatus: AdminActionStatus.loading));
    final res = await repo.updateCarProgress(teamId: teamId, percentage: percentage);
    if (res.isSuccess) {
      final updatedTeam = res.data!;
      final updatedTeams = state.teams
          .map((t) => t.id == updatedTeam.id ? updatedTeam : t)
          .toList();
      emit(state.copyWith(
        teams: updatedTeams,
        updateCarProgressStatus: AdminActionStatus.success,
      ));
    } else {
      emit(state.copyWith(
        updateCarProgressStatus: AdminActionStatus.failure,
        errorMessage: res.error?.message ?? 'Failed to update car progress',
      ));
    }
  }

  // ══════════════════════════════════════════════════════════════════
  // NEW: Bank
  // ══════════════════════════════════════════════════════════════════

  Future<void> _loadBankCertificates() async {
    emit(state.copyWith(loadBankCertificatesStatus: AdminActionStatus.loading));
    final res = await repo.getBankCertificates();
    if (res.isSuccess) {
      emit(state.copyWith(
        bankCertificates: res.data ?? [],
        loadBankCertificatesStatus: AdminActionStatus.success,
      ));
    } else {
      emit(state.copyWith(
        loadBankCertificatesStatus: AdminActionStatus.failure,
        errorMessage: res.error?.message ?? 'Failed to load bank certificates',
      ));
    }
  }

  Future<void> createBankCertificate({
    required int durationMinutes,
    required double percentageGain,
  }) async {
    emit(state.copyWith(createBankCertificateStatus: AdminActionStatus.loading));
    final res = await repo.createBankCertificate(
      durationMinutes: durationMinutes,
      percentageGain: percentageGain,
    );
    if (res.isSuccess) {
      emit(state.copyWith(
        bankCertificates: [...state.bankCertificates, res.data!],
        createBankCertificateStatus: AdminActionStatus.success,
      ));
    } else {
      emit(state.copyWith(
        createBankCertificateStatus: AdminActionStatus.failure,
        errorMessage: res.error?.message ?? 'Failed to create bank certificate',
      ));
    }
  }

  Future<void> deleteBankCertificate(int certificateId) async {
    emit(state.copyWith(deleteBankCertificateStatus: AdminActionStatus.loading));
    final res = await repo.deleteBankCertificate(certificateId);
    if (res.isSuccess) {
      emit(state.copyWith(
        bankCertificates:
        state.bankCertificates.where((c) => c.id != certificateId).toList(),
        deleteBankCertificateStatus: AdminActionStatus.success,
      ));
    } else {
      emit(state.copyWith(
        deleteBankCertificateStatus: AdminActionStatus.failure,
        errorMessage: res.error?.message ?? 'Failed to delete bank certificate',
      ));
    }
  }

  /// Pass [newBalance] to set an absolute value, or [delta] to add/subtract.
  Future<void> updateTeamBankBalance({
    required int teamId,
    double? newBalance,
    double? delta,
  }) async {

    emit(state.copyWith(updateBankBalanceStatus: AdminActionStatus.loading));
    final res = await repo.updateTeamBankBalance(
      teamId: teamId,
      newBalance: newBalance,
      delta: delta,
    );
    if (res.isSuccess) {
      final balance = res.data!;
      final updatedTeams = state.teams
          .map((t) => t.id == teamId ? t.copyWith(bankBalance: balance) : t)
          .toList();
      emit(state.copyWith(
        teams: updatedTeams,
        updateBankBalanceStatus: AdminActionStatus.success,
      ));
    } else {
      emit(state.copyWith(
        updateBankBalanceStatus: AdminActionStatus.failure,
        errorMessage: res.error?.message ?? 'Failed to update bank balance',
      ));
    }
  }

  // ══════════════════════════════════════════════════════════════════
  // NEW: University
  // ══════════════════════════════════════════════════════════════════

  Future<void> incrementAttendeeCount() => _updateAttendeeCount(delta: 1);

  Future<void> setAttendeeCount(int count) => _updateAttendeeCount(count: count);

  Future<void> _updateAttendeeCount({int? count, int? delta}) async {
    emit(state.copyWith(updateAttendeeCountStatus: AdminActionStatus.loading));
    final res = await repo.updateAttendeeCount(count: count, delta: delta);
    if (res.isSuccess) {
      emit(state.copyWith(
        attendeeCount: res.data!,
        updateAttendeeCountStatus: AdminActionStatus.success,
      ));
    } else {
      emit(state.copyWith(
        updateAttendeeCountStatus: AdminActionStatus.failure,
        errorMessage: res.error?.message ?? 'Failed to update attendee count',
      ));
    }
  }

  // ══════════════════════════════════════════════════════════════════
  // NEW: Event config
  // ══════════════════════════════════════════════════════════════════

  Future<void> _loadEventConfig() async {
    emit(state.copyWith(loadEventConfigStatus: AdminActionStatus.loading));
    final res = await repo.getEventConfig();
    if (res.isSuccess) {
      emit(state.copyWith(
        eventConfig: res.data,
        loadEventConfigStatus: AdminActionStatus.success,
      ));
    } else {
      emit(state.copyWith(
        loadEventConfigStatus: AdminActionStatus.failure,
        errorMessage: res.error?.message ?? 'Failed to load event config',
      ));
    }
  }

  Future<void> updateEventConfig({
    required String eventName,
    required DateTime eventStartTime,
    required int eventDurationHours,
    required DateTime raceStartTime,
  }) async {
    emit(state.copyWith(updateEventConfigStatus: AdminActionStatus.loading));
    final res = await repo.updateEventConfig(
      eventName: eventName,
      eventStartTime: eventStartTime,
      eventDurationHours: eventDurationHours,
      raceStartTime: raceStartTime,
    );
    if (res.isSuccess) {
      emit(state.copyWith(
        eventConfig: res.data,
        updateEventConfigStatus: AdminActionStatus.success,
      ));
    } else {
      emit(state.copyWith(
        updateEventConfigStatus: AdminActionStatus.failure,
        errorMessage: res.error?.message ?? 'Failed to update event config',
      ));
    }
  }

  // ══════════════════════════════════════════════════════════════════
  // SignalR
  // ══════════════════════════════════════════════════════════════════

  Future<void> _initSignalR() async {
    try {
      hubConnection = HubConnectionBuilder()
          .withUrl(
        'https://ljfscoring.runasp.net/hubs/scoreboard',
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
    } catch (e) {
      log('AdminCubit — SignalR error: $e');
    }
  }

  void _registerHandlers() {
    // ── ScoreUpdated ─────────────────────────────────────
    hubConnection!.on('ScoreUpdated', (args) {
      try {
        if (args == null || args.length < 2) return;
        _applySingleScoreUpdate(args[0] as int, args[1] as int);
      } catch (e) {
        log('ScoreUpdated handler error: $e');
      }
    });

    // ── BulkScoreUpdate ──────────────────────────────────
    hubConnection!.on('BulkScoreUpdate', (args) {
      try {
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
      } catch (e) {
        log('BulkScoreUpdate handler error: $e');
      }
    });

    // ── SuperPowerActivated ──────────────────────────────
    hubConnection!.on('SuperPowerActivated', (args) {
      try {
        if (args == null || args.length < 2) return;
        _applyPowerStatusChange(
          teamId: args[0] as int,
          powerType: args[1] as String,
          newStatus: 'Activated',
        );
      } catch (e) {
        log('SuperPowerActivated handler error: $e');
      }
    });

    // ── SuperPowerDeactivated ────────────────────────────
    hubConnection!.on('SuperPowerDeactivated', (args) {
      try {
        if (args == null || args.length < 2) return;
        _applyPowerStatusChange(
          teamId: args[0] as int,
          powerType: args[1] as String,
          newStatus: 'Deactivated',
        );
      } catch (e) {
        log('SuperPowerDeactivated handler error: $e');
      }
    });

    // ── TaskAdded ────────────────────────────────────────
    hubConnection!.on('TaskAdded', (args) {
      try {
        if (args == null || args.isEmpty) return;
        final task =
        TaskModel.fromJson(Map<String, dynamic>.from(args[0] as Map));
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
      } catch (e) {
        log('TaskAdded handler error: $e');
      }
    });

    // ── TaskDeleted ──────────────────────────────────────
    hubConnection!.on('TaskDeleted', (args) {
      try {
        if (args == null || args.isEmpty) return;
        final taskId = args[0] as int;
        emit(state.copyWith(
          dailyTasks: state.dailyTasks.where((t) => t.id != taskId).toList(),
          bonusTasks: state.bonusTasks.where((t) => t.id != taskId).toList(),
          flashTasks: state.flashTasks.where((t) => t.id != taskId).toList(),
        ));
      } catch (e) {
        log('TaskDeleted handler error: $e');
      }
    });

    // ── CarProgressUpdated ───────────────────────────────
    hubConnection!.on('CarProgressUpdated', (args) {
      try {
        if (args == null || args.length < 2) return;
        final teamId = args[0] as int;
        final percentage = (args[1] as num).toDouble();
        final updated = state.teams
            .map((t) => t.id == teamId
            ? t.copyWith(carCompletionPercentage: percentage)
            : t)
            .toList();
        emit(state.copyWith(teams: updated));
      } catch (e) {
        log('CarProgressUpdated handler error: $e');
      }
    });

    // ── BankBalanceUpdated ───────────────────────────────
    hubConnection!.on('BankBalanceUpdated', (args) {
      try {
        if (args == null || args.length < 2) return;
        final teamId = args[0] as int;
        final balance = (args[1] as num).toDouble();
        final updated = state.teams
            .map((t) => t.id == teamId ? t.copyWith(bankBalance: balance) : t)
            .toList();
        emit(state.copyWith(teams: updated));
      } catch (e) {
        log('BankBalanceUpdated handler error: $e');
      }
    });

    // ── AttendeeCountUpdated ─────────────────────────────
    hubConnection!.on('AttendeeCountUpdated', (args) {
      try {
        if (args == null || args.isEmpty) return;
        emit(state.copyWith(attendeeCount: args[0] as int));
      } catch (e) {
        log('AttendeeCountUpdated handler error: $e');
      }
    });

    // ── RaceCountdownSynced ──────────────────────────────
    hubConnection!.on('RaceCountdownSynced', (args) {
      try {
        if (args == null || args.isEmpty) return;
        final map = Map<String, dynamic>.from(args[0] as Map);
        emit(state.copyWith(eventConfig: EventConfigModel.fromJson(map)));
      } catch (e) {
        log('RaceCountdownSynced handler error: $e');
      }
    });
    // ── CertificateCatalogAdded ──────────────────────────
    hubConnection!.on('CertificateCatalogAdded', (args) {
      try {
        if (args == null || args.isEmpty) return;
        final map = Map<String, dynamic>.from(args[0] as Map);
        final cert = BankCertificateModel.fromJson(map);
        final withoutDuplicate = state.bankCertificates.where((c) => c.id != cert.id).toList();
        emit(state.copyWith(bankCertificates: [...withoutDuplicate, cert]));
      } catch (e) {
        log('CertificateCatalogAdded handler error: $e');
      }
    });

// ── CertificateCatalogDeleted ────────────────────────
    hubConnection!.on('CertificateCatalogDeleted', (args) {
      try {
        if (args == null || args.isEmpty) return;
        final id = args[0] as int;
        emit(state.copyWith(
          bankCertificates: state.bankCertificates.where((c) => c.id != id).toList(),
        ));
      } catch (e) {
        log('CertificateCatalogDeleted handler error: $e');
      }
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
        if (power.type.name != powerType) return power;
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