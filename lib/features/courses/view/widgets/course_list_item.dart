import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/other/custom_text.dart';
import '../../../../core/widgets/other/image_helper.dart';
import '../../../../core/routing/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/courses_cubit.dart';
import '../../model/course_model.dart';

class CourseListItem extends StatelessWidget {
  final CourseModel course;

  const CourseListItem({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final int progressPercentInt = (course.progressPercent * 100).round();
    final s = S.of(context);

    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () async {
            await Navigator.pushNamed(
              context,
              Routes.courseDetails,
              arguments: course.id,
            );
            if (context.mounted) {
              context.read<CoursesCubit>().getCourses();
            }
          },
          child: Padding(
            padding: EdgeInsets.all(14.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: ImageHelper(
                    imageType: ImageType.asset,
                    image: course.thumbnail,
                    imageShape: ImageShape.rectangle,
                    borderRadius: BorderRadius.circular(8.r),
                    width: 86.w,
                    height: 86.h,
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
                        style: TextStyles.titleLarge,
                        maxLines: 2,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline_rounded,
                            size: 15.r,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 3.h),
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerHighest
                                  .withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.menu_book_rounded,
                                  size: 13.r,
                                  color: ColorManager.textMuted,
                                ),
                                SizedBox(width: 4.w),
                                CustomText(
                                  text:
                                       '${course.totalLessons} ${s.lessons}',
                                  style: TextStyles.labelMedium,
                                ),
                              ],
                            ),
                          ),
                          CustomText(
                            text: '$progressPercentInt%',
                            style: TextStyles.labelMedium.copyWith(
                              color: ColorManager.primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: LinearProgressIndicator(
                          value: course.progressPercent,
                          minHeight: 5.h,
                          backgroundColor: colorScheme.outlineVariant,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            ColorManager.primary,
                          ),
                        ),
                      ),
                    ],
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
