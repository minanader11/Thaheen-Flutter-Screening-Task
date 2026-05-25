import 'package:LJF_admin/core/networking/api_result/api_result.dart';
import 'package:LJF_admin/features/admin/model/task_model.dart';
import 'package:LJF_admin/features/admin/model/team_model.dart';


abstract class AdminRepo {
  Future<ApiResult<List<TeamModel>>> getTeams();
  Future<ApiResult<List<TaskModel>>> getTasks();

  /// Add or subtract points. Optionally minus a target team if Minus power is active.
  Future<ApiResult<TeamModel>> addPoints({
    required int teamId,
    required int points,
    int? targetTeamToMinus,
  });

  /// Create a new task (Daily / Bonus / Flash).
  Future<ApiResult<TaskModel>> createTask({
    required String name,
    required String type,
    required String score,
  });

  /// Delete a task by id.
  Future<ApiResult<void>> deleteTask(int taskId);

  /// Activate a superpower for a team.
  Future<ApiResult<void>> activateSuperPower({
    required int teamId,
    required String type, // e.g. "TaxCollector"
  });

  /// Deactivate the currently active superpower for a team.
  Future<ApiResult<void>> deactivateSuperPower({required int teamId});
}
