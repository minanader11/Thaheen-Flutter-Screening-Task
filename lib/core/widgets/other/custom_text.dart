// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:LJF_admin/core/styles/colors.dart';
import 'package:LJF_admin/core/styles/fonts.dart';
import 'package:LJF_admin/core/styles/styles.dart';

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
    this.color = ColorManager.textMuted, // only used when no `style` is given
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
            // Use theme's onSurface so the text adapts to light/dark mode.
            // Only fall back to `color` field when explicitly needed.
            color: Theme.of(context).colorScheme.onSurface,
            height: spacing,
            fontWeight: fontWeight,
            fontFamily: fontFamily ?? TextStyles.fontFamily,
          ),
    );
  }
}
