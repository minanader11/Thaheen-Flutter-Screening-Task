// import 'package:base_project/core/get_it/injection.dart';
// import 'package:base_project/core/styles/colors.dart';
// import 'package:base_project/features/home/view/widgets/bonus_task_section.dart';
// import 'package:base_project/features/home/view/widgets/daily_task_section.dart';
// import 'package:base_project/features/home/view/widgets/flash_challenge.dart';
// import 'package:base_project/features/home/view/widgets/header_section.dart';
// import 'package:base_project/features/home/view/widgets/team_grid_Section.dart';
//
// import 'package:base_project/features/home/view_model/cubit.dart';
// import 'package:base_project/features/home/view_model/state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
//
// class ScoreboardScreen extends StatefulWidget {
//   const ScoreboardScreen({super.key});
//
//   @override
//   State<ScoreboardScreen> createState() => _ScoreboardScreenState();
// }
//
// class _ScoreboardScreenState extends State<ScoreboardScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // context.read<HomeCubit>().init();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorManager.background,
//       body: BlocProvider<HomeCubit>(create: (context) => getIt<HomeCubit>()..init(),
//         child: BlocBuilder<HomeCubit, HomeState>(
//           builder: (context, state) {
//             if (state.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }
//
//             return Column(
//               children: [
//                 // Header
//                 HeaderSection(
//                   eventName: state.eventName,
//                   currentDay: state.currentDay,
//                   totalDays: state.totalDays,
//                 ),
//
//                 // Teams Grid (Top 50%)
//                 Expanded(
//                   flex: 5,
//                   child: TeamsGridSection(teams: state.teams),
//                 ),
//
//                // Bottom Tasks Section (~45%)
//                 Expanded(
//                   flex: 4,
//                   child: Padding(
//                     padding: EdgeInsets.all(20.w),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: DailyTasksSection(tasks: state.dailyTasks),
//                         ),
//                         SizedBox(width: 16.w),
//                         Expanded(
//                           child: BonusTasksSection(tasks: state.bonusTasks),
//                         ),
//                         SizedBox(width: 16.w),
//                         Expanded(
//                           child: FlashChallengesSection(tasks: state.flashTasks),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }