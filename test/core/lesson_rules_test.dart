import 'package:flutter_test/flutter_test.dart';
import 'package:Thaheen/core/rules/lesson_rules.dart';
import 'package:Thaheen/features/courses/model/course_model.dart';
import 'package:Thaheen/features/courses/model/lesson_model.dart';
import 'package:Thaheen/features/courses/model/lesson_progress_model.dart';
import 'package:Thaheen/features/courses/model/section_model.dart';

void main() {
  group('1. isLessonComplete', () {
    test('returns true at exactly 90%', () {
      expect(isLessonComplete(90, 100), isTrue);
      expect(isLessonComplete(108, 120), isTrue);
    });

    test('returns false at 89%', () {
      expect(isLessonComplete(89, 100), isFalse);
      expect(isLessonComplete(899, 1000), isFalse);
    });

    test('returns true above 90%', () {
      expect(isLessonComplete(91, 100), isTrue);
      expect(isLessonComplete(100, 100), isTrue);
    });

    test('returns false when durationSec == 0', () {
      expect(isLessonComplete(0, 0), isFalse);
      expect(isLessonComplete(50, 0), isFalse);
    });
  });

  group('2. isLessonUnlocked', () {
    const lesson1NotStarted = LessonModel(
      id: 'l1',
      title: 'Lesson 1',
      durationSec: 100,
      video: 'v1.mp4',
      progress: LessonProgressModel(status: 'notStarted', positionSec: 0),
    );

    const lesson1Completed = LessonModel(
      id: 'l1',
      title: 'Lesson 1',
      durationSec: 100,
      video: 'v1.mp4',
      progress: LessonProgressModel(status: 'completed', positionSec: 100),
    );

    const lesson2NotStarted = LessonModel(
      id: 'l2',
      title: 'Lesson 2',
      durationSec: 100,
      video: 'v2.mp4',
      progress: LessonProgressModel(status: 'notStarted', positionSec: 0),
    );

    const lesson2Completed = LessonModel(
      id: 'l2',
      title: 'Lesson 2',
      durationSec: 100,
      video: 'v2.mp4',
      progress: LessonProgressModel(status: 'completed', positionSec: 100),
    );

    const lesson3NotStarted = LessonModel(
      id: 'l3',
      title: 'Lesson 3',
      durationSec: 100,
      video: 'v3.mp4',
      progress: LessonProgressModel(status: 'notStarted', positionSec: 0),
    );

    test('index 0 is always true regardless of progress', () {
      expect(isLessonUnlocked([lesson1NotStarted, lesson2NotStarted], 0), isTrue);
      expect(isLessonUnlocked([lesson1Completed, lesson2NotStarted], 0), isTrue);
    });

    test('index > 0 is true only when previous lesson isCompleted is true', () {
      final lessonsWithFirstComplete = [lesson1Completed, lesson2NotStarted, lesson3NotStarted];
      expect(isLessonUnlocked(lessonsWithFirstComplete, 1), isTrue);
      expect(isLessonUnlocked(lessonsWithFirstComplete, 2), isFalse);

      final lessonsWithBothComplete = [lesson1Completed, lesson2Completed, lesson3NotStarted];
      expect(isLessonUnlocked(lessonsWithBothComplete, 2), isTrue);
    });

    test('index > 0 is false when previous lesson is not completed', () {
      final lessons = [lesson1NotStarted, lesson2NotStarted];
      expect(isLessonUnlocked(lessons, 1), isFalse);
    });
  });

  group('3. CourseModel.progressPercent', () {
    test('0 lessons -> 0.0', () {
      const course = CourseModel(
        id: 'c0',
        title: 'Empty Course',
        instructor: 'Dr. Test',
        thumbnail: 'thumb.png',
        sections: [],
      );

      expect(course.totalLessons, 0);
      expect(course.completedLessons, 0);
      expect(course.progressPercent, 0.0);
    });

    test('all completed -> 1.0', () {
      const course = CourseModel(
        id: 'c1',
        title: 'Complete Course',
        instructor: 'Dr. Test',
        thumbnail: 'thumb.png',
        sections: [
          SectionModel(
            id: 's1',
            title: 'Section 1',
            lessons: [
              LessonModel(
                id: 'l1',
                title: 'L1',
                durationSec: 100,
                video: 'v1.mp4',
                progress: LessonProgressModel(status: 'completed', positionSec: 100),
              ),
              LessonModel(
                id: 'l2',
                title: 'L2',
                durationSec: 100,
                video: 'v2.mp4',
                progress: LessonProgressModel(status: 'completed', positionSec: 100),
              ),
            ],
          ),
        ],
      );

      expect(course.totalLessons, 2);
      expect(course.completedLessons, 2);
      expect(course.progressPercent, 1.0);
    });

    test('partial -> exact fraction (1 of 3 completed -> 1/3)', () {
      const course = CourseModel(
        id: 'c2',
        title: 'Partial Course',
        instructor: 'Dr. Test',
        thumbnail: 'thumb.png',
        sections: [
          SectionModel(
            id: 's1',
            title: 'Section 1',
            lessons: [
              LessonModel(
                id: 'l1',
                title: 'L1',
                durationSec: 100,
                video: 'v1.mp4',
                progress: LessonProgressModel(status: 'completed', positionSec: 100),
              ),
              LessonModel(
                id: 'l2',
                title: 'L2',
                durationSec: 100,
                video: 'v2.mp4',
                progress: LessonProgressModel(status: 'inProgress', positionSec: 50),
              ),
              LessonModel(
                id: 'l3',
                title: 'L3',
                durationSec: 100,
                video: 'v3.mp4',
                progress: LessonProgressModel(status: 'notStarted', positionSec: 0),
              ),
            ],
          ),
        ],
      );

      expect(course.totalLessons, 3);
      expect(course.completedLessons, 1);
      expect(course.progressPercent, closeTo(1 / 3, 0.0001));
      expect(course.continueWatchingLesson?.id, 'l2');
    });
  });
}
