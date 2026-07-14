import 'dart:developer';

import 'package:LJF_admin/core/styles/colors.dart';
import 'package:LJF_admin/core/styles/styles.dart';

import 'package:LJF_admin/core/widgets/other/custom_text.dart';
import 'package:LJF_admin/features/admin/model/team_model.dart';
import 'package:LJF_admin/features/admin/view/widgets/bank_certificate_section.dart';
import 'package:LJF_admin/features/admin/view/widgets/create_bank_certificate_sheet.dart';
import 'package:LJF_admin/features/admin/view/widgets/university_event_section.dart';
import 'package:LJF_admin/features/admin/view/widgets/tasks_list_section.dart';
import 'package:LJF_admin/features/admin/view/widgets/update_bank_balance_sheet.dart';
import 'package:LJF_admin/features/admin/view/widgets/update_car_progress_sheet.dart';
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
    _tabController = TabController(length: 4, vsync: this);
    context.read<AdminCubit>().init();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ── Action handlers ────────────────────────────────────

  void _showAddPoints(BuildContext context, TeamModel team) {
    final cubit = context.read<AdminCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddPointsSheet(
          team: team,
          allTeams: cubit.state.teams,
          onConfirm: ({
            required int teamId,
            required int points,
            int? targetTeamToMinus,
          }) {
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

  void _showManagePowers(BuildContext context, TeamModel team) {
    final cubit = context.read<AdminCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ManagePowersSheet(
          team: team,
          allTeams: cubit.state.teams,
          onActivate: (
              String type, {
                int? targetTeamToFreeze,
                String? reActivatedType,
              }) {
            cubit.activateSuperPower(
              teamId: team.id,
              type: type,
              targetTeamToFreeze: targetTeamToFreeze,
              reActivatedType: reActivatedType,
            );
          },
          onDeactivate: () => cubit.deactivateSuperPower(team.id),
        ),
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
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: CreateTaskSheet(
          onConfirm: ({required name, required type, required score}) {
            cubit.createTask(name: name, type: type, score: score);
          },
        ),
      ),
    );
  }

  // ── New: Car progress ──────────────────────────────────
  void _showUpdateCarProgress(BuildContext context, TeamModel team) {
    final cubit = context.read<AdminCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => UpdateCarProgressSheet(
        team: team,
        onConfirm: (percentage) {
          cubit.updateCarProgress(teamId: team.id, percentage: percentage);
        },
      ),
    );
  }

  // ── New: Bank balance ──────────────────────────────────
  void _showUpdateBankBalance(BuildContext context, TeamModel team) {
    final cubit = context.read<AdminCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: UpdateBankBalanceSheet(
          team: team,
          onConfirm: ({newBalance, delta}) {
            cubit.updateTeamBankBalance(
              teamId: team.id,
              newBalance: newBalance,
              delta: delta,
            );
          },
        ),
      ),
    );
  }

  // ── New: Create bank certificate ───────────────────────
  void _showCreateBankCertificate(BuildContext context) {
    final cubit = context.read<AdminCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: CreateBankCertificateSheet(
          onConfirm: ({required durationMinutes, required percentageGain}) {
            cubit.createBankCertificate(
              durationMinutes: durationMinutes,
              percentageGain: percentageGain,
            );
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
          final failureStates = [
            state.addPointsStatus,
            state.createTaskStatus,
            state.deleteTaskStatus,
            state.activatePowerStatus,
            state.deactivatePowerStatus,
            state.updateCarProgressStatus,
            state.updateBankBalanceStatus,
            state.createBankCertificateStatus,
            state.deleteBankCertificateStatus,
            state.updateAttendeeCountStatus,
            state.updateEventConfigStatus,
          ];
          if (state.errorMessage.isNotEmpty &&
              failureStates.contains(AdminActionStatus.failure)) {
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
                  onAddPoints: (team) => _showAddPoints(context, team),
                  onManagePowers: (team) => _showManagePowers(context, team),
                  onUpdateCarProgress: (team) => _showUpdateCarProgress(context, team),
                  onUpdateBankBalance: (team) => _showUpdateBankBalance(context, team),
                ),

                // ── Tab 2 : Tasks ────────────────────────
                _TasksTab(
                  state: state,
                  onDelete: context.read<AdminCubit>().deleteTask,
                ),

                // ── Tab 3 : Bank ──────────────────────────
                _BankTab(
                  state: state,
                  onAddCertificate: () => _showCreateBankCertificate(context),
                  onDeleteCertificate: context.read<AdminCubit>().deleteBankCertificate,
                ),

                // ── Tab 4 : University / Event ───────────
                _EventTab(state: state),
              ],
            ),
          );
        },
      ),

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
        isScrollable: true,
        indicatorColor: ColorManager.primary,
        indicatorWeight: 2.5,
        labelColor: ColorManager.primary,
        unselectedLabelColor: Colors.white38,
        tabs: [
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.groups_outlined, size: 16.r),
                SizedBox(width: 6.w),
                CustomText(text: 'Teams (${state.teams.length})', style: TextStyles.font13WhiteMedium),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.task_outlined, size: 16.r),
                SizedBox(width: 6.w),
                CustomText(
                  text: 'Tasks (${state.dailyTasks.length + state.bonusTasks.length + state.flashTasks.length})',
                  style: TextStyles.font13WhiteMedium,
                ),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.account_balance_rounded, size: 16.r),
                SizedBox(width: 6.w),
                CustomText(text: 'Bank', style: TextStyles.font13WhiteMedium),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.event_rounded, size: 16.r),
                SizedBox(width: 6.w),
                CustomText(text: 'Event', style: TextStyles.font13WhiteMedium),
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
  final void Function(TeamModel team) onAddPoints;
  final void Function(TeamModel team) onManagePowers;
  final void Function(TeamModel team) onUpdateCarProgress;
  final void Function(TeamModel team) onUpdateBankBalance;

  const _TeamsTab({
    required this.state,
    required this.onAddPoints,
    required this.onManagePowers,
    required this.onUpdateCarProgress,
    required this.onUpdateBankBalance,
  });

  @override
  Widget build(BuildContext context) {
    if (state.teams.isEmpty) {
      return Center(
        child: CustomText(
          text: 'No teams loaded',
          style: TextStyles.font14WhiteBold.copyWith(color: Colors.white30),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
      itemCount: state.teams.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (_, i) {
        final team = state.teams[i];
        return AdminTeamCard(
          team: team,
          rank: i + 1,
          onAddPoints: () => onAddPoints(team),
          onManagePowers: () => onManagePowers(team),
          onUpdateCarProgress: () => onUpdateCarProgress(team),
          onUpdateBankBalance: () => onUpdateBankBalance(team),
        );
      },
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

// ═══════════════════════════════════════════════════════════
// Bank tab
// ═══════════════════════════════════════════════════════════

class _BankTab extends StatelessWidget {
  final AdminState state;
  final VoidCallback onAddCertificate;
  final void Function(int id) onDeleteCertificate;

  const _BankTab({
    required this.state,
    required this.onAddCertificate,
    required this.onDeleteCertificate,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
      child: BankCertificatesSection(
        certificates: state.bankCertificates,
        onAdd: onAddCertificate,
        onDelete: onDeleteCertificate,
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Event / University tab
// ═══════════════════════════════════════════════════════════

class _EventTab extends StatelessWidget {
  final AdminState state;

  const _EventTab({required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdminCubit>();

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
      child: UniversityEventSection(
        attendeeCount: state.attendeeCount,
        eventConfig: state.eventConfig,
        onIncrementAttendee: cubit.incrementAttendeeCount,
        onSetAttendeeCount: cubit.setAttendeeCount,
        onSetRaceStartTime: (raceStartTime) {
          final config = state.eventConfig;
          cubit.updateEventConfig(
            eventName: config?.eventName ?? 'Bezradoor',
            eventStartTime: config?.eventStartTime ?? DateTime.now(),
            eventDurationHours: config?.eventDurationHours ?? 5,
            raceStartTime: raceStartTime,
          );
        },
      ),
    );
  }
}