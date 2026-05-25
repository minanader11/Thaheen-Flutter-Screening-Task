import 'package:LJF_admin/features/admin/model/task_model.dart';
import 'package:LJF_admin/features/admin/model/team_model.dart';
import 'package:equatable/equatable.dart';


enum AdminActionStatus { initial, loading, success, failure }

class AdminState extends Equatable {
  final List<TeamModel> teams;
  final List<TaskModel> dailyTasks;
  final List<TaskModel> bonusTasks;
  final List<TaskModel> flashTasks;

  final bool isLoading;
  final bool isConnected;
  final String errorMessage;

  // Per-action states
  final AdminActionStatus addPointsStatus;
  final AdminActionStatus createTaskStatus;
  final AdminActionStatus deleteTaskStatus;
  final AdminActionStatus activatePowerStatus;
  final AdminActionStatus deactivatePowerStatus;

  const AdminState({
    this.teams = const [],
    this.dailyTasks = const [],
    this.bonusTasks = const [],
    this.flashTasks = const [],
    this.isLoading = false,
    this.isConnected = false,
    this.errorMessage = '',
    this.addPointsStatus = AdminActionStatus.initial,
    this.createTaskStatus = AdminActionStatus.initial,
    this.deleteTaskStatus = AdminActionStatus.initial,
    this.activatePowerStatus = AdminActionStatus.initial,
    this.deactivatePowerStatus = AdminActionStatus.initial,
  });

  AdminState copyWith({
    List<TeamModel>? teams,
    List<TaskModel>? dailyTasks,
    List<TaskModel>? bonusTasks,
    List<TaskModel>? flashTasks,
    bool? isLoading,
    bool? isConnected,
    String? errorMessage,
    AdminActionStatus? addPointsStatus,
    AdminActionStatus? createTaskStatus,
    AdminActionStatus? deleteTaskStatus,
    AdminActionStatus? activatePowerStatus,
    AdminActionStatus? deactivatePowerStatus,
  }) {
    return AdminState(
      teams: teams ?? this.teams,
      dailyTasks: dailyTasks ?? this.dailyTasks,
      bonusTasks: bonusTasks ?? this.bonusTasks,
      flashTasks: flashTasks ?? this.flashTasks,
      isLoading: isLoading ?? this.isLoading,
      isConnected: isConnected ?? this.isConnected,
      errorMessage: errorMessage ?? this.errorMessage,
      addPointsStatus: addPointsStatus ?? this.addPointsStatus,
      createTaskStatus: createTaskStatus ?? this.createTaskStatus,
      deleteTaskStatus: deleteTaskStatus ?? this.deleteTaskStatus,
      activatePowerStatus: activatePowerStatus ?? this.activatePowerStatus,
      deactivatePowerStatus:
          deactivatePowerStatus ?? this.deactivatePowerStatus,
    );
  }

  @override
  List<Object?> get props => [
        teams,
        dailyTasks,
        bonusTasks,
        flashTasks,
        isLoading,
        isConnected,
        errorMessage,
        addPointsStatus,
        createTaskStatus,
        deleteTaskStatus,
        activatePowerStatus,
        deactivatePowerStatus,
      ];
}
