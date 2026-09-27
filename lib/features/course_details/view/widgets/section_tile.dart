import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/other/custom_text.dart';
import '../../../../core/widgets/other/no_data_widget.dart';
import '../../../courses/model/course_model.dart';
import '../../../courses/model/section_model.dart';
import 'lesson_tile.dart';

class SectionTile extends StatelessWidget {
  final String courseId;
  final SectionModel section;
  final CourseModel course;

  const SectionTile({
    super.key,
    required this.courseId,
    required this.section,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final flatLessons = course.flatLessons;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                Container(
                  width: 4.w,
                  height: 18.h,
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: CustomText(
                    text: section.title,
                    style: TextStyles.titleLarge,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: CustomText(
                    text: '${section.lessons.length} ${s.lessons}',
                    style: TextStyles.labelSmall.copyWith(
                      color: ColorManager.textMuted,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (section.lessons.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: NoDataWidget(
                title: s.lessons,
              ),
            )
          else
            ...section.lessons.map((lesson) {
              final index = flatLessons.indexOf(lesson);
              return LessonTile(
                courseId: courseId,
                lesson: lesson,
                index: index,
                flatLessons: flatLessons,
              );
            }),
        ],
      ),
    );
  }
}
