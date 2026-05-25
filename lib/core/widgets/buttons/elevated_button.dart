// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:LJF_admin/core/styles/colors.dart';
import 'package:LJF_admin/core/styles/styles.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Widget? buttonChild;
  final double width;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;

  final double? elevation;
  final double? borderRadius;
  final Color? borderColor;

  const ElevatedButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.buttonChild,
    this.width = double.infinity,
    this.padding,
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.borderRadius,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:
          width == double.infinity ? MediaQuery.of(context).size.width : width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: elevation ?? 5,

          padding: padding ?? EdgeInsets.symmetric(vertical: 7.h),
          textStyle: textStyle ?? TextStyles.styleTextLGNormal,
          backgroundColor:
              backgroundColor ?? ColorManager.mainAppColor, // background color
          foregroundColor: foregroundColor ?? ColorManager.white, // text color
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor ?? ColorManager.mainAppColor,
            ),
            borderRadius:
                BorderRadius.circular(borderRadius ?? 8.r), // <-- Radius
          ),
          overlayColor: ColorManager.mainAppColor,
        ),
        // .copyWith(
        //   elevation: MaterialStateProperty.resolveWith<double>((states) {
        //     if (states.contains(MaterialState.pressed)) {
        //       return (elevation ?? 5) + 3; // 👈 when pressed
        //     }
        //     return elevation ?? 5;
        //   }),
        // ),
        onPressed: onPressed,
        child: buttonChild ??
            Text(
              title,
              style: textStyle,
            ),
      ),
    );
  }
}
