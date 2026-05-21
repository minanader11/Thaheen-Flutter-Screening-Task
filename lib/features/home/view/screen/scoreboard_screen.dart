import 'package:base_project/core/get_it/injection.dart';
import 'package:base_project/features/home/view_model/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/state.dart';
import '../widgets/header_section.dart';
import '../widgets/teams_grid_section.dart';
import '../widgets/tasks_bottom_section.dart';

class ScoreboardScreen extends StatefulWidget {
  const ScoreboardScreen({super.key});

  @override
  State<ScoreboardScreen> createState() => _ScoreboardScreenState();
}

class _ScoreboardScreenState extends State<ScoreboardScreen> {
  @override
  void initState() {
    super.initState();
   // context.read<HomeCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF0F172A),
      body: BlocProvider<HomeCubit>(create: (context) => getIt<HomeCubit>()..init(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.isLoading && state.teams.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF5BA3D0)),
              );
            }
            return Column(
              children: [
                // ── Header ──────────────────────────────────────
                HeaderSection(
                  eventName: state.eventName,
                  currentDay: state.currentDay,
                  totalDays: state.totalDays,
                  isConnected: state.isConnected,
                ),
                // ── Teams Grid ───────────────────────────────────
                Expanded(
                  flex: 100,
                  child: TeamsGridSection(teams: state.teams),
                ),
                // ── Tasks Bottom ─────────────────────────────────
                Expanded(
                  flex: 40,
                  child: TasksBottomSection(
                    dailyTasks: state.dailyTasks,
                    bonusTasks: state.bonusTasks,
                    flashTasks: state.flashTasks,
                  ),
                ),
                // SizedBox(height: 8.h),
              ],
            );
          },
        ),
      ),
    );
  }
}
