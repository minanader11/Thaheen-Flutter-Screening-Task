import 'package:base_project/core/constants/icons_paths.dart';
import 'package:base_project/core/styles/colors.dart';
import 'package:base_project/core/styles/styles.dart';
import 'package:base_project/core/widgets/other/custom_text.dart';
import 'package:base_project/core/widgets/other/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/generated/l10n.dart';

class TopAndBottomStageWidget extends StatelessWidget {
   const TopAndBottomStageWidget({super.key,required this.isTop});
  final isTop;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:isTop? CrossAxisAlignment.start:CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ImageHelper(image: isTop?IconsPath.topLineIcon:IconsPath.bottomLineIcon, imageType: ImageType.svg,width: 2.w,height: 100.h,),
        SizedBox(
          width: 24.w,
        ),
        CustomText(
          text: isTop?S.current.submitRequest:S.current.requestEnd,
          textStyle: TextStyles.styleTextLGNormal.copyWith(
              color: ColorManager.black.withValues(alpha: 0.88), fontSize: 16.sp),
        ),
      ],
    );
  }
}
