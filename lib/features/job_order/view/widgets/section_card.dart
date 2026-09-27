import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/other/custom_text.dart';

class SectionCard extends StatelessWidget {
  final String titleEn;
  final String? titleAr;
  final IconData icon;
  final Widget child;
  final Widget? trailing;

  const SectionCard({
    super.key,
    required this.titleEn,
    this.titleAr,
    required this.icon,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF131F30),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF22364F),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFF18283E),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
              border: const Border(
                bottom: BorderSide(
                  color: Color(0xFF22364F),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: ColorManager.primary, size: 18.sp),
                SizedBox(width: 8.w),
                CustomText(
                  text: titleEn,
                  style: TextStyles.styleTextLGNormal,
                ),
                if (titleAr != null) ...[
                  SizedBox(width: 6.w),
                  CustomText(
                    text: '(${titleAr!})',
                    style: TextStyles.styleTextLGNormal.copyWith(
                      color: ColorManager.primary.withValues(alpha: 0.8),
                    ),
                  ),
                ],
                const Spacer(),
                if (trailing != null) trailing!,
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14.w),
            child: child,
          ),
        ],
      ),
    );
  }
}
