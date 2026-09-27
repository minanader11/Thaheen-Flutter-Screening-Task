import 'package:flutter/material.dart';
import '../../features/splash/view/screen/splash_screen.dart';
import '../../features/courses/view/screen/courses_screen.dart';
import '../../features/course_details/view/screen/course_details_screen.dart';
import '../../features/lesson_player/view/screen/lesson_player_screen.dart';
import 'lesson_player_args.dart';
import 'routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.courses:
        return MaterialPageRoute(builder: (_) => const CoursesScreen());

      case Routes.courseDetails:
        final courseId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CourseDetailsScreen(courseId: courseId),
        );

      case Routes.lessonPlayer:
        final args = settings.arguments as LessonPlayerArgs;
        return MaterialPageRoute(
          builder: (_) => LessonPlayerScreen(
            courseId: args.courseId,
            lessonId: args.lessonId,
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
