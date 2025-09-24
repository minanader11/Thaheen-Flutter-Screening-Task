import 'package:base_project/core/constants/images_paths.dart';
import 'package:base_project/core/styles/colors.dart';
import 'package:base_project/core/styles/styles.dart';
import 'package:base_project/core/widgets/buttons/elevated_button.dart';
import 'package:base_project/core/widgets/other/custom_text.dart';
import 'package:base_project/core/widgets/other/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../localization/generated/l10n.dart';

class FailureScreenWidget extends StatelessWidget {
  const FailureScreenWidget(
      {super.key,
      required this.failureDescMessage,
      required this.failureTitleMessage,
      required this.actionTitle,
      required this.onPressedAction,
      required this.onPressedSecondAction,
      required this.secondActionTitle});

  final String failureTitleMessage;
  final String failureDescMessage;
  final String actionTitle;
  final Function() onPressedAction;
  final String secondActionTitle;
  final Function() onPressedSecondAction;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ImageHelper(
                image: ImagesPaths.failureImage, imageType: ImageType.svg),
            SizedBox(height: 16.h),
            CustomText(
              text: S.current.failedAction(failureTitleMessage),
              textStyle: TextStyles.styleHeading8.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            Flexible(
              child: CustomText(
                textOverflow: TextOverflow.visible,
                text: failureDescMessage,
                textAlign: TextAlign.center,
                textStyle: TextStyles.styleTextLGNormal.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.black,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButtonWidget(
              backgroundColor: ColorManager.mainAppColor,
              borderColor: ColorManager.mainAppColor.withValues(alpha: 0.3),
              //   elevation: isEligble ? 3 : 0,
              title: actionTitle,
              width: double.maxFinite,
              onPressed: onPressedAction,
            ),
            SizedBox(height: 30.h),
            InkWell(
              onTap: onPressedSecondAction,
              child: CustomText(
                textOverflow: TextOverflow.visible,
                text: secondActionTitle,
                textStyle: TextStyles.styleTextLGNormal.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.mainAppColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
