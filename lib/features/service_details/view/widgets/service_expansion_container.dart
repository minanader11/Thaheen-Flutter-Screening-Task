import 'package:base_project/core/constants/icons_paths.dart';
import 'package:base_project/core/styles/colors.dart';
import 'package:base_project/core/styles/styles.dart';
import 'package:base_project/core/widgets/other/custom_text.dart';
import 'package:base_project/core/widgets/other/image_helper.dart';
import 'package:base_project/features/service_details/view/widgets/condition_item_widget.dart';
import 'package:base_project/features/service_details/view/widgets/docs_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/generated/l10n.dart';

class ServiceExpansionContainer extends StatelessWidget {
  const ServiceExpansionContainer(
      {super.key,
      required this.forConditions,
      required this.isExpanded,
      required this.onToggle,
      this.isElligble});

  final bool forConditions;
  final bool isExpanded;
  final VoidCallback onToggle;
  final bool? isElligble;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsetsDirectional.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: ColorManager.borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Visibility(
                  visible: forConditions,
                  child: const ImageHelper(
                      image: IconsPath.warningIcon, imageType: ImageType.svg)),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                child: CustomText(
                  text: forConditions
                      ? isElligble ?? false
                          ? S.current.eligible
                          : S.current.notEligible
                      : S.current.requiredDocuments,
                  textStyle: TextStyles.styleTextSMStrong.copyWith(
                      color: forConditions
                          ? isElligble ?? false
                              ? ColorManager.green135200
                              : ColorManager.warningColor
                          : Colors.black.withValues(alpha:0.88),
                      fontSize: 12.sp),
                ),
              ),
              // SizedBox(
              //   width: 82.w,
              // ),
              InkWell(onTap: onToggle,
                child: CustomText(
                  text: isExpanded
                      ? (forConditions
                          ? S.current.hideConditions
                          : S.current.hide)
                      : (forConditions
                          ? S.current.viewConditions
                          : S.current.view),
                  textStyle: TextStyles.styleTextLGNormal.copyWith(
                      color: ColorManager.mainAppColor, fontSize: 16.sp),
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              InkWell(
                onTap: onToggle,
                child: ImageHelper(
                    image: isExpanded
                        ? IconsPath.arrowUpIcon
                        : IconsPath.arrowDownIcon,
                    imageType: ImageType.svg),
              )
            ],
          ),
          Visibility(visible: isExpanded,
            child: SizedBox(
              height: 24.h,
            ),
          ),
          if (forConditions&&isExpanded)
            ListView.separated(separatorBuilder: (context, index) => SizedBox(height: 24.h,),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) => ConditionItemWidget(
                  isEligible: index%2==0?true:false,
                  conditionDesc: S.current.socialSecuritySubscription),
            )
          else if (!forConditions&&isExpanded)
            ListView.separated(separatorBuilder: (context, index) => SizedBox(height: 24.h,),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) =>
                  DocsItemWidget(isRequired: index%2==0?true:false, docName: S.current.idCard),
            )
        ],
      ),
    );
  }
}
