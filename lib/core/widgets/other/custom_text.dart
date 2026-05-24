// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:base_project/core/styles/colors.dart';
import 'package:base_project/core/styles/fonts.dart';
import 'package:base_project/core/styles/styles.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double? fontSize;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? spacing;
  const CustomText({
    super.key,
    required this.text,
    this.color = ColorManager.black,
    this.fontSize,
    this.style,
    this.textAlign,
    this.maxLines,
    this.textOverflow = TextOverflow.visible,
    this.fontWeight,
    this.fontFamily,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
      style: style ??
          TextStyle(
            fontSize: fontSize?.sp ?? FontManager.font16.sp,
            color: color,
            height: spacing,
            fontWeight: fontWeight,
            fontFamily: fontFamily ?? TextStyles.fontFamily,
          ),
    );
  }
}
