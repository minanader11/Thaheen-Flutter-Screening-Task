import 'package:base_project/core/networking/api_result/api_result.dart';
import 'package:base_project/features/home/model/task_model.dart';
import 'package:base_project/features/home/model/team_model.dart';

abstract class HomeRepo {
  Future<ApiResult<List<TeamModel>>> getTeams();

  Future<ApiResult<List<TaskModel>>> getTasks();
}