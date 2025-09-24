import 'package:base_project/core/constants/icons_paths.dart';
import 'package:base_project/core/widgets/app_sheard_widgets/service_infromation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/localization/generated/l10n.dart';

class ServiceInformationSection extends StatelessWidget {
  const ServiceInformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      // textDirection: Directionality.of(context), // يقرأ من إعدادات التطبيق
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ServiceInfromationItem(
                  image: IconsPath.serviceTypeIcon,
                  itemDesc: S.current.serviceType,
                  itemInfo: S.current.electronic),
            ),

            Expanded(
              child: ServiceInfromationItem(
                  image: IconsPath.cashIcon,
                  itemDesc: S.current.serviceType,
                  itemInfo: S.current.electronic),
            ),
          ],
        ),
        SizedBox(height: 32.h,),
        ServiceInfromationItem(
            image: IconsPath.calendarIcon,
            itemDesc: S.current.serviceType,
            itemInfo: S.current.electronic),
      ],
    );
  }
}
