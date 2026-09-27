import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/network/get_state.dart';
import '../../../../core/settings/model/app_settings_model.dart';
import '../../../../core/settings/view_model/settings_cubit.dart';
import '../../../../core/settings/view_model/settings_state.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/base_scaffold/base_scaffold.dart';
import '../../../../core/widgets/other/custom_error_widget.dart';
import '../../../../core/widgets/other/custom_text.dart';
import '../../../../core/widgets/other/no_data_widget.dart';
import '../../view_model/courses_cubit.dart';
import '../../view_model/courses_state.dart';
import '../widgets/continue_watching_card.dart';
import '../widgets/course_list_item.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CoursesCubit>()..getCourses(),
      child: const CoursesView(),
    );
  }
}

class CoursesView extends StatelessWidget {
  const CoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    // S.of(context) is context-aware — rebuilds when locale changes.
    final s = S.of(context);

    return BaseScaffold(
      // No hardcoded backgroundColor — BaseScaffold inherits
      // ThemeData.scaffoldBackgroundColor which is set per theme in MyApp.
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        title: CustomText(
          text: s.courses,
          style: TextStyles.titleLarge,
        ),
        actions: [
          // ── Language toggle ──────────────────────────────────
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, settingsState) {
              final isArabic =
                  settingsState.settings.language == AppLanguage.ar;
              return Tooltip(
                message: isArabic ? 'Switch to English' : 'التبديل للعربية',
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    context.read<SettingsCubit>().changeLanguage(
                          isArabic ? AppLanguage.en : AppLanguage.ar,
                        );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: ColorManager.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: ColorManager.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: CustomText(
                      text: isArabic ? 'EN' : 'ع',
                      style: TextStyles.labelLarge.copyWith(
                        color: ColorManager.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // ── Theme toggle ─────────────────────────────────────
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, settingsState) {
              final isDark =
                  settingsState.settings.themeMode == AppThemeMode.dark;
              return Tooltip(
                message: isDark ? 'Light mode' : 'Dark mode',
                child: IconButton(
                  icon: Icon(
                    isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                    color: ColorManager.primary,
                  ),
                  onPressed: () {
                    context.read<SettingsCubit>().changeTheme(
                          isDark ? AppThemeMode.light : AppThemeMode.dark,
                        );
                  },
                ),
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: BlocBuilder<CoursesCubit, CoursesState>(
        builder: (context, state) {
          switch (state.coursesState) {
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
                        : s.errorLoadingCourses,
                    onRetry: () => context.read<CoursesCubit>().getCourses(),
                  ),
                ),
              );

            case GetState.success:
              if (state.courses.isEmpty) {
                return Center(
                  child: NoDataWidget(title: s.courses),
                );
              }

              final continueWatchingCourse = state.continueWatchingCourse;
              final continueWatchingLesson = state.continueWatchingLesson;
              final hasContinueWatching =
                  continueWatchingCourse != null && continueWatchingLesson != null;

              return RefreshIndicator(
                color: ColorManager.primary,
                onRefresh: () => context.read<CoursesCubit>().getCourses(),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemCount: state.courses.length +
                      (hasContinueWatching ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (hasContinueWatching) {
                      if (index == 0) {
                        return ContinueWatchingCard(
                          course: continueWatchingCourse,
                          lesson: continueWatchingLesson,
                        );
                      }
                      final course = state.courses[index - 1];
                      return CourseListItem(course: course);
                    }

                    final course = state.courses[index];
                    return CourseListItem(course: course);
                  },
                ),
              );
          }
        },
      ),
    );
  }
}
