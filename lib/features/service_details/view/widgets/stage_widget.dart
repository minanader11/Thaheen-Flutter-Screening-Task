import 'package:base_project/core/styles/colors.dart';
import 'package:base_project/core/widgets/app_sheard_widgets/service_infromation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StageWidget extends StatelessWidget {
  const StageWidget(
      {super.key,
      required this.image,
      required this.itemDesc,
      required this.itemInfo});

  final String image;
  final String itemDesc;
  final String itemInfo;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding:  EdgeInsetsDirectional.only(start: 2.2.w),
        child: Row(
          children: [
            Container(
              width: 1.w,
              decoration: const BoxDecoration(color: ColorManager.onboardingDotInactive),
            ),
            SizedBox(width: 24.w,),
            Column(
              children: [
                ServiceInfromationItem(
                    image: image, itemDesc: itemDesc, itemInfo: itemInfo),
                SizedBox(height: 68.h,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
