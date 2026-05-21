import 'package:base_project/core/config/end_points.dart';
import 'package:base_project/core/networking/api_client/api_client.dart';
import 'package:base_project/core/networking/api_result/api_result.dart';
import 'package:base_project/features/home/model/task_model.dart';
import 'package:base_project/features/home/model/team_model.dart';
import 'package:base_project/features/home/repo/home_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final ApiClient apiClient;

  HomeRepoImpl({
    required this.apiClient,
  });

  // ================= GET TEAMS =================

  @override
  Future<ApiResult<List<TeamModel>>> getTeams() async {
    return await apiClient.get(
      EndPoints.teams,
      functionName: "getTeams",
      converter: (data) {
        final List list = data is List
            ? data
            : (data['data'] ?? []);

        return list
            .map(
              (e) => TeamModel.fromJson(e),
        )
            .toList();
      },
    );
  }

  // ================= GET TASKS =================

  @override
  Future<ApiResult<List<TaskModel>>> getTasks() async {
    return await apiClient.get(
      EndPoints.tasks,
      functionName: "getTasks",
      converter: (data) {
        final List list = data is List
            ? data
            : (data['data'] ?? []);

        return list
            .map(
              (e) => TaskModel.fromJson(e),
        )
            .toList();
      },
    );
  }
}