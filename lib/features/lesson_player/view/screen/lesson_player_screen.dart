import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/network/get_state.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/other/custom_error_widget.dart';
import '../../../../core/widgets/other/custom_text.dart';
import '../../view_model/lesson_player_cubit.dart';
import '../../view_model/lesson_player_state.dart';
import '../widgets/player_controls.dart';

class LessonPlayerScreen extends StatelessWidget {
  final String courseId;
  final String lessonId;

  const LessonPlayerScreen({
    super.key,
    required this.courseId,
    required this.lessonId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LessonPlayerCubit>(
        param1: courseId,
        param2: lessonId,
      )..initLesson(courseId, lessonId),
      child: LessonPlayerView(
        courseId: courseId,
        lessonId: lessonId,
      ),
    );
  }
}

class LessonPlayerView extends StatefulWidget {
  final String? courseId;
  final String? lessonId;

  const LessonPlayerView({
    super.key,
    this.courseId,
    this.lessonId,
  });

  @override
  State<LessonPlayerView> createState() => _LessonPlayerViewState();
}

class _LessonPlayerViewState extends State<LessonPlayerView> {
  bool _showControls = true;
  Timer? _hideTimer;

  @override
  void dispose() {
    _hideTimer?.cancel();
    _revertOrientationAndSystemUI();
    super.dispose();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) {
        final cubit = context.read<LessonPlayerCubit>();
        if (cubit.state.isPlaying) {
          setState(() {
            _showControls = false;
          });
        }
      }
    });
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) {
      _startHideTimer();
    } else {
      _hideTimer?.cancel();
    }
  }

  void _setFullscreenOrientationAndSystemUI() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void _revertOrientationAndSystemUI() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LessonPlayerCubit, LessonPlayerState>(
      listenWhen: (previous, current) =>
          previous.isFullscreen != current.isFullscreen,
      listener: (context, state) {
        if (state.isFullscreen) {
          _setFullscreenOrientationAndSystemUI();
        } else {
          _revertOrientationAndSystemUI();
        }
      },
      child: BlocBuilder<LessonPlayerCubit, LessonPlayerState>(
        builder: (context, state) {
          final cubit = context.read<LessonPlayerCubit>();
          final currentLesson = state.currentLesson;

          return PopScope(
            canPop: !state.isFullscreen,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;
              if (state.isFullscreen) {
                cubit.toggleFullscreen();
              }
            },
            child: Scaffold(
              backgroundColor: state.lessonState == GetState.success
                  ? Colors.black
                  : ColorManager.background,
              appBar: state.isFullscreen || state.lessonState == GetState.success
                  ? null
                  : AppBar(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      elevation: 0,
                      leading: BackButton(
                          color: Theme.of(context).colorScheme.onSurface),
                      title: currentLesson != null
                          ? CustomText(
                              text: currentLesson.title,
                              style: TextStyles.titleLarge,
                            )
                          : null,
                    ),
              body: _buildBody(context, state, cubit),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    LessonPlayerState state,
    LessonPlayerCubit cubit,
  ) {
    final s = S.of(context);
    switch (state.lessonState) {
      case GetState.loading:
      case GetState.initial:
        return const Center(
          child: CircularProgressIndicator(
            color: ColorManager.primary,
          ),
        );

      case GetState.failure:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomErrorWidget(
              text: state.errorMessage.isNotEmpty
                  ? state.errorMessage
                  : s.videoLoadError,
              onRetry: () => cubit.retry(),
            ),
          ),
        );

      case GetState.success:
        final controller = cubit.controller;
        final currentLesson = state.currentLesson;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _toggleControls,
          child: Stack(
            children: [
              // Video Player Area
              Center(
                child: controller != null && controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller),
                      )
                    : const CircularProgressIndicator(
                        color: ColorManager.primary,
                      ),
              ),

              // Animated Top Overlay (Back button + Lesson Title)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                top: _showControls ? 0 : -80.h,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(12.w, 40.h, 16.w, 16.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.85),
                        Colors.black.withValues(alpha: 0.40),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Material(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            if (state.isFullscreen) {
                              cubit.toggleFullscreen();
                            } else {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.r),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 18.r,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (currentLesson != null)
                              CustomText(
                                text: currentLesson.title,
                                style: TextStyles.titleMedium.copyWith(
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            if (state.course != null)
                              CustomText(
                                text: state.course!.title,
                                style: TextStyles.labelMedium.copyWith(
                                  color: Colors.white70,
                                ),
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Animated Bottom Controls Overlay
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                bottom: _showControls ? 0 : -220.h,
                left: 0,
                right: 0,
                child: SafeArea(
                  top: false,
                  child: PlayerControls(
                    cubit: cubit,
                    state: state,
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }
}
