import 'package:base_project/core/constants/icons_paths.dart';
import 'package:base_project/core/styles/colors.dart';
import 'package:base_project/core/styles/styles.dart';
import 'package:base_project/core/widgets/other/custom_text.dart';
import 'package:base_project/core/widgets/other/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/generated/l10n.dart';

class DocsItemWidget extends StatelessWidget {
  const DocsItemWidget(
      {super.key, required this.isRequired, required this.docName});

  final bool isRequired;
  final String docName;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Visibility(
            visible: isRequired,
            child: const ImageHelper(
                image: IconsPath.infoIcon, imageType: ImageType.svg)),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
          child: CustomText(textOverflow: TextOverflow.visible,
            text: docName,
            textStyle: TextStyles.styleTextLGNormal
                .copyWith(color: ColorManager.black, fontSize: 16.sp),
          ),
        ),
        SizedBox(width: 10.w,),
        CustomText(
          text: isRequired ? S.current.mandatory : S.current.optional,
          textStyle: TextStyles.styleTextLGNormal.copyWith(
              color: ColorManager.black.withValues(alpha:0.65), fontSize: 16.sp),
        ),
      ],
    );
  }
}
