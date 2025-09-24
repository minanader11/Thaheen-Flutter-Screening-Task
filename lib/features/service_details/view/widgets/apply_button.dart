import 'package:base_project/core/constants/icons_paths.dart';
import 'package:base_project/core/helper/navigation_extensions.dart';
import 'package:base_project/core/routing/routes.dart';
import 'package:base_project/core/styles/colors.dart';
import 'package:base_project/core/styles/styles.dart';
import 'package:base_project/core/widgets/buttons/elevated_button.dart';
import 'package:base_project/core/widgets/other/custom_text.dart';
import 'package:base_project/core/widgets/other/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/generated/l10n.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton({super.key, required this.isEligble});

  final bool isEligble;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
            visible: !isEligble,
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 21.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ImageHelper(
                      image: IconsPath.warningIcon, imageType: ImageType.svg),
                  SizedBox(
                    width: 8.w,
                  ),
                  CustomText(
                    textOverflow: TextOverflow.visible,
                    text: S.current.cannotSubmitRequest,
                    textStyle: TextStyles.styleTextSMStrong.copyWith(
                        color: ColorManager.warningColor, fontSize: 12.sp),
                  ),
                  // Spacer()
                ],
              ),
            )),
        Visibility(
            visible: !isEligble,
            child: SizedBox(
              height: 16.h,
            )),
        ElevatedButtonWidget(
          backgroundColor: isEligble
              ? null
              : ColorManager.mainAppColor.withValues(alpha: 0.3),
          borderColor: isEligble
              ? null
              : ColorManager.mainAppColor.withValues(alpha: 0.3),
          elevation: isEligble ? 3 : 0,
          title: S.of(context).applyNow,
          width: double.maxFinite,
          onPressed: () {
            context.pushNamed(Routes.submitServiceRequest);
          },
        )
      ],
    );
  }
}
