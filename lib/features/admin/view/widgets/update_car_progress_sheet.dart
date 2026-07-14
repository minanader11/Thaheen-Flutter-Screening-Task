import 'package:LJF_admin/core/styles/colors.dart';
import 'package:LJF_admin/core/styles/styles.dart';
import 'package:LJF_admin/core/widgets/other/custom_text.dart';
import 'package:LJF_admin/features/admin/model/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateCarProgressSheet extends StatefulWidget {
  final TeamModel team;
  final void Function(double percentage) onConfirm;

  const UpdateCarProgressSheet({
    super.key,
    required this.team,
    required this.onConfirm,
  });

  @override
  State<UpdateCarProgressSheet> createState() => _UpdateCarProgressSheetState();
}

class _UpdateCarProgressSheetState extends State<UpdateCarProgressSheet> {
  late double _percentage = widget.team.carCompletionPercentage;

  Color get _color {
    if (_percentage >= 100) return ColorManager.success;
    if (_percentage >= 75) return ColorManager.primary;
    if (_percentage >= 40) return ColorManager.secondary;
    return ColorManager.error;
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
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          CustomText(
            text: 'Car Build Progress',
            style: TextStyles.font16WhiteBold,
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: widget.team.name,
            style: TextStyles.font13WhiteMedium.copyWith(color: Colors.white54),
          ),
          SizedBox(height: 24.h),

          Center(
            child: CustomText(
              text: '${_percentage.toInt()}%',
              style: TextStyles.font20WhiteBold.copyWith(
                color: _color,
                fontSize: 36.sp,
              ),
            ),
          ),
          SizedBox(height: 8.h),

          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: _color,
              inactiveTrackColor: Colors.white12,
              thumbColor: _color,
              overlayColor: _color.withOpacity(0.2),
            ),
            child: Slider(
              value: _percentage,
              min: 0,
              max: 100,
              divisions: 100,
              onChanged: (v) => setState(() => _percentage = v),
            ),
          ),
          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: CustomText(
                    text: 'Cancel',
                    style: TextStyles.font13WhiteMedium
                        .copyWith(color: Colors.white54),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _color,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    widget.onConfirm(_percentage);
                    Navigator.pop(context);
                  },
                  child: CustomText(
                    text: 'Save',
                    style: TextStyles.font13WhiteMedium
                        .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}