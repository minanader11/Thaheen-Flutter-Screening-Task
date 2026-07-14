import 'package:LJF_admin/core/networking/api_result/api_result.dart';
import 'package:LJF_admin/features/admin/model/bank_certificate_model.dart';
import 'package:LJF_admin/features/admin/model/event_config_model.dart';
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
  /// • [targetTeamToFreeze] — required when [type] == 'freezer'
  /// • [reActivatedType]    — required when [type] == 'reActivation'
  Future<ApiResult<void>> activateSuperPower({
    required int teamId,
    required String type,
    int? targetTeamToFreeze,
    String? reActivatedType,
  });

  /// Deactivate the currently active superpower for a team.
  Future<ApiResult<void>> deactivateSuperPower({required int teamId});


  // ── New: Car progress ──────────────────────────────────────
  Future<ApiResult<TeamModel>> updateCarProgress({
    required int teamId,
    required double percentage,
  });

  // ── New: Bank ────────────────────────────────────────────────
  Future<ApiResult<List<BankCertificateModel>>> getBankCertificates();

  Future<ApiResult<BankCertificateModel>> createBankCertificate({
    required int durationMinutes,
    required double percentageGain,
  });

  Future<ApiResult<void>> deleteBankCertificate(int certificateId);

  Future<ApiResult<double>> updateTeamBankBalance({
    required int teamId,
    double? newBalance,
    double? delta,
  });

  // ── New: University ─────────────────────────────────────────
  Future<ApiResult<int>> updateAttendeeCount({
    int? count,
    int? delta,
  });

  // ── New: Event config ───────────────────────────────────────
  Future<ApiResult<EventConfigModel>> getEventConfig();

  Future<ApiResult<EventConfigModel>> updateEventConfig({
    required String eventName,
    required DateTime eventStartTime,
    required int eventDurationHours,
    required DateTime raceStartTime,
  });
}