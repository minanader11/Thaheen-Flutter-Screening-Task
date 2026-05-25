import 'package:flutter/material.dart';
import 'package:LJF_admin/core/styles/colors.dart';
import 'package:LJF_admin/core/widgets/other/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.text,
    this.onRetry,
  });

  final String text;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        alignment: AlignmentDirectional.center,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: ColorManager.red.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ImageHelper(
            //   image: ImagePaths.errorImage,
            //   imageType: ImageType.asset,
            //   height: 150.h,
            //   width: 200.w,
            // ),
            SizedBox(height: 10.h),
            CustomText(
              text: text,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: ColorManager.red,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            if (onRetry != null)
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.red,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 4,
                ),
                child: const CustomText(
                  text: "Try Again",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
