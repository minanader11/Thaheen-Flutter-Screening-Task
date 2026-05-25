import 'package:LJF_admin/core/styles/colors.dart';
import 'package:LJF_admin/core/constants/icons_paths.dart';
import 'package:LJF_admin/core/constants/images_paths.dart';
import 'package:LJF_admin/core/helper/navigation_extensions.dart';
import 'package:LJF_admin/core/routing/routes.dart';

import 'package:LJF_admin/core/styles/colors.dart';
import 'package:LJF_admin/core/widgets/app_drawer/drawer_app_bar.dart';
import 'package:LJF_admin/core/widgets/app_drawer/drawer_custom_item.dart';
import 'package:LJF_admin/core/widgets/other/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../localization/generated/l10n.dart';

class AppDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const AppDrawer({super.key, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
        ),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Container(
            height: 844.h,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  color: ColorManager.mainAppColor,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: 24.w, end: 24.w, top: 68.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DrawerAppBar(
                          onTap: () {
                            scaffoldKey!.currentState!.closeDrawer();
                          },
                          userName: "سلمان احمد محمد",
                        ),
                        SizedBox(
                          height: 48.h,
                        ),
                        DrawerCustomItem(
                            onTapDrawerItem: () {
                            },
                            iconPath: IconsPath.homeIcon,
                            actionTitle: S.current.home),
                        SizedBox(
                          height: 24.h,
                        ),
                        DrawerCustomItem(onTapDrawerItem: () {
                          context.pushNamed(Routes.availableService);
                        },
                          iconPath: IconsPath.allIcon,
                          actionTitle: S.current.availableServices,

                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        DrawerCustomItem(
                          iconPath: IconsPath.requestsIcon,
                          actionTitle: S.current.yourRequests,
                          onTapDrawerItem: () {
                            context.pushNamed(Routes.allYourRequests);
                          },
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        DrawerCustomItem(
                          iconPath: IconsPath.userIcon,
                          actionTitle: S.current.socialSecurityCard,
                          onTapDrawerItem: () {},
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        DrawerCustomItem(
                          iconPath: IconsPath.newsICon,
                          actionTitle: S.current.newsAndAnnouncements,
                          onTapDrawerItem: () {},
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        DrawerCustomItem(
                          iconPath: IconsPath.logoutICon,
                          actionTitle: S.current.logout,
                          onTapDrawerItem: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsetsDirectional.symmetric(vertical: 48.h),
                  child: Center(
                    child: ImageHelper(
                        image: ImagesPaths.logo, imageType: ImageType.svg),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
