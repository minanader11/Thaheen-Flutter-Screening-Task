import 'package:equatable/equatable.dart';

import '../model/task_model.dart';
import '../model/team_model.dart';

class HomeState extends Equatable {
  final List<TeamModel> teams;
  final List<TaskModel> dailyTasks;
  final List<TaskModel> bonusTasks;
  final List<TaskModel> flashTasks;

  final bool isLoading;
  final bool isConnected;
  final String errorMessage;
  final String eventName;
  final int currentDay;
  final int totalDays;

  const HomeState({
    this.teams = const [],
    this.dailyTasks = const [],
    this.bonusTasks = const [],
    this.flashTasks = const [],
    this.isLoading = false,
    this.isConnected = false,
    this.errorMessage = '',
    this.eventName = "Logos Junior Forum",
    this.currentDay = 3,
    this.totalDays = 7,
  });

  HomeState copyWith({
    List<TeamModel>? teams,
    List<TaskModel>? dailyTasks,
    List<TaskModel>? bonusTasks,
    List<TaskModel>? flashTasks,
    bool? isLoading,
    bool? isConnected,
    String? errorMessage,
    String? eventName,
    int? currentDay,
    int? totalDays,
  }) {
    return HomeState(
      teams: teams ?? this.teams,
      dailyTasks: dailyTasks ?? this.dailyTasks,
      bonusTasks: bonusTasks ?? this.bonusTasks,
      flashTasks: flashTasks ?? this.flashTasks,
      isLoading: isLoading ?? this.isLoading,
      isConnected: isConnected ?? this.isConnected,
      errorMessage: errorMessage ?? this.errorMessage,
      eventName: eventName ?? this.eventName,
      currentDay: currentDay ?? this.currentDay,
      totalDays: totalDays ?? this.totalDays,
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
    eventName,
    currentDay,
    totalDays,
  ];
} 