import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/network/get_state.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/base_scaffold/base_scaffold.dart';
import '../../../../core/widgets/other/custom_error_widget.dart';
import '../../../../core/widgets/other/custom_text.dart';
import '../../../../core/widgets/other/no_data_widget.dart';
import '../../view_model/course_details_cubit.dart';
import '../../view_model/course_details_state.dart';
import '../widgets/course_header_card.dart';
import '../widgets/section_tile.dart';

class CourseDetailsScreen extends StatelessWidget {
  final String courseId;

  const CourseDetailsScreen({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CourseDetailsCubit>(param1: courseId)
        ..getCourseDetails(courseId),
      child: CourseDetailsView(courseId: courseId),
    );
  }
}

class CourseDetailsView extends StatelessWidget {
  final String? courseId;

  const CourseDetailsView({
    super.key,
    this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
      builder: (context, state) {
        return BaseScaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 0,
            leading: BackButton(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: state.course != null
                ? CustomText(
                    text: state.course!.title,
                    style: TextStyles.titleLarge,
                  )
                : null,
          ),
          body: _buildBody(context, state, s),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, CourseDetailsState state, S s) {
    switch (state.courseState) {
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
                  : s.errorLoadingLesson,
              onRetry: () => context.read<CourseDetailsCubit>().retry(),
            ),
          ),
        );

      case GetState.success:
        final course = state.course;
        if (course == null || course.sections.isEmpty) {
          return Center(
            child: NoDataWidget(
              title: s.lessons,
            ),
          );
        }

        final effectiveCourseId = courseId ?? course.id;

        return RefreshIndicator(
          color: ColorManager.primary,
          onRefresh: () => context.read<CourseDetailsCubit>().refresh(),
          child: ListView(
            padding: EdgeInsets.only(bottom: 24.h),
            children: [
              CourseHeaderCard(course: course),
              ...course.sections.map(
                (section) => SectionTile(
                  courseId: effectiveCourseId,
                  section: section,
                  course: course,
                ),
              ),
            ],
          ),
        );
    }
  }
}
