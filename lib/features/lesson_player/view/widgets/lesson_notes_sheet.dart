import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/services/lesson_notes_service.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/buttons/elevated_button.dart';
import '../../../../core/widgets/other/custom_text.dart';

class LessonNotesSheet extends StatefulWidget {
  final String courseId;
  final String lessonId;
  final String lessonTitle;

  const LessonNotesSheet({
    super.key,
    required this.courseId,
    required this.lessonId,
    required this.lessonTitle,
  });

  @override
  State<LessonNotesSheet> createState() => _LessonNotesSheetState();
}

class _LessonNotesSheetState extends State<LessonNotesSheet> {
  late final TextEditingController _noteController;
  late final LessonNotesService _notesService;
  bool _hasExistingNote = false;

  @override
  void initState() {
    super.initState();
    _notesService = getIt<LessonNotesService>();
    final savedNote = _notesService.getNote(
      courseId: widget.courseId,
      lessonId: widget.lessonId,
    );
    _noteController = TextEditingController(text: savedNote ?? '');
    _hasExistingNote = (savedNote != null && savedNote.trim().isNotEmpty);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    final text = _noteController.text.trim();
    await _notesService.saveNote(
      courseId: widget.courseId,
      lessonId: widget.lessonId,
      note: text,
    );
    if (mounted) {
      final s = S.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomText(
            text: s.noteSaved,
            style: TextStyles.bodyMedium.copyWith(color: Colors.white),
          ),
          backgroundColor: ColorManager.success,
          duration: const Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _deleteNote() async {
    await _notesService.deleteNote(
      courseId: widget.courseId,
      lessonId: widget.lessonId,
    );
    if (mounted) {
      final s = S.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomText(
            text: s.noteDeleted,
            style: TextStyles.bodyMedium.copyWith(color: Colors.white),
          ),
          backgroundColor: ColorManager.error,
          duration: const Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 15,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white24 : Colors.black12,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Header row with Icon, Title, and Close Button
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.note_alt_outlined,
                    color: ColorManager.primary,
                    size: 20.r,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: s.lessonNotes,
                        style: TextStyles.titleMedium,
                      ),
                      CustomText(
                        text: widget.lessonTitle,
                        style: TextStyles.labelMedium.copyWith(
                          color: ColorManager.textMuted,
                        ),
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  color: ColorManager.textMuted,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Note Multiline Input Field
            Container(
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : ColorManager.background,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: isDark ? Colors.white12 : ColorManager.cardBorder,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: TextField(
                controller: _noteController,
                maxLines: 6,
                minLines: 4,
                style: TextStyles.bodyMedium.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  hintText: s.addNote,
                  hintStyle: TextStyles.bodyMedium.copyWith(
                    color: ColorManager.textMuted,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Actions: Save Note & Optional Delete Note
            Row(
              children: [
                if (_hasExistingNote) ...[
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: ColorManager.error),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      onPressed: _deleteNote,
                      child: CustomText(
                        text: s.deleteNote,
                        style: TextStyles.bodyMedium.copyWith(
                          color: ColorManager.error,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                ],
                Expanded(
                  flex: 2,
                  child: ElevatedButtonWidget(
                    title: s.saveNote,
                    onPressed: _saveNote,
                    backgroundColor: ColorManager.primary,
                    foregroundColor: ColorManager.textOnPrimary,
                    borderRadius: 4.r,
                    textStyle: TextStyles.bodyMedium.copyWith(
                      color: ColorManager.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
