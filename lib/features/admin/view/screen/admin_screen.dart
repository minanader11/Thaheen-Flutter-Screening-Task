import 'dart:developer';

import 'package:LJF_admin/core/styles/colors.dart';
import 'package:LJF_admin/core/styles/styles.dart';

import 'package:LJF_admin/core/widgets/other/custom_text.dart';
import 'package:LJF_admin/features/admin/view/widgets/tasks_list_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view_model/admin_cubit.dart';
import '../../view_model/admin_state.dart';
import '../widgets/add_points_sheet.dart';
import '../widgets/admin_team_card.dart';
import '../widgets/create_task_sheet.dart';
import '../widgets/manage_powers_sheet.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<AdminCubit>().init();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ── Action handlers ────────────────────────────────────
  void _showAddPoints(BuildContext context, int index) {
    final cubit = context.read<AdminCubit>();
    final state = cubit.state;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: AddPointsSheet(
          team: state.teams[index],
          allTeams: state.teams,
          onConfirm: ({required teamId, required points, targetTeamToMinus}) {
            cubit.addPoints(
              teamId: teamId,
              points: points,
              targetTeamToMinus: targetTeamToMinus,
            );
          },
        ),
      ),
    );
  }

  void _showManagePowers(BuildContext context, int index) {
    final cubit = context.read<AdminCubit>();
    final team = cubit.state.teams[index];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ManagePowersSheet(
        team: team,
        onActivate: (type) => cubit.activateSuperPower(
          teamId: team.id,
          type: type,
        ),
        onDeactivate: () => cubit.deactivateSuperPower(team.id),
      ),
    );
  }

  void _showCreateTask(BuildContext context) {
    final cubit = context.read<AdminCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: CreateTaskSheet(
          onConfirm: ({required name, required type, required score}) {
            cubit.createTask(name: name, type: type, score: score);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07111E),
      body: BlocConsumer<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty &&
              (state.addPointsStatus == AdminActionStatus.failure ||
                  state.createTaskStatus == AdminActionStatus.failure ||
                  state.deleteTaskStatus == AdminActionStatus.failure ||
                  state.activatePowerStatus == AdminActionStatus.failure ||
                  state.deactivatePowerStatus == AdminActionStatus.failure)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        builder: (context, state) {
          log("stateeeeeeeeee ${state.isLoading}");
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          }

          return NestedScrollView(
            headerSliverBuilder: (context, _) => [
              _buildSliverAppBar(state),
            ],
            body: TabBarView(
              controller: _tabController,
              children: [
                // ── Tab 1 : Teams ────────────────────────
                _TeamsTab(
                  state: state,
                  onAddPoints: (i) => _showAddPoints(context, i),
                  onManagePowers: (i) => _showManagePowers(context, i),
                ),

                // ── Tab 2 : Tasks ────────────────────────
                _TasksTab(
                  state: state,
                  onDelete: context.read<AdminCubit>().deleteTask,
                ),
              ],
            ),
          );
        },
      ),

      // FAB — only show on Tasks tab
      floatingActionButton: AnimatedBuilder(
        animation: _tabController,
        builder: (_, __) => _tabController.index == 1
            ? FloatingActionButton.extended(
                onPressed: () => _showCreateTask(context),
                backgroundColor: ColorManager.primary,
                icon: const Icon(Icons.add, color: Colors.white),
                label: CustomText(
                  text: 'New Task',
                  style: TextStyles.font13WhiteMedium,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(AdminState state) {
    return SliverAppBar(
      backgroundColor: const Color(0xFF07111E),
      expandedHeight: 110.h,
      floating: false,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 56.h),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Admin Panel',
              style: TextStyles.font20WhiteBold.copyWith(fontSize: 18.sp),
            ),
            Row(
              children: [
                Container(
                  width: 7.r,
                  height: 7.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: state.isConnected
                        ? Colors.greenAccent
                        : Colors.redAccent,
                  ),
                ),
                SizedBox(width: 4.w),
                CustomText(
                  text: state.isConnected ? 'Live' : 'Disconnected',
                  style: TextStyles.font11WhiteBold.copyWith(
                    color: state.isConnected
                        ? Colors.greenAccent
                        : Colors.redAccent,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: ColorManager.primary,
        indicatorWeight: 2.5,
        labelColor: ColorManager.primary,
        unselectedLabelColor: Colors.white38,
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.groups_outlined, size: 16.r),
                SizedBox(width: 6.w),
                CustomText(
                  text: 'Teams (${state.teams.length})',
                  style: TextStyles.font13WhiteMedium,
                ),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.task_outlined, size: 16.r),
                SizedBox(width: 6.w),
                CustomText(
                  text:
                      'Tasks (${state.dailyTasks.length + state.bonusTasks.length + state.flashTasks.length})',
                  style: TextStyles.font13WhiteMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Teams tab
// ═══════════════════════════════════════════════════════════

class _TeamsTab extends StatelessWidget {
  final AdminState state;
  final void Function(int index) onAddPoints;
  final void Function(int index) onManagePowers;

  const _TeamsTab({
    required this.state,
    required this.onAddPoints,
    required this.onManagePowers,
  });

  @override
  Widget build(BuildContext context) {
    if (state.teams.isEmpty) {
      return Center(
        child: CustomText(
          text: 'No teams loaded',
          style:
              TextStyles.font14WhiteBold.copyWith(color: Colors.white30),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
      itemCount: state.teams.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (_, i) => AdminTeamCard(
        team: state.teams[i],
        rank: i + 1,
        onAddPoints: () => onAddPoints(i),
        onManagePowers: () => onManagePowers(i),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Tasks tab
// ═══════════════════════════════════════════════════════════

class _TasksTab extends StatelessWidget {
  final AdminState state;
  final void Function(int id) onDelete;

  const _TasksTab({required this.state, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
      child: TasksListSection(
        dailyTasks: state.dailyTasks,
        bonusTasks: state.bonusTasks,
        flashTasks: state.flashTasks,
        onDeleteTask: onDelete,
      ),
    );
  }
}
