import 'dart:developer';

import 'package:LJF_admin/core/styles/styles.dart';
import 'package:LJF_admin/core/widgets/other/custom_text.dart';
import 'package:LJF_admin/features/admin/model/team_model.dart';
import 'package:LJF_admin/features/admin/model/team_super_power_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shows all superpowers for a team and allows activating / deactivating.
///
/// [onActivate] now carries optional extra params:
///   • [targetTeamToFreeze] — required when type == 'Freezer'
///   • [reActivatedType]    — required when type == 'ReActivation'
class ManagePowersSheet extends StatefulWidget {
  final TeamModel team;
  final List<TeamModel> allTeams; // ← NEW: needed for Freezer & ReActivation pickers
  final void Function(
      String type, {
      int? targetTeamToFreeze,
      String? reActivatedType,
      }) onActivate;
  final VoidCallback onDeactivate;

  const ManagePowersSheet({
    super.key,
    required this.team,
    required this.allTeams,
    required this.onActivate,
    required this.onDeactivate,
  });

  @override
  State<ManagePowersSheet> createState() => _ManagePowersSheetState();
}

class _ManagePowersSheetState extends State<ManagePowersSheet> {
  // ── picker state ───────────────────────────────────────────────────
  /// Which power tile is currently expanded (showing its extra picker).
  String? _expandedType;

  /// Freezer: target team to freeze.
  int? _freezeTargetId;

  /// ReActivation: which used power to re-activate.
  String? _reActivateType;

  // ── metadata ───────────────────────────────────────────────────────
  static const _powerMeta = {
    'taxCollector': (
    icon: Icons.account_balance,
    label: 'Tax Collector',
    desc: "10% of every rival's points go to you",
    color: Color(0xFFFFD700),
    ),
    'doublePoints': (
    icon: Icons.bolt,
    label: 'Double Points',
    desc: 'Next points event awards ×2',
    color: Color(0xFF3A86FF),
    ),
    'minus': (
    icon: Icons.remove_circle_outline,
    label: 'Minus',
    desc: 'Deduct equal points from a rival once',
    color: Color(0xFFFF4D4D),
    ),
    'freezer': (
    icon: Icons.ac_unit,
    label: 'Freezer',
    desc: 'Freeze a rival team for 1 hour — stacks if used again',
    color: Color(0xFF00CFFF),
    ),
    'reActivation': (
    icon: Icons.replay_circle_filled,
    label: 'Re-Activation',
    desc: 'Re-use any one of your already-used superpowers',
    color: Color(0xFFB97BFF),
    ),
    'dice': (
    icon: Icons.casino,
    label: 'Dice',
    desc: 'Random multiplier: ×0.5, ×1, ×1.5, or ×2',
    color: Color(0xFFFF8C42),
    ),
  };

  // ── helpers ────────────────────────────────────────────────────────
  String? get _activePowerType {
    try {
      return widget.team.teamSuperPowers
          .firstWhere((p) => p.status == SuperPowerStatus.activated)
          .type
          .name;
    } catch (_) {
      return null;
    }
  }

  List<TeamModel> get _otherTeams =>
      widget.allTeams.where((t) => t.id != widget.team.id).toList();

  /// Powers that have already been used (Deactivated) — candidates for ReActivation.
  /// Freezer is excluded because re-activating it still needs a target and is
  /// handled specially inside the backend; we show it but label it clearly.
  List<TeamSuperPower> get _usedPowers => widget.team.teamSuperPowers
      .where((p) => p.status == SuperPowerStatus.deactivated)
      .toList();

  void _handleActivate(String powerType) {
    if (powerType == 'freezer') {
      // Must pick a target first
      if (_freezeTargetId == null) return;
      widget.onActivate(
        powerType,
        targetTeamToFreeze: _freezeTargetId,
      );
    } else if (powerType == 'reActivation') {
      // Must pick a used power first
      if (_reActivateType == null) return;
      widget.onActivate(
        powerType,
        reActivatedType: _reActivateType,
        // If re-activating Freezer we also need a target — handled via
        // a nested check below in the picker section.
        targetTeamToFreeze: (_reActivateType == 'freezer') ? _freezeTargetId : null,
      );
    } else {
      widget.onActivate(powerType);
    }
    Navigator.pop(context);
  }

  // ── build ──────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final activePower = _activePowerType;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 32.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1D2E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
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

            CustomText(
              text: 'Superpowers — ${widget.team.name}',
              style: TextStyles.font16WhiteBold,
            ),
            SizedBox(height: 16.h),

            ...widget.team.teamSuperPowers.map((power) {
              final meta = _powerMeta[power.type.name];
              if (meta == null) return const SizedBox.shrink();

              final isActive = power.status == SuperPowerStatus.activated;
              final isDeactivated = power.status == SuperPowerStatus.deactivated;
              final isAnotherActive =
                  activePower != null && activePower != power.type.name;
              final isExpanded = _expandedType == power.type.name;

              log('ManagePowersSheet: ${power.type.name} status=${power.status.name}');

              return _PowerTile(
                icon: meta.icon,
                label: meta.label,
                desc: meta.desc,
                color: meta.color,
                isActive: isActive,
                isDeactivated: isDeactivated,
                isBlocked: isAnotherActive && !isActive,
                isExpanded: isExpanded,
                // ── extra picker content ──────────────────────────────
                extraContent: _buildExtraContent(power.type.name, meta.color),
                onActivate: () {
                  // Powers needing a picker → expand instead of activating immediately
                  if (power.type.name == 'freezer' ||
                      power.type.name == 'reActivation') {
                    setState(() {
                      _expandedType =
                      isExpanded ? null : power.type.name;
                    });
                    return;
                  }
                  _handleActivate(power.type.name);
                },
                onConfirmExpanded: () => _handleActivate(power.type.name),
                onDeactivate: () {
                  widget.onDeactivate();
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  /// Returns the inline extra-picker widget for Freezer or ReActivation tiles,
  /// or null for simple powers.
  Widget? _buildExtraContent(String powerType, Color accentColor) {
    if (_expandedType != powerType) return null;

    if (powerType == 'freezer') {
      return _buildTeamPicker(
        label: 'Select team to freeze',
        accentColor: accentColor,
        teams: _otherTeams,
        selectedId: _freezeTargetId,
        onChanged: (id) => setState(() => _freezeTargetId = id),
      );
    }

    if (powerType == 'reActivation') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPowerPicker(
            label: 'Select power to re-activate',
            accentColor: accentColor,
            usedPowers: _usedPowers,
            selectedType: _reActivateType,
            onChanged: (type) => setState(() {
              _reActivateType = type;
              // Reset freeze target if switching away from Freezer
              if (type != 'freezer') _freezeTargetId = null;
            }),
          ),
          // If the chosen power to re-activate is Freezer, also need a target
          if (_reActivateType == 'freezer') ...[
            SizedBox(height: 10.h),
            _buildTeamPicker(
              label: 'Select team to freeze',
              accentColor: accentColor,
              teams: _otherTeams,
              selectedId: _freezeTargetId,
              onChanged: (id) => setState(() => _freezeTargetId = id),
            ),
          ],
        ],
      );
    }

    return null;
  }

  Widget _buildTeamPicker({
    required String label,
    required Color accentColor,
    required List<TeamModel> teams,
    required int? selectedId,
    required ValueChanged<int?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        CustomText(
          text: label,
          style: TextStyles.font12WhiteMedium.copyWith(color: Colors.white60),
        ),
        SizedBox(height: 6.h),
        DropdownButtonFormField<int>(
          value: selectedId,
          dropdownColor: const Color(0xFF0F1D2E),
          style: TextStyles.font13WhiteMedium,
          decoration: _dropdownDecoration('Choose a team', accentColor),
          items: teams
              .map((t) => DropdownMenuItem(value: t.id, child: Text(t.name)))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildPowerPicker({
    required String label,
    required Color accentColor,
    required List<TeamSuperPower> usedPowers,
    required String? selectedType,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        CustomText(
          text: label,
          style: TextStyles.font12WhiteMedium.copyWith(color: Colors.white60),
        ),
        SizedBox(height: 6.h),
        DropdownButtonFormField<String>(
          value: selectedType,
          dropdownColor: const Color(0xFF0F1D2E),
          style: TextStyles.font13WhiteMedium,
          decoration: _dropdownDecoration('Choose a power', accentColor),
          items: usedPowers.map((p) {
            final meta = _powerMeta[p.type.name];
            return DropdownMenuItem(
              value: p.type.name,
              child: Text(meta?.label ?? p.type.name),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  InputDecoration _dropdownDecoration(String hint, Color accentColor) =>
      InputDecoration(
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
          borderSide: BorderSide(color: accentColor, width: 1.5),
        ),
      );
}

// ═══════════════════════════════════════════════════════════════════════════
// PowerTile
// ═══════════════════════════════════════════════════════════════════════════

class _PowerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String desc;
  final Color color;
  final bool isActive;
  final bool isDeactivated;
  final bool isBlocked;
  final bool isExpanded;
  final Widget? extraContent;
  final VoidCallback onActivate;
  final VoidCallback onConfirmExpanded;
  final VoidCallback onDeactivate;

  const _PowerTile({
    required this.icon,
    required this.label,
    required this.desc,
    required this.color,
    required this.isActive,
    required this.isDeactivated,
    required this.isBlocked,
    required this.isExpanded,
    required this.onActivate,
    required this.onConfirmExpanded,
    required this.onDeactivate,
    this.extraContent,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = (isDeactivated || isBlocked)
        ? Colors.white24
        : isActive
        ? color
        : color.withOpacity(0.7);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: effectiveColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: effectiveColor.withOpacity(isActive ? 0.8 : 0.3),
          width: isActive ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header row ──────────────────────────────────────────
          Row(
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  color: effectiveColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: effectiveColor, size: 20.r),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: label,
                          style: TextStyles.font13WhiteMedium.copyWith(
                            color: effectiveColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isActive) ...[
                          SizedBox(width: 6.w),
                          _StatusBadge('ACTIVE', Colors.greenAccent),
                        ],
                        if (isDeactivated) ...[
                          SizedBox(width: 6.w),
                          _StatusBadge('USED', Colors.white38),
                        ],
                      ],
                    ),
                    SizedBox(height: 2.h),
                    CustomText(
                      text: desc,
                      style: TextStyles.font11WhiteBold.copyWith(
                        color: Colors.white38,
                        fontWeight: FontWeight.normal,
                        fontSize: 10.sp,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              if (!isDeactivated && !isBlocked)
                _PowerActionButton(
                  isActive: isActive,
                  isExpanded: isExpanded,
                  color: effectiveColor,
                  onTap: isActive ? onDeactivate : onActivate,
                ),
            ],
          ),

          // ── expandable picker section ───────────────────────────
          if (extraContent != null) ...[
            extraContent!,
            SizedBox(height: 12.h),
            // Confirm button
            SizedBox(
              width: double.infinity,
              height: 40.h,
              child: ElevatedButton(
                onPressed: onConfirmExpanded,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color.withOpacity(0.85),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: CustomText(
                  text: 'Confirm Activation',
                  style: TextStyles.font13WhiteMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusBadge(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 8.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _PowerActionButton extends StatelessWidget {
  final bool isActive;
  final bool isExpanded;
  final Color color;
  final VoidCallback onTap;

  const _PowerActionButton({
    required this.isActive,
    required this.isExpanded,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final label = isActive
        ? 'Deactivate'
        : isExpanded
        ? 'Cancel'
        : 'Activate';
    final borderColor = isActive ? Colors.redAccent : color;
    final bgColor = isActive
        ? Colors.red.withOpacity(0.15)
        : color.withOpacity(0.15);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: CustomText(
          text: label,
          style: TextStyles.font11WhiteBold.copyWith(
            color: borderColor,
            fontSize: 11.sp,
          ),
        ),
      ),
    );
  }
}