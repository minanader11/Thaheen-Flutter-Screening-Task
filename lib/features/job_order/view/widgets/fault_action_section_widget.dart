import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'form_field_input.dart';
import 'section_card.dart';

class FaultActionSectionWidget extends StatelessWidget {
  final TextEditingController faultDescController;
  final TextEditingController faultCodeController;
  final TextEditingController actionDescController;
  final TextEditingController actionCodeController;
  final TextEditingController causeDescController;
  final TextEditingController causeCodeController;
  final TextEditingController responsibleDescController;
  final TextEditingController responsibleCodeController;

  const FaultActionSectionWidget({
    super.key,
    required this.faultDescController,
    required this.faultCodeController,
    required this.actionDescController,
    required this.actionCodeController,
    required this.causeDescController,
    required this.causeCodeController,
    required this.responsibleDescController,
    required this.responsibleCodeController,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      titleEn: 'Faults & Actions Taken',
      titleAr: 'الأعطال والإجراءات المتخذة',
      icon: Icons.build_circle_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fault row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: FormFieldInput(
                  labelEn: 'Fault Description',
                  labelAr: '(وصف العطل)',
                  controller: faultDescController,
                  hintText: 'e.g. 85, vacuum pump failure',
                  maxLines: 2,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                flex: 1,
                child: FormFieldInput(
                  labelEn: 'Code',
                  labelAr: '(الكود)',
                  controller: faultCodeController,
                  hintText: 'Code',
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Action row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: FormFieldInput(
                  labelEn: 'Action Taken',
                  labelAr: '(الإجراء المتخذ)',
                  controller: actionDescController,
                  hintText: 'e.g. تم تنظيف مضخة الشفط...',
                  maxLines: 3,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                flex: 1,
                child: FormFieldInput(
                  labelEn: 'Code',
                  labelAr: '(الكود)',
                  controller: actionCodeController,
                  hintText: 'Code',
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          const Divider(color: Color(0xFF22364F), thickness: 1),
          SizedBox(height: 10.h),

          // Cause row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: FormFieldInput(
                  labelEn: 'Cause',
                  labelAr: '(السبب)',
                  controller: causeDescController,
                  hintText: 'Root cause',
                  maxLines: 2,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                flex: 1,
                child: FormFieldInput(
                  labelEn: 'Code',
                  labelAr: '(الكود)',
                  controller: causeCodeController,
                  hintText: 'Code',
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Responsible row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: FormFieldInput(
                  labelEn: 'Responsible',
                  labelAr: '(المسؤول)',
                  controller: responsibleDescController,
                  hintText: 'Person/Department',
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                flex: 1,
                child: FormFieldInput(
                  labelEn: 'Code',
                  labelAr: '(الكود)',
                  controller: responsibleCodeController,
                  hintText: 'Code',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
