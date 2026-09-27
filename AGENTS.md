# Thaheen Mini LMS — Instructions for Antigravity IDE

Paste this whole file (or the relevant sections) into Antigravity as your build spec. It follows Feature-First + Clean Architecture, Cubit-only state management, and reuses your existing shared widgets (`CustomText`, `ImageHelper`, `CustomErrorWidget`, `NoDataWidget`, `TextStyles`, `ColorManager`).

---

## 1. Folder structure

```
lib/
  core/
    network/
      api_result.dart          // generic Result wrapper, used even for local "calls"
    styles/
      colors.dart               // ColorManager — Thaheen palette
    cache/
      cache_helper.dart          // SharedPreferences wrapper (save/get/remove/clear)
      cache_keys.dart            // key constants, incl. settings key
    settings/
      model/
        app_settings_model.dart
      repo/
        settings_repo.dart
        settings_repo_impl.dart
      view_model/
        settings_cubit.dart
        settings_state.dart
    constants/
      asset_paths.dart          // like EndPoints, but for bundled asset paths
  features/
    courses/
      model/
        course_model.dart
        section_model.dart
        lesson_model.dart
        lesson_progress_model.dart
      repo/
        courses_repo.dart
        courses_repo_impl.dart
      view_model/
        courses_cubit.dart
        courses_state.dart
      view/
        screen/
          courses_screen.dart
        widgets/
          continue_watching_card.dart
          course_list_item.dart
    course_details/
      view_model/
        course_details_cubit.dart
        course_details_state.dart
      view/
        screen/
          course_details_screen.dart
        widgets/
          section_tile.dart
          lesson_tile.dart
    lesson_player/
      view_model/
        lesson_player_cubit.dart
        lesson_player_state.dart
      view/
        screen/
          lesson_player_screen.dart
        widgets/
          player_controls.dart
          speed_selector_sheet.dart
```

**Rule for Antigravity:** one Cubit + one State per screen (`CoursesCubit`, `CourseDetailsCubit`, `LessonPlayerCubit`). `SettingsCubit` is the one cross-cutting exception since it's global app state, not a screen.

---

## 2. `assets/data/courses.json`

Progress fields live **inside the course/lesson JSON itself** as default placeholders, rather than a separate progress file. The asset stays static; at runtime the repo overwrites these defaults with whatever is in local storage, so the model the UI reads always has progress attached to it — same shape, whether it just came from the bundle or was merged with saved progress.

```json
{
  "courses": [
    {
      "id": "anatomy-101",
      "title": "مقدمة في التشريح",
      "instructor": "د. سارة",
      "thumbnail": "assets/images/anatomy.png",
      "sections": [
        {
          "id": "s1",
          "title": "الجهاز الهيكلي",
          "lessons": [
            {
              "id": "l1",
              "title": "العظام",
              "durationSec": 95,
              "video": "assets/videos/lesson1.mp4",
              "progress": { "status": "notStarted", "positionSec": 0 }
            },
            {
              "id": "l2",
              "title": "المفاصل",
              "durationSec": 120,
              "video": "assets/videos/lesson2.mp4",
              "progress": { "status": "notStarted", "positionSec": 0 }
            }
          ]
        },
        {
          "id": "s2",
          "title": "الجهاز العضلي",
          "lessons": [
            {
              "id": "l3",
              "title": "أنواع العضلات",
              "durationSec": 110,
              "video": "assets/videos/lesson3.mp4",
              "progress": { "status": "notStarted", "positionSec": 0 }
            }
          ]
        }
      ]
    },
    {
      "id": "physiology-101",
      "title": "أساسيات علم وظائف الأعضاء",
      "instructor": "د. أحمد",
      "thumbnail": "assets/images/physiology.png",
      "sections": [
        {
          "id": "s1",
          "title": "الجهاز الدوري",
          "lessons": [
            {
              "id": "l1",
              "title": "القلب",
              "durationSec": 100,
              "video": "assets/videos/lesson1.mp4",
              "progress": { "status": "notStarted", "positionSec": 0 }
            },
            {
              "id": "l2",
              "title": "الأوعية الدموية",
              "durationSec": 90,
              "video": "assets/videos/lesson2.mp4",
              "progress": { "status": "notStarted", "positionSec": 0 }
            }
          ]
        },
        {
          "id": "s2",
          "title": "الجهاز التنفسي",
          "lessons": [
            {
              "id": "l3",
              "title": "الرئتان",
              "durationSec": 130,
              "video": "assets/videos/lesson3.mp4",
              "progress": { "status": "notStarted", "positionSec": 0 }
            }
          ]
        }
      ]
    }
  ]
}
```

`status` values: `"notStarted" | "inProgress" | "completed"`. Course-level progress % is **derived**, not stored (completed lessons / total lessons) — compute it in `CourseModel` as a getter, don't cache a stale number.

### Model note

`LessonModel.progress` is non-nullable with the JSON default above as fallback. `CoursesRepoImpl` decodes the asset, then for each lesson looks up a saved `LessonProgressModel` from local storage by `lessonId` and replaces `progress` if one exists. UI never talks to local storage directly — only the repo does.

---

## 3. Colors — `core/styles/colors.dart`

Pulled from Thaheen's real site (thaheensa.com) design tokens — primary blue, off-white surface, near-black text — kept in the same `ColorManager` static-const shape as your existing admin project's `colors.dart`, so it's a drop-in for `CustomText`/shared widgets. Semantic success/warning/error/info are converted from the site's own toast tokens (HSL → hex) rather than invented.

```dart
import 'package:flutter/material.dart';

class ColorManager {
  // ── Brand ─────────────────────────────────────────────────
  static const Color primary      = Color(0xFF2395F8); // accent / CTA
  static const Color primaryDark  = Color(0xFF1C77C6); // hover/pressed, gradient end
  static const Color primaryGradientStart = Color(0xFF2AA7FF);
  static const Color primaryGradientEnd   = Color(0xFF0957DE);

  // ── Surfaces ──────────────────────────────────────────────
  static const Color background   = Color(0xFFF8F8FF); // app scaffold bg
  static const Color surface      = Colors.white;       // cards
  static const Color surfaceElevated = Color(0xFFEBEBEB);
  static const Color cardBorder   = Color(0xFFF0F0F0);
  static const Color borderColor  = Color(0xFF3A3A3A);

  // ── Text ──────────────────────────────────────────────────
  static const Color textPrimary   = Color(0xFF000000);
  static const Color textMuted     = Color(0xFF8A8A8A);
  static const Color textOnPrimary = Colors.white;

  // ── Semantic (converted from Thaheen's toast tokens) ──────
  static const Color success = Color(0xFF37A471); // hsl(152 50% 43%)
  static const Color warning = Color(0xFFFFC65C); // hsl(39 100% 68%)
  static const Color error   = Color(0xFFC13D2F); // hsl(6 61% 47%)
  static const Color info    = Color(0xFF3182ED); // hsl(214 84% 56%)

  // ── Lesson / progress status (LMS-specific) ───────────────
  static const Color statusNotStarted = textMuted;
  static const Color statusInProgress = warning;
  static const Color statusCompleted  = success;
  static const Color statusLocked     = Color(0xFFB0B0B0);

  // ── Misc ──────────────────────────────────────────────────
  static const Color divider = surfaceElevated;
  static const Color black   = Colors.black;
  static const Color white   = Colors.white;
}
```

Radius/spacing to pair with these colors when styling widgets (not code, just constants to reuse consistently): **4px** radius for buttons/cards, spacing scale **4/8/12/16/20/28/40/56**, card shadow `BoxShadow(color: Color(0x2625C361 /* ~rgba(37,44,97,0.15) */), blurRadius: 15, offset: Offset(0, 5))`.

---

## 4. General settings class — reads from local storage

Single source of truth for language, theme, and last playback speed. Follows the same `CacheHelper`/`CacheKeys` pattern as your existing project (static `SharedPreferences` wrapper + typed keys), so `SettingsRepoImpl` is a thin adapter over it — no new caching mechanism introduced.

```dart
// core/cache/cache_keys.dart
class CacheKeys {
  static const String appSettings = "app_settings_json";
}
```

```dart
// core/settings/model/app_settings_model.dart
import 'package:equatable/equatable.dart';

enum AppLanguage { ar, en }
enum AppThemeMode { light, dark }

class AppSettingsModel extends Equatable {
  final AppLanguage language;
  final AppThemeMode themeMode;
  final double lastPlaybackSpeed;

  const AppSettingsModel({
    this.language = AppLanguage.ar,
    this.themeMode = AppThemeMode.light,
    this.lastPlaybackSpeed = 1.0,
  });

  AppSettingsModel copyWith({
    AppLanguage? language,
    AppThemeMode? themeMode,
    double? lastPlaybackSpeed,
  }) {
    return AppSettingsModel(
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      lastPlaybackSpeed: lastPlaybackSpeed ?? this.lastPlaybackSpeed,
    );
  }

  Map<String, dynamic> toJson() => {
        'language': language.name,
        'themeMode': themeMode.name,
        'lastPlaybackSpeed': lastPlaybackSpeed,
      };

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      language: AppLanguage.values.firstWhere(
        (e) => e.name == json['language'],
        orElse: () => AppLanguage.ar,
      ),
      themeMode: AppThemeMode.values.firstWhere(
        (e) => e.name == json['themeMode'],
        orElse: () => AppThemeMode.light,
      ),
      lastPlaybackSpeed: (json['lastPlaybackSpeed'] as num?)?.toDouble() ?? 1.0,
    );
  }

  @override
  List<Object?> get props => [language, themeMode, lastPlaybackSpeed];
}
```

```dart
// core/settings/repo/settings_repo.dart
abstract class SettingsRepo {
  Future<AppSettingsModel> getSettings();
  Future<void> saveSettings(AppSettingsModel settings);
}
```

```dart
// core/settings/repo/settings_repo_impl.dart
import 'dart:convert';
import '../../cache/cache_helper.dart';
import '../../cache/cache_keys.dart';
import '../model/app_settings_model.dart';
import 'settings_repo.dart';

class SettingsRepoImpl implements SettingsRepo {
  @override
  Future<AppSettingsModel> getSettings() async {
    final raw = CacheHelper.getData<String>(key: CacheKeys.appSettings);
    if (raw == null) return const AppSettingsModel(); // first launch defaults
    try {
      return AppSettingsModel.fromJson(jsonDecode(raw));
    } catch (_) {
      return const AppSettingsModel(); // corrupt value -> fall back safely
    }
  }

  @override
  Future<void> saveSettings(AppSettingsModel settings) async {
    await CacheHelper.saveData(
      key: CacheKeys.appSettings,
      value: jsonEncode(settings.toJson()),
    );
  }
}
```

```dart
// core/settings/view_model/settings_state.dart
import 'package:equatable/equatable.dart';
import '../model/app_settings_model.dart';

class SettingsState extends Equatable {
  final AppSettingsModel settings;
  const SettingsState({this.settings = const AppSettingsModel()});

  SettingsState copyWith({AppSettingsModel? settings}) {
    return SettingsState(settings: settings ?? this.settings);
  }

  @override
  List<Object?> get props => [settings];
}
```

```dart
// core/settings/view_model/settings_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/app_settings_model.dart';
import '../repo/settings_repo.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepo settingsRepo;
  SettingsCubit({required this.settingsRepo}) : super(const SettingsState());

  /// Call once at app bootstrap, before runApp, so first frame is already
  /// in the right language/theme — reads straight from local storage.
  Future<void> loadSettings() async {
    final saved = await settingsRepo.getSettings();
    emit(state.copyWith(settings: saved));
  }

  Future<void> changeLanguage(AppLanguage language) async {
    final updated = state.settings.copyWith(language: language);
    emit(state.copyWith(settings: updated));
    await settingsRepo.saveSettings(updated);
  }

  Future<void> changeTheme(AppThemeMode themeMode) async {
    final updated = state.settings.copyWith(themeMode: themeMode);
    emit(state.copyWith(settings: updated));
    await settingsRepo.saveSettings(updated);
  }

  Future<void> updateLastPlaybackSpeed(double speed) async {
    final updated = state.settings.copyWith(lastPlaybackSpeed: speed);
    emit(state.copyWith(settings: updated));
    await settingsRepo.saveSettings(updated);
  }
}
```

`LessonPlayerCubit` reads `settingsCubit.state.settings.lastPlaybackSpeed` as the initial speed, and calls `updateLastPlaybackSpeed` whenever the user changes it in `speed_selector_sheet.dart`. `getSettings()`/`saveSettings()` are written as `Future`-returning even though `CacheHelper` is sync under the hood — keeps the repo swappable for a real backend later without touching the cubit.

---

## 5. Repo pattern — treat the local JSON load as an "API call"

This keeps the exact same shape as your real API repos, so swapping to a backend later is a drop-in change.

```dart
// core/network/api_result.dart
class ApiResult<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  const ApiResult.success(this.data) : error = null, isSuccess = true;
  const ApiResult.failure(this.error) : data = null, isSuccess = false;
}
```

```dart
// core/constants/asset_paths.dart
class AssetPaths {
  static const String coursesData = 'assets/data/courses.json';
}
```

```dart
// features/courses/repo/courses_repo.dart
abstract class CoursesRepo {
  Future<ApiResult<List<CourseModel>>> getCourses();
}
```

```dart
// features/courses/repo/courses_repo_impl.dart
class CoursesRepoImpl implements CoursesRepo {
  final ProgressLocalService progressLocalService; // Hive/CacheHelper wrapper

  CoursesRepoImpl({required this.progressLocalService});

  @override
  Future<ApiResult<List<CourseModel>>> getCourses() async {
    try {
      final raw = await rootBundle.loadString(AssetPaths.coursesData);
      final Map<String, dynamic> json = jsonDecode(raw);
      final List list = json['courses'] ?? [];

      final courses = list.map((e) => CourseModel.fromJson(e)).toList();

      // merge saved progress on top of the bundled defaults
      final merged = courses.map((course) {
        final sections = course.sections.map((section) {
          final lessons = section.lessons.map((lesson) {
            final saved = progressLocalService.getProgress(lesson.id);
            return saved != null ? lesson.copyWith(progress: saved) : lesson;
          }).toList();
          return section.copyWith(lessons: lessons);
        }).toList();
        return course.copyWith(sections: sections);
      }).toList();

      return ApiResult.success(merged);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }
}
```

`CoursesCubit.getCourses()` calls this and maps `GetState.loading/success/failure` exactly like the `ScoreboardCubit.getTeams()` pattern — `CourseDetailsCubit` and `LessonPlayerCubit` follow the same `getX()` shape for whatever they need (a single course, a single lesson's saved position, etc.), each through its own repo method.

---

## 6. Shared-widget usage (mandatory, no exceptions)

| Need | Widget |
| --- | --- |
| Any text on screen | `CustomText(text: ..., style: TextStyles.xxx)` — never a raw `Text()` or inline `TextStyle()` |
| Course thumbnail, section icons, empty-state illustration | `ImageHelper(imageType: ImageType.asset, image: ..., imageShape: ImageShape.rectangle, borderRadius: BorderRadius.circular(4.r))` — 4px radius matches the Thaheen card token |
| Course/section with zero lessons | `NoDataWidget(title: S.current.lessons)` |
| Missing/corrupt video file, failed JSON parse | `CustomErrorWidget(text: S.current.errorLoadingLesson, onRetry: () => cubit.retry())` |
| Buttons ("Next lesson", playback speed apply, retry) | `ElevatedButtonWidget` — background `ColorManager.primary`, text `ColorManager.textOnPrimary`, radius 4.r |

Pick the closest existing `TextStyles` entry per role instead of inventing a size — e.g. course title → `styleHeading9`/`titleLarge`, instructor name → `bodyMedium`, lesson duration → `labelMedium`, "not started/in progress/completed" badge → `labelLarge` with a `.copyWith(color: ColorManager.statusXxx)` for status color only (color is the one thing allowed to vary via `.copyWith()`, per your styling rule — never font size/weight).

---

## 7. Arabic/RTL + settings wiring at the app root

`main.dart`/`app.dart` should wrap `MaterialApp` with a `BlocBuilder<SettingsCubit, SettingsState>` that sets:

- `locale`: `Locale(state.settings.language.name)`
- `theme`/`darkTheme` + `themeMode`: driven by `state.settings.themeMode`, built from `ColorManager` (light: `background`/`surface`/`textPrimary`; dark: invert surfaces, keep `primary` as-is)
- `Directionality`/`localizationsDelegates`: standard Flutter RTL handling follows automatically from `locale: ar` once `S.current` (generated localization) covers both `ar.arb`/`en.arb`.

`SettingsCubit.loadSettings()` should run once at app start (e.g. in a splash/bootstrap step) before `runApp`, so language/theme/speed are correct on first frame — no flash of default English/light.

---

## 8. Build order for Antigravity

1. `core/cache/cache_helper.dart`, `core/cache/cache_keys.dart`, `core/network/api_result.dart`, `core/constants/asset_paths.dart`
2. `core/styles/colors.dart` (Thaheen palette)
3. `core/settings/*` (model → repo → cubit/state, backed by `CacheHelper`)
4. `assets/data/courses.json` + `courses` feature models (`CourseModel`, `SectionModel`, `LessonModel`, `LessonProgressModel`) with `fromJson`/`toJson`/`copyWith`
5. `courses` feature repo → cubit/state → screen → widgets
6. `course_details` feature (reuses `CourseModel` passed via navigation, its own cubit only handles unlock-status/tap logic)
7. `lesson_player` feature (video_player/chewie, resume position, 90% completion, speed control wired to `SettingsCubit`)
8. Progress unit tests: 90% completion rule, sequential unlock rule, course progress % calculation — pure functions/cubit methods, no widget needed to test them

Everything above is a pattern to replicate per feature, not a one-off — keep every new screen's cubit/state/repo the same shape as `courses`.

---

## 9. Domain models (fields, before any screen work starts)

These back all three screens — write these first, with `fromJson`/`toJson`/`copyWith`, before touching any cubit.

```dart
class LessonProgressModel extends Equatable {
  final String status;       // notStarted | inProgress | completed
  final int positionSec;
}

class LessonModel extends Equatable {
  final String id;
  final String title;
  final int durationSec;
  final String video;        // asset path
  final LessonProgressModel progress;

  bool get isCompleted => progress.status == 'completed';
}

class SectionModel extends Equatable {
  final String id;
  final String title;
  final List<LessonModel> lessons;
}

class CourseModel extends Equatable {
  final String id;
  final String title;
  final String instructor;
  final String thumbnail;
  final List<SectionModel> sections;

  // derived, not stored:
  List<LessonModel> get flatLessons =>
      sections.expand((s) => s.lessons).toList();
  int get totalLessons => flatLessons.length;
  int get completedLessons => flatLessons.where((l) => l.isCompleted).length;
  double get progressPercent =>
      totalLessons == 0 ? 0 : completedLessons / totalLessons;
  LessonModel? get continueWatchingLesson => flatLessons
      .cast<LessonModel?>()
      .firstWhere((l) => l!.progress.status == 'inProgress', orElse: () => null);
}
```

`CoursesRepo` gets a second method alongside `getCourses()`:

```dart
Future<ApiResult<CourseModel>> getCourseById(String courseId);
```

(same asset-load-plus-merge-progress logic, just filtered to one course) — used by `course_details` and `lesson_player` so they always read the freshest persisted progress instead of trusting whatever was passed through navigation.

---

## 10. Screen 1 — Courses screen

**State**

```dart
class CoursesState extends Equatable {
  final GetState coursesState;      // initial/loading/success/failure
  final List<CourseModel> courses;
  final String errorMessage;
}
```

**Cubit**

- `getCourses()` → `coursesRepo.getCourses()` → success: `courses` list; failure: `errorMessage`.
- Continue-watching card data is **not** separate state — derive it in the widget/a getter: first course whose `continueWatchingLesson != null`.

**Widgets**

- `courses_screen.dart` — `BlocBuilder<CoursesCubit, CoursesState>`, calls `getCourses()` in `initState`/on cubit creation. Three branches: loading → simple loader, failure → `CustomErrorWidget(onRetry: () => cubit.getCourses())`, empty list → `NoDataWidget(title: S.current.courses)`, success → `ListView` of `continue_watching_card.dart` (if any course has one) + `course_list_item.dart` per course.
- `continue_watching_card.dart` — thumbnail (`ImageHelper`), lesson title (`CustomText` + `TextStyles.titleMedium`), a thin progress bar, tap → push `LessonPlayerScreen` for that lesson.
- `course_list_item.dart` — thumbnail, title (`titleLarge`/`styleHeading9`), instructor (`bodyMedium`), `"${totalLessons} ${S.current.lessons}"` (`labelMedium`), a progress bar + `"${(progressPercent*100).round()}%"`, tap → push `CourseDetailsScreen(courseId: course.id)`.

---

## 11. Screen 2 — Course details screen

**Navigation input:** `courseId` only (not the whole `CourseModel`) — the screen re-fetches via `getCourseById` so progress is always current, even if it changed on another screen.

**State**

```dart
class CourseDetailsState extends Equatable {
  final GetState courseState;
  final CourseModel? course;
  final String errorMessage;
}
```

**Cubit**

- `getCourseDetails(String courseId)` → `coursesRepo.getCourseById(courseId)`.
- Pure, unit-testable unlock rule (put this in the cubit or a standalone function, not inline in a widget):

```dart
bool isLessonUnlocked(List<LessonModel> flatLessons, int index) {
  if (index == 0) return true;
  return flatLessons[index - 1].isCompleted;
}
```

- `onLessonTap(LessonModel lesson, int index, List<LessonModel> flatLessons)`: if unlocked → navigate to `LessonPlayerScreen`; if locked → cubit exposes a one-shot "locked tap" signal (or the widget just calls `isLessonUnlocked` itself and shows a `SnackBar`/dialog with `CustomText(text: S.current.lessonLocked)` directly — no need to round-trip through the cubit for a UI-only message).

**Widgets**

- `course_details_screen.dart` — loading/failure/empty (`NoDataWidget` if `course.sections` is empty or a section has zero lessons) exactly like screen 1; success → `ListView` of `section_tile.dart`.
- `section_tile.dart` — section title (`headlineSmall`/`titleLarge`), then its lessons rendered via `lesson_tile.dart`. If a section itself has no lessons, show `NoDataWidget` inline instead of an empty list.
- `lesson_tile.dart` — status icon (lock / play / check, colored via `ColorManager.statusXxx`), title (`bodyLarge`), duration formatted `mm:ss` (`labelMedium`), locked lessons rendered visually dimmed (`textMuted`) and `onTap` shows the locked message instead of navigating.

---

## 12. Screen 3 — Lesson player screen

**Navigation input:** `courseId` + `lessonId`. The cubit flattens that course's lessons once so "next lesson" and the unlock check both use the same ordered list as screen 2.

**State**

```dart
class LessonPlayerState extends Equatable {
  final GetState lessonState;          // loading the course/lesson data
  final CourseModel? course;
  final String currentLessonId;
  final Duration position;
  final Duration duration;
  final bool isPlaying;
  final bool isCompleted;
  final bool isFullscreen;
  final double playbackSpeed;
  final String errorMessage;           // e.g. video failed to load
}
```

Keep the `VideoPlayerController` itself as a plain field on the **cubit**, not inside the Equatable `state` — controllers aren't comparable/immutable and don't belong in state equality.

**Cubit — key methods (logic only, this is what the 3 required unit tests target)**

- `initLesson(courseId, lessonId)`: fetch course via repo, find the lesson, create `VideoPlayerController.asset(lesson.video)`, wrap `initialize()` in try/catch → on failure emit `errorMessage` (missing/corrupt file → `CustomErrorWidget`), on success `controller.seekTo(Duration(seconds: lesson.progress.positionSec))` (resume), set `playbackSpeed` from `SettingsCubit.state.settings.lastPlaybackSpeed` and call `controller.setPlaybackSpeed(...)`, start listening to `controller.addListener(_onTick)`.
- `_onTick()`: emit updated `position`/`isPlaying`; compute `position.inSeconds / duration.inSeconds`; **pure function** `bool isLessonComplete(int positionSec, int durationSec) => durationSec > 0 && positionSec / durationSec >= 0.9;` — when it flips true and wasn't already completed, persist `status: completed` via the progress local service and emit `isCompleted: true`. Persist position on every tick (or throttled) regardless, so a restart mid-lesson resumes correctly even without hitting 90%.
- `togglePlayPause()`, `seekTo(Duration)`, `changeSpeed(double speed)` (updates controller + calls `settingsCubit.updateLastPlaybackSpeed`), `toggleFullscreen()` (flips `isFullscreen`, widget reacts with `SystemChrome.setPreferredOrientations`).
- `goToNextLesson()`: pure function `String? nextLessonId(List<LessonModel> flatLessons, String currentId)` finds the next id; if it exists and `isLessonUnlocked(flatLessons, nextIndex)` (reuse the same function from section 11 — pull it into a shared `lesson_rules.dart` in `core/` so both cubits import the same logic instead of duplicating it), navigate/replace with the next lesson; otherwise disable the button.
- `close()`/`onDispose`: persist final position, dispose controller, remove listener.

**Widgets**

- `lesson_player_screen.dart` — video (`AspectRatio` + `VideoPlayer(controller)`), overlaid `player_controls.dart`; failure branch → `CustomErrorWidget(text: S.current.videoLoadError, onRetry: () => cubit.initLesson(...))` instead of a red screen.
- `player_controls.dart` — play/pause icon button, seek bar (`Slider`, RTL-aware — see note below), current/duration `CustomText` (`labelMedium`), speed button opening `speed_selector_sheet.dart`, fullscreen toggle, "Next lesson" `ElevatedButtonWidget` disabled/greyed when the next lesson is locked or this is the last lesson.
- `speed_selector_sheet.dart` — bottom sheet, 1x/1.25x/1.5x/2x as tappable rows, current speed highlighted with `ColorManager.primary`, closes on selection and calls `cubit.changeSpeed(speed)`.

**RTL note:** in an RTL layout the seek bar should still fill left-to-right in wall-clock terms for a video (this is a hard UX default, not a translation) — wrap the `Slider` in `Directionality(textDirection: TextDirection.ltr)` even though the rest of the screen stays RTL, so the thumb/track behave the way users expect from any video player.

---

## 13. Unit tests (satisfies the task's 3-test minimum)

Target the pure functions above directly — no widget/controller needed:

1. `isLessonComplete(positionSec, durationSec)` — true at exactly 90%, false at 89%, true above 90%, false when `durationSec == 0`.
2. `isLessonUnlocked(flatLessons, index)` — index 0 always true; index > 0 true only when the previous lesson's `isCompleted` is true; false otherwise.
3. `CourseModel.progressPercent` — 0 lessons → 0, all completed → 1.0, partial → exact fraction (e.g. 1/3 → 0.333...).

Put these three functions in a single `core/lesson_rules.dart` (or as `CourseModel`/pure top-level functions) so both `course_details` and `lesson_player` cubits import the same source of truth instead of re-implementing the rule twice.

---

## 14. Dependency injection — `injectable` + `get_it`

No manual `XCubit(repo: XRepoImpl())` wiring anywhere. Every repo and cubit is registered through `injectable`/`get_it`, same as your existing projects (`@LazySingleton(as: ScoreboardRepo)` pattern from the reference code, `@lazySingleton` on `CacheHelper`).

**Dependencies (`pubspec.yaml`)**

```yaml
dependencies:
  get_it: ^7.7.0
  injectable: ^2.4.4
dev_dependencies:
  injectable_generator: ^2.6.2
  build_runner: ^2.4.13
```

**Setup**

```dart
// core/di/injection.dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();
```

Run `dart run build_runner build --delete-conflicting-outputs` after adding/annotating a class to (re)generate `injection.config.dart`. `main.dart` calls `configureDependencies()` once, before `runApp`.

**Annotation rules for every class in this spec**

| Class | Annotation | Why |
| --- | --- | --- |
| `CacheHelper` | `@lazySingleton` | one instance, app-wide (already your existing pattern) |
| `SettingsRepoImpl` (impl of `SettingsRepo`) | `@LazySingleton(as: SettingsRepo)` | one instance |
| `CoursesRepoImpl` (impl of `CoursesRepo`) | `@LazySingleton(as: CoursesRepo)` | one instance, no per-screen state |
| `ProgressLocalService` | `@lazySingleton` | one instance |
| `SettingsCubit` | `@lazySingleton` | **global** app state (language/theme/speed) — must survive across screens, so singleton, not factory |
| `CoursesCubit` | `@injectable` | **factory** — fresh instance each time the Courses screen is built |
| `CourseDetailsCubit` | `@injectable` | factory — fresh instance per course visited |
| `LessonPlayerCubit` | `@injectable` | factory — fresh instance per lesson opened |

`@injectable` = new instance every `getIt<X>()` call (right for per-screen cubits so state doesn't leak between visits). `@lazySingleton` = one instance for the app's lifetime, created on first use (right for cross-cutting things like `SettingsCubit` and `CacheHelper`).

**Usage in screens** — replace any `BlocProvider(create: (_) => XCubit(repo: XRepoImpl()))` with:

```dart
BlocProvider(
  create: (_) => getIt<CoursesCubit>()..getCourses(),
  child: const CoursesScreen(),
)
```

Constructor-inject repo dependencies exactly like the reference `ScoreboardCubit`/`ScoreboardRepoImpl` pattern — e.g. `CoursesRepoImpl({required this.progressLocalService})`, `CoursesCubit({required this.coursesRepo})` — `injectable` resolves those from other registered `@lazySingleton`/`@injectable` classes automatically; nothing is `new`'d by hand anywhere in the app.

---

## 15. Screen composition rules (standing — apply to all screens, including future ones)

Caught during review of the first three screens; treat these as binding for anything built after this point, not just a one-time cleanup.

1. **One `BlocProvider` per screen, created unconditionally.** Never guess whether a provider already exists with `try { context.read<X>() } catch (_) { ... }`. The outer screen widget always does `BlocProvider(create: (_) => getIt<X>()..init(), child: XView())`.
2. **One `Scaffold`/`AppBar` per screen, built once.** The `GetState` switch only swaps the `body`; it never rebuilds the whole `Scaffold` per branch.
3. **Branch on `GetState` with a `switch` statement**, consistently across all screens — not `if`/`if`/`else` in some and `switch` in others.
4. **No derived lookups inline in `build()`.** Anything computed from state more than trivially (`firstWhere`, filtering, finding "the current X") is a named getter on the `State` class (e.g. `CoursesState.continueWatchingCourse`, `LessonPlayerState.currentLesson`), not recomputed inline on every rebuild — and it returns `null`/a safe default on a miss, never a `firstWhere(orElse: () => list.first)` that silently swaps in the wrong item or throws on an empty list.
5. **Cubits with a `@factoryParam` don't need it handed back by the widget.** If the cubit already stored `courseId`/`lessonId` (or similar) at construction, `onRetry`/`onRefresh` call a bare `cubit.retry()`/`cubit.refresh()` that reuses its own stored id — the screen never re-passes an id the cubit already has.
6. **Side effects that aren't just `emit()` (system chrome, orientation, overlays) go in a `BlocListener`, not inferred from a one-off flag in the widget tree.** E.g. `LessonPlayerState.isFullscreen` toggling drives `SystemChrome.setPreferredOrientations`/`setEnabledSystemUIMode` from a listener, with the inverse reliably run on screen dispose/pop — not just an `AppBar: state.isFullscreen ? null : AppBar(...)` that changes layout but not system UI.
7. **Full-bleed content (video, hero images) is not wrapped in the same `SafeArea` as the controls overlaid on it.** `SafeArea` wraps only the chrome that needs to avoid the notch/gesture bar; full-bleed media renders edge-to-edge behind it.
8. **A hardware/gesture back press while in a "modal" visual state (fullscreen, a sheet, an overlay) exits that state first, not the route** — handled via `PopScope`, not left to the default pop.

---

## 16. App bootstrap — `main.dart` & `my_app.dart`

The current `main.dart`/`my_app.dart` are copy-pasted from the admin project (LJF_admin) and still reference that project's features (`AdminCubit`, `JobOrderCubit`, `JobOrderFormScreen`), a commented-out dead first draft, `Environment.test`/API config that doesn't apply here (no backend), and the default Flutter counter boilerplate (`MyHomePage`). All of that gets removed, not kept commented out.

Routing follows the pattern from the working `pickngo` project — named routes via `Routes`/`AppRouter.generateRoute` plus a DI-registered `navigatorKey`, not a bare `home:` widget. This also satisfies the task's "Navigation with go_router or Navigator 2.0" requirement (named `onGenerateRoute` routing is the Navigator 1.0-named-routes approach; swap for `go_router` later without touching any screen if that's ever preferred — screens never construct each other directly either way).

### `core/routing/routes.dart`

```dart
class Routes {
  static const String courses = '/courses';
  static const String courseDetails = '/course-details';
  static const String lessonPlayer = '/lesson-player';
}
```

### `core/routing/lesson_player_args.dart`

```dart
class LessonPlayerArgs {
  final String courseId;
  final String lessonId;
  const LessonPlayerArgs({required this.courseId, required this.lessonId});
}
```

(`CourseDetailsScreen` only needs one string argument — `courseId` — so it's passed directly as `settings.arguments`, no wrapper needed. `LessonPlayerScreen` needs two, hence this small args class instead of a positional/dynamic hack.)

### `core/routing/app_router.dart`

```dart
import 'package:flutter/material.dart';
import '../../features/courses/view/screen/courses_screen.dart';
import '../../features/course_details/view/screen/course_details_screen.dart';
import '../../features/lesson_player/view/screen/lesson_player_screen.dart';
import 'lesson_player_args.dart';
import 'routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
        return MaterialPageRoute(builder: (_) => const CoursesScreen());
    }
  }
}
```

### DI — register the `navigatorKey` (`core/di/navigation_module.dart`)

```dart
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NavigationModule {
  @lazySingleton
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();
}
```

Same instance for the app's lifetime — `MaterialApp.navigatorKey` reads it via `getIt<GlobalKey<NavigatorState>>()`, same as the working `pickngo` app. Having it in DI (rather than a local variable in `my_app.dart`) means anything that ever needs to navigate without a `BuildContext` (unlikely here, but the reference project relies on it) can resolve the same key.

Every screen-to-screen push now goes through `Navigator.pushNamed`, not direct widget construction:

```dart
Navigator.pushNamed(context, Routes.courseDetails, arguments: course.id);
Navigator.pushNamed(
  context,
  Routes.lessonPlayer,
  arguments: LessonPlayerArgs(courseId: courseId, lessonId: lesson.id),
);
```

This replaces the "tap → push `CourseDetailsScreen(courseId: ...)`" wording in sections 10–12 — those now mean "navigate via `Routes.courseDetails`/`Routes.lessonPlayer`", not a direct `MaterialPageRoute(builder: (_) => CourseDetailsScreen(...))`.

**`main.dart`**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/cache/cache_helper.dart';
import 'core/di/injection.dart';
import 'core/settings/view_model/settings_cubit.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await CacheHelper.init();            // SharedPreferences must be ready first
  configureDependencies();             // get_it + injectable

  final settingsCubit = getIt<SettingsCubit>();
  await settingsCubit.loadSettings();  // read language/theme/speed before first frame

  runApp(MyApp(settingsCubit: settingsCubit));
}
```

**`my_app.dart`**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/localization/generated/l10n.dart';
import 'core/settings/model/app_settings_model.dart';
import 'core/settings/view_model/settings_cubit.dart';
import 'core/settings/view_model/settings_state.dart';
import 'core/styles/colors.dart';
import 'core/styles/styles.dart';
import 'core/di/injection.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';

class MyApp extends StatelessWidget {
  final SettingsCubit settingsCubit;
  const MyApp({super.key, required this.settingsCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: settingsCubit, // already loaded in main() — don't recreate/reload here
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (context, child) {
          return BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              final isDark = state.settings.themeMode == AppThemeMode.dark;
              return MaterialApp(
                title: 'Thaheen',
                debugShowCheckedModeBanner: false,
                locale: Locale(state.settings.language.name),
                supportedLocales: S.delegate.supportedLocales,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                theme: ThemeData(
                  useMaterial3: true,
                  fontFamily: TextStyles.fontFamily,
                  primaryColor: ColorManager.primary,
                  scaffoldBackgroundColor: ColorManager.background,
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: ColorManager.primary,
                    brightness: Brightness.light,
                  ),
                ),
                darkTheme: ThemeData(
                  useMaterial3: true,
                  fontFamily: TextStyles.fontFamily,
                  primaryColor: ColorManager.primary,
                  scaffoldBackgroundColor: const Color(0xFF121212),
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: ColorManager.primary,
                    brightness: Brightness.dark,
                  ),
                ),
                themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
                navigatorKey: getIt<GlobalKey<NavigatorState>>(),
                initialRoute: Routes.courses,
                onGenerateRoute: AppRouter.generateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
```

Notes for whoever (Antigravity) implements this:

- `SettingsCubit` is only ever `BlocProvider.value`'d at the root, never re-created with `create:` elsewhere — it's the one `@lazySingleton` cubit (section 14), so every screen that needs it (e.g. `LessonPlayerCubit` reading `lastPlaybackSpeed`) resolves the same instance via `getIt<SettingsCubit>()`, not a new one.
- `locale: Locale(state.settings.language.name)` relies on `AppLanguage.ar`/`.en` (section 4) matching real locale codes — they do (`'ar'`, `'en'`) since `AppLanguage.name` is used directly.
- `Routes.courses` is the real starting route now — no `JobOrderFormScreen`, no `MyHomePage` counter demo, no commented-out first draft, no hardcoded `Locale("en")`/`Routes.splash` left in the file (no splash screen is needed here — settings are already loaded by `main()` before `runApp`, so there's nothing for a splash to wait on).