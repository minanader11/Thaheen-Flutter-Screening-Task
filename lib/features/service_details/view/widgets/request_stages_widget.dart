import 'package:base_project/core/constants/icons_paths.dart';
import 'package:base_project/core/styles/colors.dart';
import 'package:base_project/core/styles/styles.dart';
import 'package:base_project/core/widgets/other/custom_text.dart';
import 'package:base_project/features/service_details/view/widgets/stage_widget.dart';
import 'package:base_project/features/service_details/view/widgets/top_and_bottom_stage_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/generated/l10n.dart';

class RequestStagesWidget extends StatelessWidget {
  const RequestStagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: S.current.requestStages,
          textStyle: TextStyles.styleTextLGNormal.copyWith(
              color: ColorManager.black.withValues(alpha:0.88), fontSize: 16.sp),
        ),
        SizedBox(
          height: 32.h,
        ),
        const TopAndBottomStageWidget(
          isTop: true,
        ),
        ListView.builder(itemCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => StageWidget(
              image: IconsPath.messageQuestionIcon,
              itemDesc: S.current.max13Days,
              itemInfo: S.current.personalInquiry),
        ),

        // StageWidget(
        //     image: IconsPath.messageQuestionIcon,
        //     itemDesc: S.current.max13Days,
        //     itemInfo: S.current.personalInquiry),
        // StageWidget(
        //     image: IconsPath.messageQuestionIcon,
        //     itemDesc: S.current.max13Days,
        //     itemInfo: S.current.personalInquiry),
        const TopAndBottomStageWidget(
          isTop: false,
        ),
      ],
    );
  }
}
