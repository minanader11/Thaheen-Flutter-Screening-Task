import 'package:Thaheen/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> alertDialog({
  required BuildContext context,
  required Widget widget,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext cxt) {
      return Dialog(
        surfaceTintColor: ColorManager.white,
        backgroundColor: ColorManager.white,
        insetPadding: EdgeInsets.all(32.r),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ), //this right here
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: SizedBox(
            width: double.infinity,
            child: widget,
          ),
        ),
      );
    },
  );
}