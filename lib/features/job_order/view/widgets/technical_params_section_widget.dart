import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/other/custom_text.dart';
import '../../model/job_order_model.dart';
import 'form_field_input.dart';
import 'section_card.dart';

class TechnicalParamsSectionWidget extends StatelessWidget {
  final TextEditingController pNbController;
  final TextEditingController pAcController;
  final TextEditingController jet1Controller;
  final TextEditingController jet2Controller;
  final TextEditingController vacuumController;
  final TextEditingController vescoController;
  final TextEditingController tController;
  final TextEditingController workingHrController;
  final TextEditingController vmController;
  final TextEditingController swVersionController;
  final CallCondition selectedCondition;
  final ValueChanged<CallCondition> onConditionSelected;
  final List<SparePartItem> spareParts;
  final VoidCallback onAddSparePart;
  final void Function(int index, SparePartItem item) onUpdateSparePart;
  final void Function(int index) onRemoveSparePart;

  const TechnicalParamsSectionWidget({
    super.key,
    required this.pNbController,
    required this.pAcController,
    required this.jet1Controller,
    required this.jet2Controller,
    required this.vacuumController,
    required this.vescoController,
    required this.tController,
    required this.workingHrController,
    required this.vmController,
    required this.swVersionController,
    required this.selectedCondition,
    required this.onConditionSelected,
    required this.spareParts,
    required this.onAddSparePart,
    required this.onUpdateSparePart,
    required this.onRemoveSparePart,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      titleEn: 'Technical Measurements & Spare Parts',
      titleAr: 'القياسات الفنية وقطع الغيار',
      icon: Icons.tune_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Measurement Row 1
          CustomText(
            text: 'System Pressures & Jet Readings (الضغوط وقراءات الفتحات):',
            style: TextStyles.styleTextLGNormal.copyWith(
              color: const Color(0xFF5BA3D0),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: FormFieldInput(
                  labelEn: 'P(nb)',
                  controller: pNbController,
                  hintText: 'P(nb)',
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'P(ac)',
                  controller: pAcController,
                  hintText: 'P(ac)',
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Jet(1)',
                  controller: jet1Controller,
                  hintText: 'Jet(1)',
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Jet(2)',
                  controller: jet2Controller,
                  hintText: 'Jet(2)',
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Vacuum',
                  controller: vacuumController,
                  hintText: 'Vacuum',
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Vesco',
                  controller: vescoController,
                  hintText: 'Vesco',
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Working parameters
          Row(
            children: [
              Expanded(
                child: FormFieldInput(
                  labelEn: 'T',
                  controller: tController,
                  hintText: 'Temp',
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Working Hr.',
                  controller: workingHrController,
                  hintText: 'Hours',
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Vm',
                  controller: vmController,
                  hintText: 'Vm',
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'S/W Version',
                  controller: swVersionController,
                  hintText: 'Version',
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),

          // Call Condition
          CustomText(
            text: 'Call Condition (حالة البلاغ):',
            style: TextStyles.styleTextLGNormal.copyWith(
              color: const Color(0xFF94A3B8),
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              InkWell(
                onTap: () => onConditionSelected(CallCondition.closed),
                borderRadius: BorderRadius.circular(6.r),
                child: Row(
                  children: [
                    Icon(
                      selectedCondition == CallCondition.closed
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      size: 18.sp,
                      color: selectedCondition == CallCondition.closed
                          ? ColorManager.primary
                          : Colors.white38,
                    ),
                    SizedBox(width: 6.w),
                    CustomText(
                      text: 'Closed (مغلق)',
                      style: TextStyles.font13WhiteMedium,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 24.w),
              InkWell(
                onTap: () => onConditionSelected(CallCondition.followUp),
                borderRadius: BorderRadius.circular(6.r),
                child: Row(
                  children: [
                    Icon(
                      selectedCondition == CallCondition.followUp
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      size: 18.sp,
                      color: selectedCondition == CallCondition.followUp
                          ? ColorManager.primary
                          : Colors.white38,
                    ),
                    SizedBox(width: 6.w),
                    CustomText(
                      text: 'Follow up (متابعة)',
                      style: TextStyles.font13WhiteMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 18.h),
          const Divider(color: Color(0xFF22364F), thickness: 1),
          SizedBox(height: 10.h),

          // ── Spare parts table ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Spare Parts (قطع الغيار التي تم تركيبها):',
                style: TextStyles.styleTextLGNormal.copyWith(
                  color: const Color(0xFF5BA3D0),
                ),
              ),
              TextButton.icon(
                onPressed: onAddSparePart,
                icon: const Icon(Icons.add_circle_outline,
                    size: 16, color: ColorManager.primary),
                label: const Text(
                  'Add Part',
                  style: TextStyle(color: ColorManager.primary, fontSize: 12),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),

          if (spareParts.isEmpty)
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              alignment: Alignment.center,
              child: Text(
                'No spare parts added. Tap "Add Part" to add rows.',
                style: TextStyle(color: Colors.white38, fontSize: 12.sp),
              ),
            )
          else
            ...List.generate(spareParts.length, (index) {
              final part = spareParts[index];
              return Container(
                margin: EdgeInsets.only(bottom: 10.h),
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C1624),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFF22364F), width: 1),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            initialValue: part.description,
                            onChanged: (val) => onUpdateSparePart(
                                index, part.copyWith(description: val)),
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Part Description (اسم القطعة)',
                              hintStyle: const TextStyle(color: Colors.white24),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xFF22364F)),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            initialValue: part.quantity,
                            onChanged: (val) => onUpdateSparePart(
                                index, part.copyWith(quantity: val)),
                            keyboardType: TextInputType.number,
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Qty (كمية)',
                              hintStyle: const TextStyle(color: Colors.white24),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xFF22364F)),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => onRemoveSparePart(index),
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.redAccent, size: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: part.unitPrice,
                            onChanged: (val) => onUpdateSparePart(
                                index, part.copyWith(unitPrice: val)),
                            keyboardType: TextInputType.number,
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Unit Price (سعر)',
                              hintStyle: const TextStyle(color: Colors.white24),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 6.h),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xFF22364F)),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: TextFormField(
                            initialValue: part.discount,
                            onChanged: (val) => onUpdateSparePart(
                                index, part.copyWith(discount: val)),
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Discount (خصم)',
                              hintStyle: const TextStyle(color: Colors.white24),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 6.h),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xFF22364F)),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: TextFormField(
                            initialValue: part.warranty,
                            onChanged: (val) => onUpdateSparePart(
                                index, part.copyWith(warranty: val)),
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.sp),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Warranty (ضمان)',
                              hintStyle: const TextStyle(color: Colors.white24),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 6.h),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xFF22364F)),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Checkbox(
                          value: part.isClient,
                          onChanged: (val) => onUpdateSparePart(
                              index, part.copyWith(isClient: val ?? false)),
                          activeColor: ColorManager.primary,
                        ),
                        const Text('Client',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 11)),
                        SizedBox(width: 14.w),
                        Checkbox(
                          value: part.isAlfa,
                          onChanged: (val) => onUpdateSparePart(
                              index, part.copyWith(isAlfa: val ?? false)),
                          activeColor: ColorManager.primary,
                        ),
                        const Text('ALFA',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}
