import 'package:intl/intl.dart';
import 'generated/l10n.dart';

extension LmsLocalization on S {
  String get courses => Intl.message('Courses', name: 'courses', desc: '');
  String get lessons => Intl.message('Lessons', name: 'lessons', desc: '');
  String get continueWatching =>
      Intl.message('Continue Watching', name: 'continueWatching', desc: '');
  String get errorLoadingCourses =>
      Intl.message('Error loading courses', name: 'errorLoadingCourses', desc: '');
  String get errorLoadingLesson =>
      Intl.message('Error loading lesson', name: 'errorLoadingLesson', desc: '');
  String get lessonLocked => Intl.message('Please complete previous lessons first',
      name: 'lessonLocked', desc: '');
  String get videoLoadError =>
      Intl.message('Error loading video', name: 'videoLoadError', desc: '');
  String get retry => Intl.message('Retry', name: 'retry', desc: '');
  String get nextLesson => Intl.message('Next lesson', name: 'nextLesson', desc: '');
  String get progress => Intl.message('Progress', name: 'progress', desc: '');
  String get statusInProgress => inProgress;
}
