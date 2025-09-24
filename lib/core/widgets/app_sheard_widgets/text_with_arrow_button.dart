import 'package:base_project/core/constants/icons_paths.dart';
import 'package:base_project/core/styles/colors.dart';
import 'package:base_project/core/styles/styles.dart';
import 'package:base_project/core/widgets/other/custom_text.dart';
import 'package:base_project/core/widgets/other/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextWithArrowButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const TextWithArrowButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: text,
            textStyle: TextStyles.styleTextLGNormal
                .copyWith(color: ColorManager.mainAppColor),
          ),
          SizedBox(
            width: 8.w,
          ),
          ImageHelper(
            image: IconsPath.leftArrowImage,
            imageType: ImageType.svg,
            height: 24.r,
          ),
        ],
      ),
    );
  }
}
