import 'dart:developer';

import 'package:LJF_admin/core/styles/colors.dart';
import 'package:LJF_admin/core/styles/styles.dart';
import 'package:LJF_admin/core/widgets/other/custom_text.dart';
import 'package:LJF_admin/features/admin/model/event_config_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class UniversityEventSection extends StatelessWidget {
  final int attendeeCount;
  final EventConfigModel? eventConfig;
  final VoidCallback onIncrementAttendee;
  final void Function(int count) onSetAttendeeCount;
  final void Function(DateTime raceStartTime) onSetRaceStartTime;

  const UniversityEventSection({
    super.key,
    required this.attendeeCount,
    required this.eventConfig,
    required this.onIncrementAttendee,
    required this.onSetAttendeeCount,
    required this.onSetRaceStartTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── University ────────────────────────────────
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: ColorManager.neutral.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: ColorManager.tertiary.withOpacity(0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.school_rounded, color: ColorManager.tertiary, size: 18.r),
                  SizedBox(width: 8.w),
                  CustomText(
                    text: 'University Graduates',
                    style: TextStyles.font14WhiteBold.copyWith(color: ColorManager.tertiary),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  CustomText(
                    text: '$attendeeCount',
                    style: TextStyles.font20WhiteBold.copyWith(fontSize: 32.sp),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.tertiary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    ),
                    onPressed: onIncrementAttendee,
                    child: CustomText(
                      text: '+1',
                      style: TextStyles.font13WhiteMedium
                          .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () => _showSetCountDialog(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(Icons.edit, color: Colors.white70, size: 16.r),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // ── Event config ──────────────────────────────
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: ColorManager.neutral.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: ColorManager.secondary.withOpacity(0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.timer_rounded, color: ColorManager.secondary, size: 18.r),
                  SizedBox(width: 8.w),
                  CustomText(
                    text: 'Race Countdown',
                    style: TextStyles.font14WhiteBold.copyWith(color: ColorManager.secondary),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              CustomText(
                text: eventConfig != null
                    ? 'Race starts: ${DateFormat('MMM d, HH:mm').format(eventConfig!.raceStartTime.toLocal())}'
                    : 'Not configured yet',
                style: TextStyles.font13WhiteMedium.copyWith(color: Colors.white60),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: ColorManager.secondary.withOpacity(0.5)),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  onPressed: () => _pickDateTime(context),
                  child: CustomText(
                    text: 'Set Race Start Time',
                    style: TextStyles.font13WhiteMedium.copyWith(color: ColorManager.secondary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showSetCountDialog(BuildContext context) {
    final controller = TextEditingController(text: '$attendeeCount');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF0F1D2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: CustomText(text: 'Set Attendee Count', style: TextStyles.font16WhiteBold),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: TextStyles.font14WhiteBold,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: CustomText(text: 'Cancel', style: TextStyles.font13WhiteMedium.copyWith(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () {
              final value = int.tryParse(controller.text);
              if (value != null && value >= 0) {
                onSetAttendeeCount(value);
                Navigator.pop(context);
              }
            },
            child: CustomText(text: 'Save', style: TextStyles.font13WhiteMedium.copyWith(color: ColorManager.primary)),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDateTime(BuildContext context) async {
    try{
    log("pickDateTime");
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate:  now,
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 7)),
    );
    if (date == null || !context.mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(eventConfig?.raceStartTime ?? now),
    );
    if (time == null) return;

    onSetRaceStartTime(DateTime(date.year, date.month, date.day, time.hour, time.minute));}catch(e){
      log("errorrrrrrr pickdate ${e}");
    }
  }
}