import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/other/custom_text.dart';
import 'form_field_input.dart';
import 'section_card.dart';

class ClientReportSectionWidget extends StatelessWidget {
  // Report controllers
  final TextEditingController reportDateController;
  final TextEditingController reportTimeController;
  final TextEditingController clientIdController;
  final TextEditingController printerIdController;
  final TextEditingController callingPersonController;
  final TextEditingController symptomController;
  final TextEditingController reportNotesController;

  // Client controllers
  final TextEditingController refNoController;
  final TextEditingController clientNameController;
  final TextEditingController addressController;
  final TextEditingController telNoController;
  final TextEditingController mobileNoController;
  final TextEditingController personInChargeController;
  final TextEditingController printerSnController;
  final TextEditingController assignedEngineerController;
  final TextEditingController backupEngineerController;

  const ClientReportSectionWidget({
    super.key,
    required this.reportDateController,
    required this.reportTimeController,
    required this.clientIdController,
    required this.printerIdController,
    required this.callingPersonController,
    required this.symptomController,
    required this.reportNotesController,
    required this.refNoController,
    required this.clientNameController,
    required this.addressController,
    required this.telNoController,
    required this.mobileNoController,
    required this.personInChargeController,
    required this.printerSnController,
    required this.assignedEngineerController,
    required this.backupEngineerController,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      titleEn: 'Reporting & Client Info',
      titleAr: 'بيانات الإبلاغ والعميل',
      icon: Icons.person_pin_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Subsection A: Client Information ──
          CustomText(
            text: 'Client Information (بيانات العميل):',
            style: TextStyles.styleTextLGNormal.copyWith(
              color: const Color(0xFF5BA3D0),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: FormFieldInput(
                  labelEn: 'Client Name',
                  labelAr: '(اسم العميل)',
                  controller: clientNameController,
                  hintText: 'e.g. Top Chemical',
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                flex: 1,
                child: FormFieldInput(
                  labelEn: 'Ref. No.',
                  labelAr: '(رقم الإبلاغ)',
                  controller: refNoController,
                  hintText: 'Ref No.',
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          FormFieldInput(
            labelEn: 'Address',
            labelAr: '(العنوان)',
            controller: addressController,
            hintText: 'e.g. Borg El-Arab',
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Tel No',
                  labelAr: '(هاتف)',
                  controller: telNoController,
                  hintText: 'Telephone',
                  keyboardType: TextInputType.phone,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Mobile No',
                  labelAr: '(موبايل)',
                  controller: mobileNoController,
                  hintText: 'Mobile',
                  keyboardType: TextInputType.phone,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Person in Charge',
                  labelAr: '(المسؤول لدى العميل)',
                  controller: personInChargeController,
                  hintText: 'Contact Person',
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Printer S/N',
                  labelAr: '(الرقم المسلسل)',
                  controller: printerSnController,
                  hintText: 'e.g. FR19480143',
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Assigned Engineer',
                  labelAr: '(المهندس المكلف)',
                  controller: assignedEngineerController,
                  hintText: 'e.g. Karam',
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Backup Engineer',
                  labelAr: '(المهندس البديل)',
                  controller: backupEngineerController,
                  hintText: 'Backup',
                ),
              ),
            ],
          ),

          SizedBox(height: 18.h),
          const Divider(color: Color(0xFF22364F), thickness: 1),
          SizedBox(height: 12.h),

          // ── Subsection B: Reporting Details ──
          CustomText(
            text: 'Reporting Details (الإبلاغ):',
            style: TextStyles.styleTextLGNormal.copyWith(
              color: const Color(0xFF5BA3D0),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Report Date',
                  labelAr: '(تاريخ البلاغ)',
                  controller: reportDateController,
                  hintText: 'DD/MM/YYYY',
                  suffixIcon: const Icon(Icons.calendar_today,
                      size: 16, color: Colors.white54),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Report Time',
                  labelAr: '(وقت البلاغ)',
                  controller: reportTimeController,
                  hintText: 'HH:MM',
                  suffixIcon: const Icon(Icons.access_time,
                      size: 16, color: Colors.white54),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Client ID',
                  labelAr: '(كود العميل)',
                  controller: clientIdController,
                  hintText: 'Client ID',
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: FormFieldInput(
                  labelEn: 'Printer ID',
                  labelAr: '(كود الطابعة)',
                  controller: printerIdController,
                  hintText: 'Printer ID',
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          FormFieldInput(
            labelEn: 'Calling Person',
            labelAr: '(الشخص المتصل)',
            controller: callingPersonController,
            hintText: 'Name of caller',
          ),
          SizedBox(height: 10.h),
          FormFieldInput(
            labelEn: 'Symptom',
            labelAr: '(العطل المُبلغ عنه)',
            controller: symptomController,
            hintText: 'e.g. 85, vacuum pump failure',
          ),
          SizedBox(height: 10.h),
          FormFieldInput(
            labelEn: 'Reporting Notes',
            labelAr: '(ملاحظات الإبلاغ)',
            controller: reportNotesController,
            hintText: 'e.g. سيتم ارسال عرض سعر بقطعة الغيار المطلوبه',
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
