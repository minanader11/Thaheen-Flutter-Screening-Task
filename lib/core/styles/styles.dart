// ignore_for_file: deprecated_member_use

import 'package:Thaheen/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  static String fontFamily = 'Cairo';

  // ── Existing styles (preserved) ───────────────────────────

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
    fontFamily: fontFamily,
    fontSize: 48.sp,
    fontWeight: FontWeight.w900,
    // color: null → inherits theme's onSurface (works in light & dark mode)
    letterSpacing: -1.0,
  );

  static TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
  );

  // ── Headline ──────────────────────────────────────────────

  static TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle headlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );

  // ── Title ─────────────────────────────────────────────────

  static TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );

  // ── Body ──────────────────────────────────────────────────

  static TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.textSecondary, // intentionally muted
  );

  // ── Label ─────────────────────────────────────────────────

  static TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: ColorManager.textSecondary, // intentionally muted
    letterSpacing: 0.5,
  );

  static TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 9.sp,
    fontWeight: FontWeight.w500,
    color: ColorManager.textSecondary, // intentionally muted
    letterSpacing: 0.5,
  );

  // ── Score (scoreboard specific) ───────────────────────────

  static TextStyle scoreHuge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 56.sp,
    fontWeight: FontWeight.w900,
    color: ColorManager.secondary,
    letterSpacing: -2.0,
  );

  static TextStyle scoreLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 30.sp,
    fontWeight: FontWeight.w900,
    color: ColorManager.secondary,
  );

  static TextStyle teamNameLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.w800,
    color: ColorManager.textPrimary,
    height: 1.2,
  );

  // ══════════════════════════════════════════════════════════
  // NEW — White variants used across admin & scoreboard
  // Convention: font{size}White{weight}
  // ══════════════════════════════════════════════════════════

  // ── 10sp ──────────────────────────────────────────────────

  static TextStyle font10WhiteRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle font10WhiteMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle font10WhiteBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  // ── 11sp ──────────────────────────────────────────────────

  static TextStyle font11WhiteRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle font11WhiteMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle font11WhiteBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  // ── 12sp ──────────────────────────────────────────────────

  static TextStyle font12WhiteRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle font12WhiteMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle font12WhiteBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  // ── 13sp ──────────────────────────────────────────────────

  static TextStyle font13WhiteRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle font13WhiteMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle font13WhiteBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  // ── 14sp ──────────────────────────────────────────────────

  static TextStyle font14WhiteRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle font14WhiteMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle font14WhiteBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  // ── 16sp ──────────────────────────────────────────────────

  static TextStyle font16WhiteRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle font16WhiteMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle font16WhiteBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  // ── 18sp ──────────────────────────────────────────────────

  static TextStyle font18WhiteRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle font18WhiteMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle font18WhiteBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  // ── 20sp ──────────────────────────────────────────────────

  static TextStyle font20WhiteRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle font20WhiteMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle font20WhiteBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  // ── 24sp ──────────────────────────────────────────────────

  static TextStyle font24WhiteRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static TextStyle font24WhiteMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle font24WhiteBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  // ── 28sp ──────────────────────────────────────────────────

  static TextStyle font28WhiteBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle font28WhiteBlack = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28.sp,
    fontWeight: FontWeight.w900,
    color: Colors.white,
    letterSpacing: -0.5,
  );

  // ── 32sp ──────────────────────────────────────────────────

  static TextStyle font32WhiteBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: -0.5,
  );

  static TextStyle font32WhiteBlack = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32.sp,
    fontWeight: FontWeight.w900,
    color: Colors.white,
    letterSpacing: -1.0,
  );

  // ── 40sp — scoreboard score numbers ───────────────────────

  static TextStyle font40WhiteBlack = TextStyle(
    fontFamily: fontFamily,
    fontSize: 40.sp,
    fontWeight: FontWeight.w900,
    color: Colors.white,
    letterSpacing: -1.5,
  );

  // ── 48sp — top-ranked score ───────────────────────────────

  static TextStyle font48WhiteBlack = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48.sp,
    fontWeight: FontWeight.w900,
    color: Colors.white,
    letterSpacing: -2.0,
  );
}