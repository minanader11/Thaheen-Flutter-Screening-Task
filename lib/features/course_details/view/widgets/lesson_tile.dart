import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/lesson_rules.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/localization/lms_localization_extension.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/other/custom_text.dart';
import '../../../../core/routing/lesson_player_args.dart';
import '../../../../core/routing/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/course_details_cubit.dart';
import '../../../courses/model/lesson_model.dart';

class LessonTile extends StatelessWidget {
  final String courseId;
  final LessonModel lesson;
  final int index;
  final List<LessonModel> flatLessons;

  const LessonTile({
    super.key,
    required this.courseId,
    required this.lesson,
    required this.index,
    required this.flatLessons,
  });

  String _formatDuration(int durationSec) {
    final minutes = durationSec ~/ 60;
    final seconds = durationSec % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Widget _buildStatusBadge(bool isUnlocked) {
    if (!isUnlocked) {
      return Container(
        width: 34.r,
        height: 34.r,
        decoration: BoxDecoration(
          color: ColorManager.statusLocked.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.lock_outline_rounded,
          color: ColorManager.statusLocked,
          size: 18.r,
        ),
      );
    }

    if (lesson.isCompleted) {
      return Container(
        width: 34.r,
        height: 34.r,
        decoration: BoxDecoration(
          color: ColorManager.statusCompleted.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check_rounded,
          color: ColorManager.statusCompleted,
          size: 20.r,
        ),
      );
    }

    if (lesson.progress.status == 'inProgress') {
      return Container(
        width: 34.r,
        height: 34.r,
        decoration: BoxDecoration(
          color: ColorManager.statusInProgress.withValues(alpha: 0.18),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.play_arrow_rounded,
          color: ColorManager.statusInProgress,
          size: 20.r,
        ),
      );
    }

    return Container(
      width: 34.r,
      height: 34.r,
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.play_arrow_outlined,
        color: ColorManager.primary,
        size: 20.r,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final bool isUnlocked = isLessonUnlocked(flatLessons, index);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: isUnlocked
            ? colorScheme.surface
            : colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isUnlocked
              ? (lesson.progress.status == 'inProgress'
                  ? ColorManager.primary.withValues(alpha: 0.3)
                  : colorScheme.outlineVariant)
              : colorScheme.outlineVariant.withValues(alpha: 0.6),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.r),
          onTap: () async {
            if (!isUnlocked) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: ColorManager.error,
                  content: CustomText(
                    text: s.lessonLocked,
                    style: TextStyles.bodyMedium.copyWith(
                      color: ColorManager.textOnPrimary,
                    ),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            } else {
              await Navigator.pushNamed(
                context,
                Routes.lessonPlayer,
                arguments: LessonPlayerArgs(
                  courseId: courseId,
                  lessonId: lesson.id,
                ),
              );
              if (context.mounted) {
                context.read<CourseDetailsCubit>().refresh();
              }
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Row(
              children: [
                _buildStatusBadge(isUnlocked),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: lesson.title,
                        style: TextStyles.bodyLarge.copyWith(
                          color: isUnlocked
                              ? colorScheme.onSurface
                              : ColorManager.textMuted,
                        ),
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                      if (lesson.progress.status == 'inProgress') ...[
                        SizedBox(height: 3.h),
                        CustomText(
                          text: s.statusInProgress,
                          style: TextStyles.labelSmall.copyWith(
                            color: ColorManager.statusInProgress,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 13.r,
                        color: ColorManager.textMuted,
                      ),
                      SizedBox(width: 4.w),
                      CustomText(
                        text: _formatDuration(lesson.durationSec),
                        style: TextStyles.labelMedium.copyWith(
                          color: ColorManager.textMuted,
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
