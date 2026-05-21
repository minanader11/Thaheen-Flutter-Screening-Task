// ignore_for_file: deprecated_member_use

import 'package:base_project/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  static String fontFamily = 'Cairo';

  static TextStyle styleTextLGNormal = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    color: Colors.black.withOpacity(0.45),
  );


  static TextStyle styleHeading9 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
    color: ColorManager.black,
  );

  static TextStyle styleHeading8 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 20.sp,
    color: ColorManager.black,
  );

  static TextStyle styleTextSMStrong = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 12.sp,
    color: ColorManager.black,
  );

  static TextStyle styleTextSMNormal = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: ColorManager.black,
  );

  static TextStyle styleTextLGUnderline = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    color: ColorManager.mainAppColor,
    decoration: TextDecoration.underline,
    decorationThickness: 2,
    decorationColor: ColorManager.mainAppColor,
  );

  static TextStyle styleTextBaseNormal = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: ColorManager.mainAppColor,
  );
  static TextStyle styleTextLGStrong = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
    color: Colors.white,
  );
  // ── Display ───────────────────────────────────────────────
  static TextStyle displayLarge = TextStyle(
    fontSize: 48.sp,
    fontWeight: FontWeight.w900,
    color: ColorManager.textPrimary,
    letterSpacing: -1.0,
  );

  static TextStyle displayMedium = TextStyle(
    fontSize: 36.sp,
    fontWeight: FontWeight.w800,
    color: ColorManager.textPrimary,
    letterSpacing: -0.5,
  );

  // ── Headline ──────────────────────────────────────────────
  static TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    color: ColorManager.textPrimary,
  );

  static TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
    color: ColorManager.textPrimary,
  );

  static TextStyle headlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: ColorManager.textPrimary,
  );

  // ── Title ─────────────────────────────────────────────────
  static TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: ColorManager.textPrimary,
  );

  static TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: ColorManager.textPrimary,
  );

  // ── Body ──────────────────────────────────────────────────
  static TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.textPrimary,
  );

  static TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.textPrimary,
  );

  static TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.textSecondary,
  );

  // ── Label ─────────────────────────────────────────────────
  static TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: ColorManager.textPrimary,
    letterSpacing: 0.5,
  );

  static TextStyle labelMedium = TextStyle(  fontFamily: fontFamily,
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: ColorManager.textSecondary,
    letterSpacing: 0.5,
  );

  // ── Score (scoreboard specific) ───────────────────────────
  static TextStyle scoreHuge = TextStyle(  fontFamily: fontFamily,
    fontSize: 56.sp,
    fontWeight: FontWeight.w900,
    color: ColorManager.secondary,
    letterSpacing: -2.0,
  );

  static TextStyle scoreLarge = TextStyle(  fontFamily: fontFamily,
    fontSize: 30.sp,
    fontWeight: FontWeight.w900,
    color: ColorManager.secondary,
  );

  static TextStyle teamNameLarge = TextStyle(  fontFamily: fontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.w800,
    color: ColorManager.textPrimary,
    height: 1.2,
  );
}
