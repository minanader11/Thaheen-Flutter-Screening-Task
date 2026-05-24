
import 'package:base_project/core/styles/colors.dart';
import 'package:base_project/core/styles/styles.dart';
import 'package:base_project/core/widgets/other/custom_text.dart';
import 'package:base_project/features/admin/model/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Bottom sheet for adding / subtracting points from a team.
/// If the team has Minus superpower active, shows a target-team selector.
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

  bool get _minusActive => widget.team.teamSuperPowers
      .any((p) => p.type == 'Minus' && p.status == 'Activated');

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

    widget.onConfirm(
      teamId: widget.team.id,
      points: pts,
      targetTeamToMinus: _minusActive ? _selectedTargetId : null,
    );

    Navigator.pop(context);
  }

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

          // Title
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

          SizedBox(height: 20.h),

          // Points input
          _buildLabel('Points to add'),
          SizedBox(height: 6.h),
          TextField(
            controller: _pointsCtrl,
            keyboardType: TextInputType.number,
            style: TextStyles.font16WhiteBold,
            decoration: _inputDecoration('e.g. 50'),
          ),

          // Minus power target selector
          if (_minusActive) ...[
            SizedBox(height: 16.h),
            Row(
              children: [
                Icon(Icons.bolt, color: ColorManager.secondary, size: 16.r),
                SizedBox(width: 4.w),
                CustomText(
                  text: 'Minus Power active — select target team',
                  style: TextStyles.font12WhiteMedium.copyWith(
                    color: ColorManager.secondary,
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
                  .map((t) => DropdownMenuItem(
                        value: t.id,
                        child: Text(t.name),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _selectedTargetId = v),
            ),
          ],

          SizedBox(height: 24.h),

          // Confirm button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.tertiary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
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
        hintStyle: TextStyles.font13WhiteMedium.copyWith(color: Colors.white30),
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
