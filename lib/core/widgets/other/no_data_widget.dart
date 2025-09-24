import 'package:flutter/material.dart';
import 'package:base_project/core/styles/colors.dart';
import 'package:base_project/core/widgets/other/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        alignment: AlignmentDirectional.center,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          children: [
            // ImageHelper(
            //   image: ImagePaths.noDataImage,
            //   imageType: ImageType.asset,
            //   height: 150.h,
            //   width: 200.w,
            //   color: ColorManager.purple9468EA,
            // ),
            SizedBox(height: 20.h),
            CustomText(
              text: "There is No $title ",
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: ColorManager.purple,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
