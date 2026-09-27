import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/other/custom_text.dart';
import '../../model/job_order_model.dart';
import 'form_field_input.dart';
import 'section_card.dart';

class JobHeaderSectionWidget extends StatelessWidget {
  final TextEditingController jobNoController;
  final JobType selectedJobType;
  final ValueChanged<JobType> onJobTypeSelected;

  const JobHeaderSectionWidget({
    super.key,
    required this.jobNoController,
    required this.selectedJobType,
    required this.onJobTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final types = [
      {'type': JobType.installation, 'en': 'Installation', 'ar': 'تركيب'},
      {
        'type': JobType.reinstallation,
        'en': 'Reinstallation',
        'ar': 'إعادة تركيب'
      },
      {'type': JobType.pm, 'en': 'PM', 'ar': 'صيانة'},
      {'type': JobType.emergency, 'en': 'Emergency', 'ar': 'حالات طوارئ'},
      {'type': JobType.annualPm, 'en': 'Annual PM', 'ar': 'صيانة سنوية'},
      {'type': JobType.other, 'en': 'Other', 'ar': 'أخرى'},
    ];

    return SectionCard(
      titleEn: 'Job Order Header',
      titleAr: 'رأس أمر الشغل ونوعه',
      icon: Icons.confirmation_number_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormFieldInput(
            labelEn: 'Job Order No.',
            labelAr: '(رقم أمر الشغل)',
            controller: jobNoController,
            hintText: 'e.g. 9029',
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 12.h),
          CustomText(
            text: 'Job Type (نوع الصيانة / الخدمة):',
            style: TextStyles.styleTextLGNormal.copyWith(
              color: const Color(0xFF94A3B8),
            ),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: types.map((item) {
              final type = item['type'] as JobType;
              final isSelected = selectedJobType == type;

              return InkWell(
                onTap: () => onJobTypeSelected(type),
                borderRadius: BorderRadius.circular(8.r),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorManager.primary.withValues(alpha: 0.2)
                        : const Color(0xFF0C1624),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isSelected
                          ? ColorManager.primary
                          : const Color(0xFF22364F),
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSelected
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        size: 16.sp,
                        color: isSelected
                            ? ColorManager.primary
                            : const Color(0xFF64748B),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '${item['en']} (${item['ar']})',
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF94A3B8),
                          fontSize: 11.5.sp,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
