import 'dart:convert';


import 'package:base_project/core/styles/colors.dart';
import 'package:base_project/core/styles/styles.dart';
import 'package:base_project/core/widgets/other/custom_text.dart';
import 'package:base_project/features/admin/model/team_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminTeamCard extends StatelessWidget {
  final TeamModel team;
  final int rank;
  final VoidCallback onAddPoints;
  final VoidCallback onManagePowers;

  const AdminTeamCard({
    super.key,
    required this.team,
    required this.rank,
    required this.onAddPoints,
    required this.onManagePowers,
  });

  Color get _teamColor {
    try {
      final hex = team.colorCode.replaceAll('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return ColorManager.primary;
    }
  }

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
      decoration: BoxDecoration(
        color: ColorManager.neutral.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: _teamColor.withOpacity(0.6),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: _teamColor.withOpacity(0.15),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(14.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header row ──────────────────────────────
            Row(
              children: [
                // Rank badge
                Container(
                  width: 28.r,
                  height: 28.r,
                  decoration: BoxDecoration(
                    color: _teamColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: _teamColor, width: 1.5),
                  ),
                  alignment: Alignment.center,
                  child: CustomText(
                    text: '#$rank',
                    style: TextStyles.font11WhiteBold
                        .copyWith(color: _teamColor, fontSize: 10.sp),
                  ),
                ),
                SizedBox(width: 8.w),

                // Team avatar
                _buildAvatar(),
                SizedBox(width: 10.w),

                // Name + active power badge
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: team.name,
                        style: TextStyles.font14WhiteBold.copyWith(
                          fontSize: 13.sp,
                        ),
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                      if (activePower != null)
                        Container(
                          margin: EdgeInsets.only(top: 3.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: ColorManager.secondary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(
                                color: ColorManager.secondary, width: 1),
                          ),
                          child: CustomText(
                            text: '⚡ $activePower',
                            style: TextStyles.font11WhiteBold.copyWith(
                              color: ColorManager.secondary,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Score
                CustomText(
                  text: '${team.score}',
                  style: TextStyles.font20WhiteBold.copyWith(
                    color: _teamColor,
                    fontSize: 22.sp,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),
            const Divider(color: Colors.white12),
            SizedBox(height: 10.h),

            // ── Action buttons ───────────────────────────
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    label: 'Add Points',
                    icon: Icons.add_circle_outline,
                    color: ColorManager.tertiary,
                    onTap: onAddPoints,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _ActionButton(
                    label: 'Superpowers',
                    icon: Icons.bolt,
                    color: ColorManager.secondary,
                    onTap: onManagePowers,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    if (team.image.isNotEmpty) {
      try {
        return CircleAvatar(
          radius: 18.r,
          backgroundImage: MemoryImage(base64Decode(team.image)),
          backgroundColor: _teamColor.withOpacity(0.2),
        );
      } catch (_) {}
    }
    return CircleAvatar(
      radius: 18.r,
      backgroundColor: _teamColor.withOpacity(0.2),
      child: CustomText(
        text: team.name.isNotEmpty ? team.name[0] : '?',
        style: TextStyles.font14WhiteBold.copyWith(color: _teamColor),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: color.withOpacity(0.5), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 16.r),
            SizedBox(width: 5.w),
            CustomText(
              text: label,
              style: TextStyles.font12WhiteMedium.copyWith(
                color: color,
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
