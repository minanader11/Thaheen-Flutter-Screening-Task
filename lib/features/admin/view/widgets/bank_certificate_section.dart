import 'package:LJF_admin/core/styles/colors.dart';
import 'package:LJF_admin/core/styles/styles.dart';
import 'package:LJF_admin/core/widgets/other/custom_text.dart';
import 'package:LJF_admin/features/admin/model/bank_certificate_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankCertificatesSection extends StatelessWidget {
  final List<BankCertificateModel> certificates;
  final VoidCallback onAdd;
  final void Function(int id) onDelete;

  const BankCertificatesSection({
    super.key,
    required this.certificates,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.card_membership_rounded, color: ColorManager.primary, size: 16.r),
            SizedBox(width: 6.w),
            CustomText(
              text: 'Certificate Catalog',
              style: TextStyles.font14WhiteBold.copyWith(color: ColorManager.primary),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onAdd,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: ColorManager.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: ColorManager.primary.withOpacity(0.5)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.add, color: ColorManager.primary, size: 14.r),
                    SizedBox(width: 4.w),
                    CustomText(
                      text: 'New',
                      style: TextStyles.font11WhiteBold.copyWith(color: ColorManager.primary),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        if (certificates.isEmpty)
          CustomText(
            text: 'No certificates defined yet',
            style: TextStyles.font12WhiteMedium.copyWith(color: Colors.white30),
          )
        else
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: certificates.map((cert) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: ColorManager.neutral.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: ColorManager.primary.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: '${cert.durationMinutes}min · +${cert.percentageGain.toStringAsFixed(0)}%',
                      style: TextStyles.font12WhiteMedium,
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () => onDelete(cert.id),
                      child: Icon(Icons.close, color: Colors.redAccent.withOpacity(0.7), size: 14.r),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}