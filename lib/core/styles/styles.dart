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
}
