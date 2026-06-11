import 'package:LJF_admin/core/styles/colors.dart';
import 'package:LJF_admin/core/styles/styles.dart';
import 'package:LJF_admin/core/widgets/other/custom_text.dart';
import 'package:LJF_admin/features/admin/model/team_model.dart';
import 'package:LJF_admin/features/admin/model/team_super_power_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Bottom sheet for adding points to a team.
///
/// Automatically surfaces extra pickers based on active superpowers:
///   • Minus active   → target-team dropdown (who loses points)
///   • (Freezer / ReActivation are handled in ManagePowersSheet, not here)
class AddPointsSheet extends StatefulWidget {
  final TeamModel team;
  final List<TeamModel> allTeams;
  final void Function({
  required int teamId,
  required int points,
  int? targetTeamToMinus,
  }) onConfirm;

  const AddPointsSheet({
    super.key,
    required this.team,
    required this.allTeams,
    required this.onConfirm,
  });

  @override
  State<AddPointsSheet> createState() => _AddPointsSheetState();
}

class _AddPointsSheetState extends State<AddPointsSheet> {
  final TextEditingController _pointsCtrl = TextEditingController();
  int? _selectedTargetId;

  // ── helpers ────────────────────────────────────────────────────────

  /// True when the team's Minus superpower is currently Activated.
  bool get _minusActive => widget.team.teamSuperPowers.any(
        (p) =>
    p.type == SuperPowerType.minus &&
        p.status == SuperPowerStatus.activated,
  );

  List<TeamModel> get _otherTeams =>
      widget.allTeams.where((t) => t.id != widget.team.id).toList();

  @override
  void dispose() {
    _pointsCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final pts = int.tryParse(_pointsCtrl.text.trim());
    if (pts == null || pts <= 0) return;

    // If Minus is active, a target team must be selected before submitting.
    if (_minusActive && _selectedTargetId == null) return;

    widget.onConfirm(
      teamId: widget.team.id,
      points: pts,
      targetTeamToMinus: _minusActive ? _selectedTargetId : null,
    );

    Navigator.pop(context);
  }

  // ── build ──────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 32.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1D2E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── handle bar ─────────────────────────────────────────────
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // ── title ──────────────────────────────────────────────────
          CustomText(
            text: 'Add Points — ${widget.team.name}',
            style: TextStyles.font16WhiteBold,
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: 'Current score: ${widget.team.score}',
            style: TextStyles.font12WhiteMedium.copyWith(
              color: Colors.white54,
            ),
          ),

          // ── active-power badges ────────────────────────────────────
          _ActivePowerBadges(team: widget.team),

          SizedBox(height: 20.h),

          // ── points input ───────────────────────────────────────────
          _buildLabel('Points to add'),
          SizedBox(height: 6.h),
          TextField(
            controller: _pointsCtrl,
            keyboardType: TextInputType.number,
            style: TextStyles.font16WhiteBold,
            decoration: _inputDecoration('e.g. 50'),
          ),

          // ── Minus: target-team picker ──────────────────────────────
          if (_minusActive) ...[
            SizedBox(height: 16.h),
            Row(
              children: [
                Icon(
                  Icons.remove_circle_outline,
                  color: const Color(0xFFFF4D4D),
                  size: 16.r,
                ),
                SizedBox(width: 4.w),
                CustomText(
                  text: 'Minus active — select team to deduct from',
                  style: TextStyles.font12WhiteMedium.copyWith(
                    color: const Color(0xFFFF4D4D),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            DropdownButtonFormField<int>(
              value: _selectedTargetId,
              dropdownColor: const Color(0xFF0F1D2E),
              style: TextStyles.font13WhiteMedium,
              decoration: _inputDecoration('Select team'),
              items: _otherTeams
                  .map(
                    (t) => DropdownMenuItem(
                  value: t.id,
                  child: Text(t.name),
                ),
              )
                  .toList(),
              onChanged: (v) => setState(() => _selectedTargetId = v),
            ),
          ],

          SizedBox(height: 24.h),

          // ── confirm button ─────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.tertiary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: CustomText(
                text: 'Confirm',
                style: TextStyles.font16WhiteBold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) => CustomText(
    text: text,
    style: TextStyles.font12WhiteMedium.copyWith(color: Colors.white60),
  );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    hintStyle:
    TextStyles.font13WhiteMedium.copyWith(color: Colors.white30),
    filled: true,
    fillColor: Colors.white.withOpacity(0.05),
    contentPadding:
    EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(color: Colors.white12),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(color: Colors.white12),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(color: ColorManager.primary, width: 1.5),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Small widget that shows which powers are currently active on this team
// so the admin can see at a glance what modifiers will apply.
// ─────────────────────────────────────────────────────────────────────────────

class _ActivePowerBadges extends StatelessWidget {
  final TeamModel team;

  const _ActivePowerBadges({required this.team});

  static const _meta = {
    SuperPowerType.taxCollector: (
    label: 'Tax Collector',
    color: Color(0xFFFFD700),
    icon: Icons.account_balance,
    ),
    SuperPowerType.doublePoints: (
    label: 'Double Points',
    color: Color(0xFF3A86FF),
    icon: Icons.bolt,
    ),
    SuperPowerType.minus: (
    label: 'Minus',
    color: Color(0xFFFF4D4D),
    icon: Icons.remove_circle_outline,
    ),
    SuperPowerType.freezer: (
    label: 'Freezer',
    color: Color(0xFF00CFFF),
    icon: Icons.ac_unit,
    ),
    SuperPowerType.reActivation: (
    label: 'Re-Activation',
    color: Color(0xFFB97BFF),
    icon: Icons.replay_circle_filled,
    ),
    SuperPowerType.dice: (
    label: 'Dice',
    color: Color(0xFFFF8C42),
    icon: Icons.casino,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final activePowers = team.teamSuperPowers
        .where((p) => p.status == SuperPowerStatus.activated)
        .toList();

    if (activePowers.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 6.h,
        children: activePowers.map((p) {
          final m = _meta[p.type];
          if (m == null) return const SizedBox.shrink();
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: m.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: m.color.withOpacity(0.5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(m.icon, color: m.color, size: 12.r),
                SizedBox(width: 4.w),
                Text(
                  m.label,
                  style: TextStyle(
                    color: m.color,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}