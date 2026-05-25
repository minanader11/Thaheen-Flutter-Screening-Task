import 'package:flutter/material.dart';
import 'package:LJF_admin/core/styles/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoadingWidget extends StatelessWidget {
  final double? size;
  const CustomLoadingWidget({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? 50.h,
      width: size ?? 50.w,
      child: const CircularProgressIndicator(
        color: ColorManager.purple,
      ),
    );
  }
}
