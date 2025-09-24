import 'package:base_project/core/constants/icons_paths.dart';
import 'package:base_project/core/styles/colors.dart';
import 'package:base_project/core/styles/styles.dart';
import 'package:base_project/core/widgets/other/custom_text.dart';
import 'package:base_project/core/widgets/other/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ConditionItemWidget extends StatelessWidget {
  const ConditionItemWidget(
      {super.key, required this.isEligible, required this.conditionDesc});

  final bool isEligible;
  final String conditionDesc;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageHelper(
            image: isEligible ? IconsPath.correctIcon : IconsPath.wrongIcon,
            imageType: ImageType.svg),
        SizedBox(
          height: 12.h,
        ),
        IntrinsicHeight(
          child: CustomText(textOverflow: TextOverflow.visible,
            text: conditionDesc,
            textStyle: TextStyles.styleTextLGNormal.copyWith(
                color:
                    isEligible ? ColorManager.black : ColorManager.warningColor,
                fontSize: 16.sp),
           
          ),
        ),
      ],
    );
  }
}
