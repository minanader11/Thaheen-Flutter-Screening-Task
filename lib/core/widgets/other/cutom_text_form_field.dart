// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Thaheen/core/styles/colors.dart';
import 'package:Thaheen/core/styles/styles.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final bool? readOnly;
  final bool? expands;
  final bool? enabled;
  final int? maxLines;
  final int? maxLength;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? prefix;
  final bool? filled;
  final Color? fillColor;
  final String hintText;
  final TextStyle? hintStyle;
  final bool? isObscureText;
  final FormFieldValidator<String?>? validationFunc;
  final TextInputType? keyboardType;
  final ValueChanged<String?>? onChanged;
  final VoidCallback? onEditingComplete;
  final void Function(String?)? onFieldSubmitted;
  final VoidCallback? onTap;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.contentPadding,
    this.readOnly,
    this.expands,
    this.enabled,
    this.maxLines,
    this.maxLength,
    this.errorBorder,
    this.focusedErrorBorder,
    this.focusedBorder,
    this.enabledBorder,
    this.suffixIcon,
    this.suffix,
    this.prefixIcon,
    this.prefix,
    this.filled,
    this.fillColor,
    required this.hintText,
    this.hintStyle,
    this.isObscureText,
    this.validationFunc,
    this.keyboardType,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly ?? false,
      expands: expands ?? false,
      enabled: enabled ?? true,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      style: TextStyles.styleTextLGNormal,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 0.w, vertical: 12.h),

        //Shown when the field has an error and it is not focused.
        errorStyle: TextStyles.styleTextSMStrong.copyWith(
          height: 2.h,
          color: ColorManager.errorBorder,
        ),

        errorBorder: errorBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorManager.errorBorder,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
        //Shown when the field has an error and it is focused.
        focusedErrorBorder: focusedErrorBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorManager.errorBorder,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
        //Shown when the TextFormField is enabled and currently focused (the user has tapped on it and the keyboard is open).
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorManager.mainAppColor,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),

        // Shown when the TextFormField is enabled but not focused.
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorManager.borderColor,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
        hintText: hintText,
        hintStyle:
            hintStyle ?? TextStyles.styleTextLGNormal.copyWith(fontSize: 13.sp),
        suffixIcon: suffixIcon,
        prefix: prefixIcon != null ? null : (prefix ?? SizedBox(width: 12.w)),
        suffix: suffixIcon != null ? null : (suffix ?? SizedBox(width: 12.w)),
        prefixIcon: prefixIcon,
        filled: filled ?? true,
        fillColor: fillColor ?? ColorManager.secondaryBackground,
      ),
      obscureText: isObscureText ?? false,
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validationFunc,
      onTap: onTap,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
