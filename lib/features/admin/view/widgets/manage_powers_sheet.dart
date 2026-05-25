import 'dart:developer';

import 'package:LJF_admin/core/styles/styles.dart';

import 'package:LJF_admin/core/widgets/other/custom_text.dart';
import 'package:LJF_admin/features/admin/model/team_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shows all three superpowers for a team and allows activating / deactivating.
class ManagePowersSheet extends StatelessWidget {
  final TeamModel team;
  final void Function(String type) onActivate;
  final VoidCallback onDeactivate;

  const ManagePowersSheet({
    super.key,
    required this.team,
    required this.onActivate,
    required this.onDeactivate,
  });

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
  };

  String? get _activePowerType {
    try {
      return team.teamSuperPowers
          .firstWhere((p) => p.status.toString() == 'Activated')
          .type.toString();
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final activePower = _activePowerType;

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
            text: 'Superpowers — ${team.name}',
            style: TextStyles.font16WhiteBold,
          ),
          SizedBox(height: 16.h),

          ...team.teamSuperPowers.map((power) {
            final meta = _powerMeta[power.type.name];
          //  log("metaaa ${meta} ${power.type.name}");
            if (meta == null) return const SizedBox.shrink();

            final isActive = power.status.name == 'activated';
            final isDeactivated = power.status.name == 'deactivated';
            log("metaaa ${meta} ${power.type.name} isDeactivated ${power.status.name}");
            final isAnotherActive =
                activePower != null && activePower != power.type.name;

            return _PowerTile(
              icon: meta.icon,
              label: meta.label,
              desc: meta.desc,
              color: meta.color,
              isActive: isActive,
              isDeactivated: isDeactivated,
              isBlocked: isAnotherActive && !isActive,
              onActivate: () {
                onActivate(power.type.name);
                Navigator.pop(context);
              },
              onDeactivate: () {
                onDeactivate();
                Navigator.pop(context);
              },
            );
          }),
        ],
      ),
    );
  }
}

class _PowerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String desc;
  final Color color;
  final bool isActive;
  final bool isDeactivated;
  final bool isBlocked;
  final VoidCallback onActivate;
  final VoidCallback onDeactivate;

  const _PowerTile({
    required this.icon,
    required this.label,
    required this.desc,
    required this.color,
    required this.isActive,
    required this.isDeactivated,
    required this.isBlocked,
    required this.onActivate,
    required this.onDeactivate,
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
      child: Row(
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

          // Action button
          if (!isDeactivated && !isBlocked)
            _PowerActionButton(
              isActive: isActive,
              color: effectiveColor,
              onTap: isActive ? onDeactivate : onActivate,
            ),
        ],
      ),
    );
  }
}

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
  final Color color;
  final VoidCallback onTap;

  const _PowerActionButton({
    required this.isActive,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.red.withOpacity(0.15)
              : color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isActive ? Colors.redAccent : color,
            width: 1,
          ),
        ),
        child: CustomText(
          text: isActive ? 'Deactivate' : 'Activate',
          style: TextStyles.font11WhiteBold.copyWith(
            color: isActive ? Colors.redAccent : color,
            fontSize: 11.sp,
          ),
        ),
      ),
    );
  }
}