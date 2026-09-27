import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/other/custom_text.dart';
import '../../model/job_order_model.dart';
import 'form_field_input.dart';
import 'section_card.dart';

class VisitInfoSectionWidget extends StatelessWidget {
  final VisitType selectedVisitType;
  final ValueChanged<VisitType> onVisitTypeSelected;
  final TextEditingController visitDateController;
  final TextEditingController dispatchedController;
  final TextEditingController companyLeftController;
  final TextEditingController siteArrivalController;
  final TextEditingController serviceStartController;
  final TextEditingController serviceEndController;
  final TextEditingController siteLeftController;
  final TextEditingController companyBackController;
  final bool returnToAlfaOrHome;
  final ValueChanged<bool> onReturnToAlfaChanged;
  final bool proceedToAnotherCall;
  final ValueChanged<bool> onProceedChanged;
  final TextEditingController nextRefNoController;

  const VisitInfoSectionWidget({
    super.key,
    required this.selectedVisitType,
    required this.onVisitTypeSelected,
    required this.visitDateController,
    required this.dispatchedController,
    required this.companyLeftController,
    required this.siteArrivalController,
    required this.serviceStartController,
    required this.serviceEndController,
    required this.siteLeftController,
    required this.companyBackController,
    required this.returnToAlfaOrHome,
    required this.onReturnToAlfaChanged,
    required this.proceedToAnotherCall,
    required this.onProceedChanged,
    required this.nextRefNoController,
  });

  @override
  Widget build(BuildContext context) {
    final visitTypes = [
      {'type': VisitType.atSite, 'label': 'At Site (بالموقع)'},
      {'type': VisitType.byPhone, 'label': 'By Phone (بالهاتف)'},
      {
        'type': VisitType.serviceCenter,
        'label': 'Service Center (مركز الخدمة)'
      },
    ];

    return SectionCard(
      titleEn: 'Visit Information',
      titleAr: 'بيانات الزيارة وأوقات العمل',
      icon: Icons.schedule_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Visit Type selector
          CustomText(
            text: 'Visit Mode (مكان / طريقة تقديم الخدمة):',
            style: TextStyles.styleTextLGNormal.copyWith(
              color: const Color(0xFF94A3B8),
            ),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: visitTypes.map((item) {
              final type = item['type'] as VisitType;
              final isSelected = selectedVisitType == type;

              return InkWell(
                onTap: () => onVisitTypeSelected(type),
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorManager.primary.withValues(alpha: 0.2)
                        : const Color(0xFF0C1624),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isSelected
                          ? ColorManager.primary
                          : const Color(0xFF22364F),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        size: 14.sp,
                        color:
                            isSelected ? ColorManager.primary : Colors.white38,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        item['label'] as String,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF94A3B8),
                          fontSize: 11.5.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 14.h),

          // Date & Dispatched
          Row(
            children: [
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Visit Date',
                  labelAr: '(تاريخ الزيارة)',
                  controller: visitDateController,
                  hintText: '16 / 09 / 2026',
                  suffixIcon: const Icon(Icons.calendar_month,
                      size: 16, color: Colors.white54),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Dispatched',
                  labelAr: '(أمر التحرك)',
                  controller: dispatchedController,
                  hintText: 'Dispatched details',
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),

          // 6 Time Tracker Stages
          CustomText(
            text: 'Service Timeline (أوقات التحرك والعمل بالموقع):',
            style: TextStyles.styleTextLGNormal.copyWith(
              color: const Color(0xFF5BA3D0),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Company Left',
                  controller: companyLeftController,
                  hintText: 'HH:MM',
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Site Arrival',
                  controller: siteArrivalController,
                  hintText: '13:08',
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Service Start',
                  controller: serviceStartController,
                  hintText: '13:08',
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Service End',
                  controller: serviceEndController,
                  hintText: '13:08',
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Site Left',
                  controller: siteLeftController,
                  hintText: '13:08',
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Company Back',
                  controller: companyBackController,
                  hintText: '13:08',
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),

          // Next actions checkboxes & next ref no
          Row(
            children: [
              Checkbox(
                value: returnToAlfaOrHome,
                onChanged: (val) => onReturnToAlfaChanged(val ?? false),
                activeColor: ColorManager.primary,
              ),
              Expanded(
                child: CustomText(
                  text: 'Return to ALFA / Home',
                  style: TextStyles.styleTextLGNormal,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: proceedToAnotherCall,
                onChanged: (val) => onProceedChanged(val ?? false),
                activeColor: ColorManager.primary,
              ),
              Expanded(
                child: CustomText(
                  text: 'Proceed To another Call',
                  style: TextStyles.styleTextLGNormal,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          FormFieldInput(
            labelEn: 'Next Service Report Ref. No.',
            labelAr: '(رقم تقرير الزيارة القادمة إن وجد)',
            controller: nextRefNoController,
            hintText: 'Next Report Ref. No.',
          ),
        ],
      ),
    );
  }
}
