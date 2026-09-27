import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Thaheen/core/cache/cache_helper.dart';
import 'package:Thaheen/core/cache/cache_keys.dart';
import 'package:Thaheen/core/services/lesson_notes_service.dart';
import 'package:Thaheen/core/services/progress_local_service.dart';
import 'package:Thaheen/features/courses/model/lesson_progress_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await CacheHelper.init();
  });

  group('CacheHelper', () {
    test('saveData and getData with String', () async {
      final saved = await CacheHelper.saveData(
        key: CacheKeys.appSettings,
        value: '{"language":"ar"}',
      );
      expect(saved, isTrue);

      final retrieved = CacheHelper.getData<String>(key: CacheKeys.appSettings);
      expect(retrieved, '{"language":"ar"}');
    });

    test('saveData and getData with int', () async {
      await CacheHelper.saveData(key: 'user_id', value: 12345);
      final retrieved = CacheHelper.getData<int>(key: 'user_id');
      expect(retrieved, 12345);
    });

    test('saveData and getData with bool', () async {
      await CacheHelper.saveData(key: 'is_logged_in', value: true);
      final retrieved = CacheHelper.getData<bool>(key: 'is_logged_in');
      expect(retrieved, isTrue);
    });

    test('saveData and getData with double', () async {
      await CacheHelper.saveData(key: 'speed', value: 1.5);
      final retrieved = CacheHelper.getData<double>(key: 'speed');
      expect(retrieved, 1.5);
    });

    test('saveData and getData with List<String>', () async {
      await CacheHelper.saveData(key: 'tags', value: ['tag1', 'tag2']);
      final retrieved = CacheHelper.getData<List<String>>(key: 'tags');
      expect(retrieved, ['tag1', 'tag2']);
    });

    test('saveData throws ArgumentError on unsupported types', () async {
      expect(
        () => CacheHelper.saveData(key: 'invalid', value: {'key': 'value'}),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('getData returns null when key does not exist or type mismatch', () {
      expect(CacheHelper.getData<String>(key: 'non_existent'), isNull);
    });

    test('containsKey correctly verifies presence of key', () async {
      expect(CacheHelper.containsKey(key: 'test_key'), isFalse);
      await CacheHelper.saveData(key: 'test_key', value: 'present');
      expect(CacheHelper.containsKey(key: 'test_key'), isTrue);
    });

    test('removeData removes entry from cache', () async {
      await CacheHelper.saveData(key: 'to_remove', value: 'temporary');
      expect(CacheHelper.getData<String>(key: 'to_remove'), 'temporary');

      await CacheHelper.removeData(key: 'to_remove');
      expect(CacheHelper.getData<String>(key: 'to_remove'), isNull);
    });

    test('clearAll removes all entries from cache', () async {
      await CacheHelper.saveData(key: 'k1', value: 'v1');
      await CacheHelper.saveData(key: 'k2', value: 'v2');

      await CacheHelper.clearAll();

      expect(CacheHelper.getData<String>(key: 'k1'), isNull);
      expect(CacheHelper.getData<String>(key: 'k2'), isNull);
    });
  });

  group('CacheKeys', () {
    test('constants and helper methods generate expected keys', () {
      expect(CacheKeys.appSettings, 'app_settings_json');
      expect(CacheKeys.lessonProgressPrefix, 'lesson_progress_');
      expect(CacheKeys.lessonProgress('l1'), 'lesson_progress_l1');
      expect(
        CacheKeys.lessonProgress('l1', 'anatomy-101'),
        'lesson_progress_anatomy-101_l1',
      );
    });
  });

  group('ProgressLocalService', () {
    test('course-scoped progress isolates same lesson id between courses', () async {
      final service = ProgressLocalService();
      await service.saveProgress(
        'l1',
        const LessonProgressModel(status: 'completed', positionSec: 148),
        'anatomy-101',
      );

      final anatomyProgress = service.getProgress('l1', 'anatomy-101');
      final physiologyProgress = service.getProgress('l1', 'physiology-101');

      expect(anatomyProgress?.status, 'completed');
      expect(physiologyProgress, isNull);
    });

    test('setLastWatched, getLastWatched, and clearLastWatched work as expected', () async {
      final service = ProgressLocalService();
      await service.setLastWatched(courseId: 'c1', lessonId: 'l1');

      final lastWatched = service.getLastWatched();
      expect(lastWatched, isNotNull);
      expect(lastWatched?['courseId'], 'c1');
      expect(lastWatched?['lessonId'], 'l1');
      expect(lastWatched?['updatedAt'], isNotNull);

      await service.clearLastWatched();
      expect(service.getLastWatched(), isNull);
    });
  });

  group('LessonNotesService', () {
    test('saveNote and getNote persist and retrieve lesson note offline', () async {
      final service = LessonNotesService();
      await service.saveNote(
        courseId: 'anatomy-101',
        lessonId: 'l1',
        note: 'Important note about bone structure',
      );

      final note = service.getNote(courseId: 'anatomy-101', lessonId: 'l1');
      expect(note, 'Important note about bone structure');
    });

    test('deleteNote removes saved note', () async {
      final service = LessonNotesService();
      await service.saveNote(
        courseId: 'anatomy-101',
        lessonId: 'l2',
        note: 'Joint classification notes',
      );

      expect(service.getNote(courseId: 'anatomy-101', lessonId: 'l2'), isNotNull);

      await service.deleteNote(courseId: 'anatomy-101', lessonId: 'l2');
      expect(service.getNote(courseId: 'anatomy-101', lessonId: 'l2'), isNull);
    });

    test('saving empty note removes note entry', () async {
      final service = LessonNotesService();
      await service.saveNote(
        courseId: 'anatomy-101',
        lessonId: 'l3',
        note: 'Muscles note',
      );

      await service.saveNote(
        courseId: 'anatomy-101',
        lessonId: 'l3',
        note: '   ',
      );

      expect(service.getNote(courseId: 'anatomy-101', lessonId: 'l3'), isNull);
    });
  });
}
