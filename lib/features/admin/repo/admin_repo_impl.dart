import 'package:base_project/core/config/end_points.dart';
import 'package:base_project/core/networking/api_client/api_client.dart';
import 'package:base_project/core/networking/api_result/api_result.dart';
import 'package:base_project/features/admin/model/task_model.dart';
import 'package:base_project/features/admin/model/team_model.dart';

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
      converter: (_) {},
    );
  }

  // ──────────────────────── ACTIVATE SUPERPOWER ─────────────────────
  @override
  Future<ApiResult<void>> activateSuperPower({
    required int teamId,
    required String type,
  }) async {
    return await apiClient.post(
      '${EndPoints.teams}/activate',
      functionName: 'admin_activateSuperPower',
      body: {'teamId': teamId, 'type': type},
      converter: (_) {},
    );
  }

  // ─────────────────────── DEACTIVATE SUPERPOWER ────────────────────
  @override
  Future<ApiResult<void>> deactivateSuperPower({required int teamId}) async {
    return await apiClient.post(
      '${EndPoints.teams}/deactivate',
      functionName: 'admin_deactivateSuperPower',
      body: {'teamId': teamId},
      converter: (_) {},
    );
  }
}
