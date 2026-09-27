import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:LJF_admin/core/localization/generated/l10n.dart';
import 'package:LJF_admin/core/settings/model/app_settings_model.dart';

void main() {
  group('LMS Localization Tests', () {
    test('Default AppSettingsModel language is Arabic (ar)', () {
      const settings = AppSettingsModel();
      expect(settings.language, AppLanguage.ar);
    });

    test('Loads Arabic translations correctly', () async {
      final s = await S.load(const Locale('ar'));

      expect(S.current, equals(s));
      expect(s.courses, 'الدورات');
      expect(s.coursesTitle, 'الدورات التعليمية');
      expect(s.noCourses, 'لا توجد دورات متاحة');
      expect(s.coursesLoading, 'جاري تحميل الدورات...');
      expect(s.continueWatching, 'متابعة المشاهدة');
      expect(s.errorLoadingCourses, 'حدث خطأ أثناء تحميل الدورات');
      expect(s.lessons, 'دروس');
      expect(s.retry, 'إعادة المحاولة');

      expect(s.courseDetails, 'تفاصيل الدورة');
      expect(s.errorLoadingCourse, 'حدث خطأ أثناء تحميل تفاصيل الدورة');
      expect(s.errorLoadingLesson, 'حدث خطأ أثناء تحميل الدرس');
      expect(s.noLessons, 'لا توجد دروس متاحة');
      expect(s.progress, 'التقدم');
      expect(s.completed, 'مكتمل');
      expect(s.inProgress, 'قيد المشاهدة');
      expect(s.statusInProgress, 'قيد المشاهدة');
      expect(s.notStarted, 'لم يبدأ');
      expect(s.lessonLocked, 'يرجى إكمال الدروس السابقة أولاً');

      expect(s.videoLoadError, 'حدث خطأ أثناء تحميل الفيديو');
      expect(s.nextLesson, 'الدرس التالي');
      expect(s.previousLesson, 'الدرس السابق');
      expect(s.playbackSpeed, 'سرعة التشغيل');
      expect(s.normalSpeed, 'عادي');
      expect(s.speed, 'السرعة');
      expect(s.play, 'تشغيل');
      expect(s.pause, 'إيقاف مؤقت');
      expect(s.replay, 'إعادة التشغيل');
      expect(s.fullscreen, 'ملء الشاشة');
      expect(s.exitFullscreen, 'الخروج من ملء الشاشة');

      expect(s.settings, 'الإعدادات');
      expect(s.arabic, 'العربية');
      expect(s.english, 'الإنجليزية');
      expect(s.theme, 'المظهر');
      expect(s.lightMode, 'الوضع النهاري');
      expect(s.darkMode, 'الوضع الليلي');
    });

    test('Loads English translations correctly', () async {
      final s = await S.load(const Locale('en'));

      expect(S.current, equals(s));
      expect(s.courses, 'Courses');
      expect(s.coursesTitle, 'Courses');
      expect(s.noCourses, 'No courses available');
      expect(s.coursesLoading, 'Loading courses...');
      expect(s.continueWatching, 'Continue Watching');
      expect(s.errorLoadingCourses, 'Error loading courses');
      expect(s.lessons, 'Lessons');
      expect(s.retry, 'Retry');

      expect(s.courseDetails, 'Course Details');
      expect(s.errorLoadingCourse, 'Error loading course details');
      expect(s.errorLoadingLesson, 'Error loading lesson');
      expect(s.noLessons, 'No lessons available');
      expect(s.progress, 'Progress');
      expect(s.completed, 'Completed');
      expect(s.inProgress, 'In Progress');
      expect(s.statusInProgress, 'In Progress');
      expect(s.notStarted, 'Not Started');
      expect(s.lessonLocked, 'Please complete previous lessons first');

      expect(s.videoLoadError, 'Error loading video');
      expect(s.nextLesson, 'Next lesson');
      expect(s.previousLesson, 'Previous lesson');
      expect(s.playbackSpeed, 'Playback Speed');
      expect(s.normalSpeed, 'Normal');
      expect(s.speed, 'Speed');
      expect(s.play, 'Play');
      expect(s.pause, 'Pause');
      expect(s.replay, 'Replay');
      expect(s.fullscreen, 'Fullscreen');
      expect(s.exitFullscreen, 'Exit Fullscreen');

      expect(s.settings, 'Settings');
      expect(s.arabic, 'Arabic');
      expect(s.english, 'English');
      expect(s.theme, 'Theme');
      expect(s.lightMode, 'Light Mode');
      expect(s.darkMode, 'Dark Mode');
    });

    testWidgets('MaterialApp directionality is RTL for Arabic and LTR for English', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('ar'),
          supportedLocales: const [Locale('ar'), Locale('en')],
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: Builder(
            builder: (context) {
              final directionality = Directionality.of(context);
              return Text(
                'Direction: $directionality',
                textDirection: directionality,
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Direction: TextDirection.rtl'), findsOneWidget);

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          supportedLocales: const [Locale('ar'), Locale('en')],
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: Builder(
            builder: (context) {
              final directionality = Directionality.of(context);
              return Text(
                'Direction: $directionality',
                textDirection: directionality,
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Direction: TextDirection.ltr'), findsOneWidget);
    });
  });
}
