import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/other/custom_text.dart';
import '../../../../core/widgets/other/image_helper.dart';
import '../../../courses/model/course_model.dart';

class CourseHeaderCard extends StatelessWidget {
  final CourseModel course;

  const CourseHeaderCard({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final int progressPercentInt = (course.progressPercent * 100).round();
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: ImageHelper(
                  imageType: ImageType.asset,
                  image: course.thumbnail,
                  imageShape: ImageShape.rectangle,
                  borderRadius: BorderRadius.circular(10.r),
                  width: 96.w,
                  height: 96.h,
                  boxFit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: course.title,
                      style: TextStyles.headlineSmall,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline_rounded,
                          size: 16.r,
                          color: ColorManager.textMuted,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: CustomText(
                            text: course.instructor,
                            style: TextStyles.bodyMedium.copyWith(
                              color: ColorManager.textMuted,
                            ),
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color:
                            colorScheme.surfaceContainerHighest.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: CustomText(
                        text:
                            '${course.completedLessons} / ${course.totalLessons} ${S.current.lessons}',
                        style: TextStyles.labelMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: S.current.progress,
                style: TextStyles.labelMedium,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: ColorManager.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: CustomText(
                  text: '$progressPercentInt%',
                  style: TextStyles.labelMedium.copyWith(
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: course.progressPercent,
              minHeight: 6.h,
              backgroundColor: colorScheme.outlineVariant,
              valueColor: const AlwaysStoppedAnimation<Color>(
                ColorManager.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
