import 'package:LJF_admin/core/config/end_points.dart';
import 'package:LJF_admin/core/networking/api_client/api_client.dart';
import 'package:LJF_admin/core/networking/api_result/api_result.dart';
import 'package:LJF_admin/features/admin/model/bank_certificate_model.dart';
import 'package:LJF_admin/features/admin/model/event_config_model.dart';
import 'package:LJF_admin/features/admin/model/task_model.dart';
import 'package:LJF_admin/features/admin/model/team_model.dart';

import 'package:injectable/injectable.dart';

import 'admin_repo.dart';

@LazySingleton(as: AdminRepo)
class AdminRepoImpl implements AdminRepo {
  final ApiClient apiClient;

  AdminRepoImpl({required this.apiClient});

  // ─────────────────────────── GET TEAMS ────────────────────────────
  @override
  Future<ApiResult<List<TeamModel>>> getTeams() async {
    return await apiClient.get(
      EndPoints.teams,
      functionName: 'admin_getTeams',
      converter: (data) {
        final List list = data is List ? data : (data['data'] ?? []);
        return list.map((e) => TeamModel.fromJson(e)).toList();
      },
    );
  }

  // ─────────────────────────── GET TASKS ────────────────────────────
  @override
  Future<ApiResult<List<TaskModel>>> getTasks() async {
    return await apiClient.get(
      EndPoints.tasks,
      functionName: 'admin_getTasks',
      converter: (data) {
        final List list = data is List ? data : (data['data'] ?? []);
        return list.map((e) => TaskModel.fromJson(e)).toList();
      },
    );
  }

  // ─────────────────────────── ADD POINTS ───────────────────────────
  @override
  Future<ApiResult<TeamModel>> addPoints({
    required int teamId,
    required int points,
    int? targetTeamToMinus,
  }) async {
    final queryParams = targetTeamToMinus != null
        ? '?points=$points&targetTeamToMinus=$targetTeamToMinus'
        : '?points=$points';

    return await apiClient.put(
      '${EndPoints.teams}/$teamId/addpoints$queryParams',
      functionName: 'admin_addPoints',
      converter: (data) => TeamModel.fromJson(data),
    );
  }

  // ─────────────────────────── CREATE TASK ──────────────────────────
  @override
  Future<ApiResult<TaskModel>> createTask({
    required String name,
    required String type,
    required String score,
  }) async {
    return await apiClient.post(
      EndPoints.tasks,
      functionName: 'admin_createTask',
      body: {'name': name, 'type': type, 'score': score},
      converter: (data) => TaskModel.fromJson(data),
    );
  }

  // ─────────────────────────── DELETE TASK ──────────────────────────
  @override
  Future<ApiResult<void>> deleteTask(int taskId) async {
    return await apiClient.delete(
      '${EndPoints.tasks}/$taskId',
      functionName: 'admin_deleteTask',
      converter: (data) {return data;},
    );
  }

  // ──────────────────────── ACTIVATE SUPERPOWER ─────────────────────
  @override
  Future<ApiResult<void>> activateSuperPower({
    required int teamId,
    required String type,
    int? targetTeamToFreeze,
    String? reActivatedType,
  }) async {
    return await apiClient.post(
      '${EndPoints.teams}/activate',
      functionName: 'admin_activateSuperPower',
      body: {
        'teamId': teamId,
        'type': type,
        if (targetTeamToFreeze != null) 'targetTeamToFreeze': targetTeamToFreeze,
        if (reActivatedType != null) 'reActivatedType': reActivatedType,
      },
      converter: (data) {
        return data;
      },
    );
  }

  // ─────────────────────── DEACTIVATE SUPERPOWER ────────────────────
  @override
  Future<ApiResult<void>> deactivateSuperPower({required int teamId}) async {
    return await apiClient.post(
      '${EndPoints.teams}/deactivate',
      functionName: 'admin_deactivateSuperPower',
      body: {'teamId': teamId},
      converter: (data) {
        return data;
      },
    );
  }
  // ═════════════════════════ NEW: CAR PROGRESS ═══════════════════════
  @override
  Future<ApiResult<TeamModel>> updateCarProgress({
    required int teamId,
    required double percentage,
  }) async {
    return await apiClient.put(
      EndPoints.carProgress(teamId),
      functionName: 'admin_updateCarProgress',
      body: {'percentage': percentage},
      converter: (data) => TeamModel.fromJson(data),
    );
  }

  // ═════════════════════════ NEW: BANK ════════════════════════════════
  @override
  Future<ApiResult<List<BankCertificateModel>>> getBankCertificates() async {
    return await apiClient.get(
      EndPoints.bankCertificates,
      functionName: 'admin_getBankCertificates',
      converter: (data) {
        final List list = data is List ? data : (data['data'] ?? []);
        return list.map((e) => BankCertificateModel.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<ApiResult<BankCertificateModel>> createBankCertificate({
    required int durationMinutes,
    required double percentageGain,
  }) async {
    return await apiClient.post(
      EndPoints.bankCertificates,
      functionName: 'admin_createBankCertificate',
      body: {
        'durationMinutes': durationMinutes,
        'percentageGain': percentageGain,
      },
      converter: (data) => BankCertificateModel.fromJson(data),
    );
  }

  @override
  Future<ApiResult<void>> deleteBankCertificate(int certificateId) async {
    return await apiClient.delete(
      EndPoints.bankCertificateById(certificateId),
      functionName: 'admin_deleteBankCertificate',
      converter: (data) {
        return data;
      },
    );
  }

  @override
  Future<ApiResult<double>> updateTeamBankBalance({
    required int teamId,
    double? newBalance,
    double? delta,
  }) async {
    return await apiClient.put(
      EndPoints.teamBankBalance(teamId),
      functionName: 'admin_updateTeamBankBalance',
      body: {
        if (newBalance != null) 'newBalance': newBalance,
        if (delta != null) 'delta': delta,
      },
      converter: (data) => (data['bankBalance'] as num).toDouble(),
    );
  }

  // ═════════════════════════ NEW: UNIVERSITY ══════════════════════════
  @override
  Future<ApiResult<int>> updateAttendeeCount({
    int? count,
    int? delta,
  }) async {
    return await apiClient.put(
      EndPoints.universityAttendees,
      functionName: 'admin_updateAttendeeCount',
      body: {
        if (count != null) 'count': count,
        if (delta != null) 'delta': delta,
      },
      converter: (data) => data['attendeeCount'] as int,
    );
  }

  // ═════════════════════════ NEW: EVENT CONFIG ════════════════════════
  @override
  Future<ApiResult<EventConfigModel>> getEventConfig() async {
    return await apiClient.get(
      EndPoints.eventConfig,
      functionName: 'admin_getEventConfig',
      converter: (data) => EventConfigModel.fromJson(data),
    );
  }

  @override
  Future<ApiResult<EventConfigModel>> updateEventConfig({
    required String eventName,
    required DateTime eventStartTime,
    required int eventDurationHours,
    required DateTime raceStartTime,
  }) async {
    return await apiClient.put(
      EndPoints.eventConfig,
      functionName: 'admin_updateEventConfig',
      body: {
        'eventName': eventName,
        'eventStartTime': eventStartTime.toIso8601String(),
        'eventDurationHours': eventDurationHours,
        'raceStartTime': raceStartTime.toIso8601String(),
      },
      converter: (data) => EventConfigModel.fromJson(data),
    );
  }
}
