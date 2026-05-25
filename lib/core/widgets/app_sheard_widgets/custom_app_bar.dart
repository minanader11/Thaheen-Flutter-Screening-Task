// import 'package:LJF_admin/core/constants/icons_paths.dart';
// import 'package:LJF_admin/core/helper/navigation_extensions.dart';
// import 'package:LJF_admin/core/styles/colors.dart';
// import 'package:LJF_admin/core/styles/styles.dart';
// import 'package:LJF_admin/core/widgets/other/custom_text.dart';
// import 'package:LJF_admin/core/widgets/other/image_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar(
//       {super.key,
//       required this.withBackArrow,
//       required this.appBarTitle,
//       required this.onTapDrawerMenu,
//       this.contentWidget,
//       required this.height});
//
//   final bool withBackArrow;
//   final String appBarTitle;
//   final Function() onTapDrawerMenu;
//   final Widget? contentWidget;
//   final double height;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: ColorManager.mainAppColor,
//       automaticallyImplyLeading: false,
//       flexibleSpace: Padding(
//         padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, top: 5.h),
//         child: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Visibility(
//                     visible: withBackArrow,
//                     child: GestureDetector(
//                       onTap: () {
//                         context.pop();
//                       },
//                       child: const ImageHelper(
//                         image: IconsPath.arrowRightIcon,
//                         imageType: ImageType.svg,
//                       ),
//                     ),
//                   ),
//                   Visibility(
//                     visible: withBackArrow,
//                     child: SizedBox(
//                       width: 12.w,
//                     ),
//                   ),
//                   CustomText(
//                     text: appBarTitle,
//                     textStyle: TextStyles.styleTextLGNormal.copyWith(
//                         color: Colors.white,
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w700),
//                   ),
//                   const Spacer(),
//                   GestureDetector(
//                     onTap: onTapDrawerMenu,
//                     child: const ImageHelper(
//                       image: IconsPath.drawerImage,
//                       imageType: ImageType.svg,
//                     ),
//                   )
//                 ],
//               ),
//               if (contentWidget != null) contentWidget!
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(height);
// }
