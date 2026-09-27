import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/other/custom_text.dart';
import '../../../../core/widgets/other/image_helper.dart';
import '../../../../core/routing/lesson_player_args.dart';
import '../../../../core/routing/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/courses_cubit.dart';
import '../../model/course_model.dart';
import '../../model/lesson_model.dart';

class ContinueWatchingCard extends StatelessWidget {
  final CourseModel course;
  final LessonModel lesson;

  const ContinueWatchingCard({
    super.key,
    required this.course,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final double progress = lesson.durationSec > 0
        ? (lesson.progress.positionSec / lesson.durationSec).clamp(0.0, 1.0)
        : 0.0;
    final int percentInt = (progress * 100).round();

    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
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
              Routes.lessonPlayer,
              arguments: LessonPlayerArgs(
                courseId: course.id,
                lessonId: lesson.id,
              ),
            );
            if (context.mounted) {
              context.read<CoursesCubit>().getCourses();
            }
          },
          child: Padding(
            padding: EdgeInsets.all(14.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: BoxDecoration(
                            color: ColorManager.primary.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: ColorManager.primary,
                            size: 16.r,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        CustomText(
                          text: s.continueWatching,
                          style: TextStyles.labelLarge.copyWith(
                            color: ColorManager.primary,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: CustomText(
                        text: '$percentInt%',
                        style: TextStyles.labelMedium.copyWith(
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ImageHelper(
                          imageType: ImageType.asset,
                          image: course.thumbnail,
                          imageShape: ImageShape.rectangle,
                          borderRadius: BorderRadius.circular(8.r),
                          width: 72.w,
                          height: 72.h,
                          boxFit: BoxFit.cover,
                        ),
                        Container(
                          width: 28.r,
                          height: 28.r,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 18.r,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: lesson.title,
                            style: TextStyles.titleMedium,
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          CustomText(
                            text: course.title,
                            style: TextStyles.bodyMedium.copyWith(
                              color: ColorManager.textMuted,
                            ),
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.h),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.r),
                            child: LinearProgressIndicator(
                              value: progress,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
