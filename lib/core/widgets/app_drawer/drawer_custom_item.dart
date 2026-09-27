import 'package:LJF_admin/core/constants/icons_paths.dart';
import 'package:LJF_admin/core/styles/styles.dart';
import 'package:LJF_admin/core/widgets/other/custom_text.dart';
import 'package:LJF_admin/core/widgets/other/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerCustomItem extends StatelessWidget {
  const DrawerCustomItem(
      {super.key,
      required this.iconPath,
      required this.actionTitle,
this.onTapDrawerItem});

  final String iconPath;
  final String actionTitle;
  final Function()? onTapDrawerItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTapDrawerItem,
      child: Padding(
        padding:  EdgeInsetsDirectional.symmetric(vertical: 24.h),
        child: Row(
          children: [
            ImageHelper(
                image: iconPath,
                imageType: ImageType.svg,
                width: 24.w,
                height: 24.h),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
                child: CustomText(
              text: actionTitle,
              style: TextStyles.styleTextLGNormal.copyWith(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400),
            )),
            const ImageHelper(
              image: IconsPath.leftArrowImage,
              imageType: ImageType.svg,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
