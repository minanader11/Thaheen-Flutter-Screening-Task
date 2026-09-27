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

class CoursesView extends StatefulWidget {
  const CoursesView({super.key});

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
              final filteredCourses = state.filteredCourses;
              final continueWatchingCourse = state.continueWatchingCourse;
              final continueWatchingLesson = state.continueWatchingLesson;
              final hasContinueWatching =
                  continueWatchingCourse != null && continueWatchingLesson != null;

              return RefreshIndicator(
                color: ColorManager.primary,
                onRefresh: () => context.read<CoursesCubit>().getCourses(),
                child: Column(
                  children: [
                    // ── Search Bar ──────────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: ColorManager.cardBorder,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (query) {
                            context.read<CoursesCubit>().searchCourses(query);
                          },
                          style: TextStyles.bodyMedium.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          decoration: InputDecoration(
                            hintText: s.searchCourses,
                            hintStyle: TextStyles.bodyMedium.copyWith(
                              color: ColorManager.textMuted,
                            ),
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              color: ColorManager.primary,
                              size: 22,
                            ),
                            suffixIcon: state.searchQuery.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.close_rounded,
                                      color: ColorManager.textMuted,
                                      size: 18,
                                    ),
                                    onPressed: () {
                                      _searchController.clear();
                                      context.read<CoursesCubit>().clearSearch();
                                    },
                                  )
                                : null,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ── Courses List or Empty Search Results ────────────────
                    Expanded(
                      child: filteredCourses.isEmpty
                          ? Center(
                              child: NoDataWidget(
                                title: state.searchQuery.isNotEmpty
                                    ? s.noCoursesFound
                                    : s.courses,
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.only(bottom: 16),
                              itemCount: filteredCourses.length +
                                  (hasContinueWatching ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (hasContinueWatching) {
                                  if (index == 0) {
                                    return ContinueWatchingCard(
                                      course: continueWatchingCourse,
                                      lesson: continueWatchingLesson,
                                    );
                                  }
                                  final course = filteredCourses[index - 1];
                                  return CourseListItem(course: course);
                                }

                                final course = filteredCourses[index];
                                return CourseListItem(course: course);
                              },
                            ),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
