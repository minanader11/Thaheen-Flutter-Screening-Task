import 'package:base_project/core/styles/colors.dart';
import 'package:base_project/core/styles/fonts.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String msg, required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: chooseToastColor(state),
      textColor: chooseTextColor(state),
      fontSize: FontManager.font12.sp,
    );

//enum
// ignore: constant_identifier_names
enum ToastStates { SUCCRSS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCRSS:
      color = ColorManager.green;
      break;
    case ToastStates.ERROR:
      color = ColorManager.red;
      break;
    case ToastStates.WARNING:
      color = ColorManager.yellow;
      break;
  }
  return color;
}
Color chooseTextColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCRSS:
      color = ColorManager.black;
      break;
    case ToastStates.ERROR:
      color = ColorManager.white;
      break;
    case ToastStates.WARNING:
      color = ColorManager.yellow;
      break;
  }
  return color;
}