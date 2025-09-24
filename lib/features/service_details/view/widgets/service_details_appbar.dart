import 'package:base_project/core/localization/generated/l10n.dart';
import 'package:base_project/core/styles/styles.dart';
import 'package:base_project/core/widgets/other/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceDetailsAppbarContentWidget extends StatelessWidget {
  const ServiceDetailsAppbarContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            CustomText(
              text: S.of(context).serviceRequest,
              textStyle: TextStyles.styleHeading8
                  .copyWith(color: Colors.white, fontSize: 16.sp),
              maxLines: 3,
            ),
            SizedBox(height: 24.h),
            CustomText(
              text: S.of(context).serviceDescription,
              textStyle: TextStyles.styleTextLGNormal
                  .copyWith(color: Colors.white, fontSize: 16.sp),
              maxLines: 3,
            ),
            SizedBox(height: 24.h),
            CustomText(
              text: S.of(context).seeMore,
              textStyle: TextStyles.styleTextLGNormal
                  .copyWith(color: Colors.white, fontSize: 16.sp),
            ),
          ],

    );
  }


}
