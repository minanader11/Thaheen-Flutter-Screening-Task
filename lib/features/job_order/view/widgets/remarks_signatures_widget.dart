import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'form_field_input.dart';
import 'section_card.dart';

class RemarksSignaturesWidget extends StatelessWidget {
  final TextEditingController remarksController;
  final TextEditingController clientSignatureController;
  final TextEditingController engineerNameController;
  final TextEditingController reviewedByController;
  final TextEditingController authorizedByController;
  final TextEditingController dataEnteredByController;
  final TextEditingController formCodeController;
  final TextEditingController revCodeController;

  const RemarksSignaturesWidget({
    super.key,
    required this.remarksController,
    required this.clientSignatureController,
    required this.engineerNameController,
    required this.reviewedByController,
    required this.authorizedByController,
    required this.dataEnteredByController,
    required this.formCodeController,
    required this.revCodeController,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      titleEn: 'Remarks & Approvals',
      titleAr: 'الملاحظات والاعتمادات',
      icon: Icons.draw_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormFieldInput(
            labelEn: 'Remarks',
            labelAr: '(ملاحظات عامة)',
            controller: remarksController,
            hintText: 'e.g. سيتم ارسال عرض سعر بقطعة الغيار المطلوبه',
            maxLines: 3,
          ),
          SizedBox(height: 14.h),
          const Divider(color: Color(0xFF22364F), thickness: 1),
          SizedBox(height: 10.h),

          Row(
            children: [
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Client Signature',
                  labelAr: '(توقيع العميل)',
                  controller: clientSignatureController,
                  hintText: 'Signature / Name',
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Engineer Name',
                  labelAr: '(اسم المهندس)',
                  controller: engineerNameController,
                  hintText: 'e.g. Karam',
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          Row(
            children: [
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Reviewed By',
                  labelAr: '(المراجع)',
                  controller: reviewedByController,
                  hintText: 'Reviewer name',
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Authorized By',
                  labelAr: '(المعتمد)',
                  controller: authorizedByController,
                  hintText: 'Authorizer name',
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          FormFieldInput(
            labelEn: 'Data Entered By',
            labelAr: '(مُدخل البيانات)',
            controller: dataEnteredByController,
            hintText: 'Data entry name',
          ),
          SizedBox(height: 12.h),

          Row(
            children: [
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Form Code',
                  controller: formCodeController,
                  hintText: 'F-04-08',
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Revision',
                  controller: revCodeController,
                  hintText: 'Rev1',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
