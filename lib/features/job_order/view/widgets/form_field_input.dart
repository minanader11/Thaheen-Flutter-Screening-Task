import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/other/custom_text.dart';

class FormFieldInput extends StatelessWidget {
  final String labelEn;
  final String? labelAr;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final TextInputType keyboardType;

  const FormFieldInput({
    super.key,
    required this.labelEn,
    this.labelAr,
    required this.controller,
    this.onChanged,
    this.hintText,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: labelEn,
              style: TextStyles.styleTextLGNormal.copyWith(
                color: const Color(0xFF94A3B8),
                fontSize: 11.5.sp,
              ),
            ),
            if (labelAr != null) ...[
              SizedBox(width: 4.w),
              CustomText(
                text: labelAr!,
                style: TextStyles.styleTextLGNormal.copyWith(
                  color: const Color(0xFF64748B),
                  fontSize: 10.5.sp,
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: 5.h),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          readOnly: readOnly,
          onTap: onTap,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: TextStyles.styleTextLGNormal.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.normal,
          ),
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.white24,
              fontSize: 12.sp,
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: const Color(0xFF0C1624),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 9.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFF22364F), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide:
                  const BorderSide(color: ColorManager.primary, width: 1.2),
            ),
          ),
        ),
      ],
    );
  }
}
