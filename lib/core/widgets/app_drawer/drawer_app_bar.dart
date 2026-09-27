import 'package:Thaheen/core/constants/icons_paths.dart';
import 'package:Thaheen/core/styles/styles.dart';
import 'package:Thaheen/core/widgets/other/custom_text.dart';
import 'package:Thaheen/core/widgets/other/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../localization/generated/l10n.dart';

class DrawerAppBar extends StatelessWidget {
  final String? userName;
  final Function()? onTap;
  const DrawerAppBar({super.key, this.userName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: onTap,
            child: const ImageHelper(
                image: IconsPath.arrowRightIcon, imageType: ImageType.svg)),
        SizedBox(
          width: 11.w,
        ),
        Expanded(
            child: CustomText(
          text: S.current.greetingUser(userName ?? ""),
          style: TextStyles.styleTextLGStrong,
        ))
      ],
    );
  }
}
