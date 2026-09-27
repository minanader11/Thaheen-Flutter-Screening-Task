// import 'package:Thaheen/core/styles/styles.dart';
// import 'package:Thaheen/core/widgets/other/custom_text.dart';
// import 'package:Thaheen/core/widgets/other/image_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class ServiceInfromationItem extends StatelessWidget {
//   final String image;
//   final String itemDesc;
//   final String itemInfo;
//   final Color imageColor;
//
//   const ServiceInfromationItem(
//       {super.key,
//       required this.image,
//       required this.itemDesc,
//       required this.itemInfo,
//       this.imageColor = Colors.black});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ImageHelper(
//           image: image,
//           color: imageColor,
//           imageType: ImageType.svg,
//         ),
//         SizedBox(
//           height: 16.h,
//         ),
//         CustomText(
//           text: itemDesc,
//           textStyle: TextStyles.styleTextLGNormal.copyWith(
//               color: Colors.black.withValues(alpha: 0.65), fontSize: 16.sp),
//         ),
//         SizedBox(
//           height: 4.h,
//         ),
//         CustomText(
//           text: itemInfo,
//           textStyle: TextStyles.styleHeading9
//               .copyWith(color: Colors.black, fontSize: 16.sp),
//         ),
//       ],
//     );
//   }
// }
