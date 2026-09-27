import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/buttons/elevated_button.dart';
import '../../../../core/widgets/other/custom_text.dart';
import '../../view_model/lesson_player_cubit.dart';
import '../../view_model/lesson_player_state.dart';
import 'lesson_notes_sheet.dart';
import 'speed_selector_sheet.dart';

class PlayerControls extends StatefulWidget {
  final LessonPlayerCubit cubit;
  final LessonPlayerState state;

  const PlayerControls({
    super.key,
    required this.cubit,
    required this.state,
  });

  @override
  State<PlayerControls> createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  bool _isDragging = false;
  double? _dragValue;

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final cubit = widget.cubit;
    final s = S.of(context);

    final double maxSec = state.duration.inSeconds.toDouble();
    final double currentSec = _isDragging && _dragValue != null
        ? _dragValue!.clamp(0.0, maxSec > 0 ? maxSec : 1.0)
        : state.position.inSeconds
            .toDouble()
            .clamp(0.0, maxSec > 0 ? maxSec : 1.0);

    final Duration displayPosition = _isDragging && _dragValue != null
        ? Duration(seconds: _dragValue!.toInt())
        : state.position;

    final canNext = cubit.canGoToNextLesson();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withValues(alpha: 0.92),
            Colors.black.withValues(alpha: 0.70),
            Colors.transparent,
          ],
          stops: const [0.0, 0.65, 1.0],
        ),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Middle quick-action controls: 10s Rewind | Play/Pause | 10s Forward
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Rewind 10 seconds
              Material(
                color: Colors.white.withValues(alpha: 0.15),
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => cubit.seekBackward(10),
                  child: Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Icon(
                      Icons.replay_10_rounded,
                      color: Colors.white,
                      size: 24.r,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 24.w),

              // Play / Pause prominent circular button
              GestureDetector(
                onTap: cubit.togglePlayPause,
                child: Container(
                  width: 52.r,
                  height: 52.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        ColorManager.primaryGradientStart,
                        ColorManager.primaryGradientEnd,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.primary.withValues(alpha: 0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    state.isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 32.r,
                  ),
                ),
              ),

              SizedBox(width: 24.w),

              // Forward 10 seconds
              Material(
                color: Colors.white.withValues(alpha: 0.15),
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => cubit.seekForward(10),
                  child: Padding(
                    padding: EdgeInsets.all(8.r),
                    child: Icon(
                      Icons.forward_10_rounded,
                      color: Colors.white,
                      size: 24.r,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // Seek bar with forced LTR directionality
          Directionality(
            textDirection: TextDirection.ltr,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: ColorManager.primary,
                inactiveTrackColor: Colors.white24,
                thumbColor: ColorManager.primary,
                trackHeight: 4.h,
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: _isDragging ? 8.r : 6.r,
                ),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 16.r),
                overlayColor: ColorManager.primary.withValues(alpha: 0.2),
              ),
              child: Slider(
                value: maxSec > 0 ? currentSec : 0.0,
                max: maxSec > 0 ? maxSec : 1.0,
                onChangeStart: (val) {
                  setState(() {
                    _isDragging = true;
                    _dragValue = val;
                  });
                },
                onChanged: (val) {
                  setState(() {
                    _dragValue = val;
                  });
                },
                onChangeEnd: (val) {
                  cubit.seekTo(Duration(seconds: val.toInt()));
                  setState(() {
                    _isDragging = false;
                    _dragValue = null;
                  });
                },
              ),
            ),
          ),

          // Duration labels and bottom action row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Elapsed / Total Duration (Directionality LTR to keep numbers order clean)
              Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: CustomText(
                    text:
                        '${_formatDuration(displayPosition)} / ${_formatDuration(state.duration)}',
                    style: TextStyles.labelMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              Row(
                children: [
                  // Modern Speed selector chip
                  Material(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8.r),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8.r),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (_) => SpeedSelectorSheet(
                            currentSpeed: state.playbackSpeed,
                            onSpeedSelected: cubit.changeSpeed,
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 6.h),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.speed_rounded,
                              color: Colors.white70,
                              size: 16.r,
                            ),
                            SizedBox(width: 4.w),
                            CustomText(
                              text: '${state.playbackSpeed}x',
                              style: TextStyles.labelMedium.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 8.w),

                  // Per-lesson Notes button
                  Material(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8.r),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8.r),
                      onTap: () {
                        final lesson = state.currentLesson;
                        if (lesson != null && state.course != null) {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (_) => LessonNotesSheet(
                              courseId: state.course!.id,
                              lessonId: lesson.id,
                              lessonTitle: lesson.title,
                            ),
                          );
                        }
                      },
                      child: Tooltip(
                        message: s.lessonNotes,
                        child: Padding(
                          padding: EdgeInsets.all(7.r),
                          child: Icon(
                            Icons.note_alt_outlined,
                            color: Colors.white,
                            size: 18.r,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 8.w),

                  // Fullscreen toggle
                  Material(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8.r),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8.r),
                      onTap: cubit.toggleFullscreen,
                      child: Padding(
                        padding: EdgeInsets.all(6.r),
                        child: Icon(
                          state.isFullscreen
                              ? Icons.fullscreen_exit_rounded
                              : Icons.fullscreen_rounded,
                          color: Colors.white,
                          size: 22.r,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Next Lesson Button
          ElevatedButtonWidget(
            title: s.nextLesson,
            onPressed: canNext ? cubit.goToNextLesson : null,
            backgroundColor:
                canNext ? ColorManager.primary : ColorManager.statusLocked,
            foregroundColor: ColorManager.textOnPrimary,
            borderRadius: 8.r,
            textStyle:
                TextStyles.bodyMedium.copyWith(color: ColorManager.white),
          ),
        ],
      ),
    );
  }
}
