import 'package:Thaheen/core/constants/images_paths.dart';
import 'package:Thaheen/core/styles/colors.dart';
import 'package:Thaheen/core/styles/styles.dart';
import 'package:Thaheen/core/widgets/buttons/elevated_button.dart';
import 'package:Thaheen/core/widgets/other/custom_text.dart';
import 'package:Thaheen/core/widgets/other/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessScreenWidget extends StatelessWidget {
  const SuccessScreenWidget({
    super.key,
    required this.descMessage,
    required this.titleMessage,
    required this.actionTitle,
    required this.onPressedAction,
    this.imagePath,
  });

  final String titleMessage;
  final String descMessage;
  final String actionTitle;
  final Function() onPressedAction;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageHelper(
              image: imagePath ?? ImagesPaths.successImage,
              imageType: ImageType.svg,
            ),
            SizedBox(
              height: 16.h,
            ),
            CustomText(
              text: titleMessage,
              style: TextStyles.styleHeading8
                  .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 12.h,
            ),
            Flexible(
              child: CustomText(
                textOverflow: TextOverflow.visible,
                text: descMessage,
                textAlign: TextAlign.center,
                style: TextStyles.styleTextLGNormal.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.black,
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            ElevatedButtonWidget(
              backgroundColor: ColorManager.mainAppColor,
              borderColor: ColorManager.mainAppColor.withValues(alpha: 0.3),
              //   elevation: isEligble ? 3 : 0,
              title: actionTitle,
              width: double.maxFinite,
              onPressed: onPressedAction,
            ),
          ],
        ),
      ),
    );
  }
}
