# Thaheen Mini LMS — Offline Video Learning Platform

[![GitHub Repo](https://img.shields.io/badge/GitHub-Repository-blue?logo=github)](https://github.com/minanader11/Thaheen-Flutter-Screening-Task.git)
**Repository URL**: [https://github.com/minanader11/Thaheen-Flutter-Screening-Task.git](https://github.com/minanader11/Thaheen-Flutter-Screening-Task.git)

A high-performance, offline-first mini Learning Management System (LMS) built with Flutter for health-sciences students. Designed Arabic-first with full RTL layout, custom offline video player, sequential course progression, persistent state, courses search, per-lesson notes, and a curated Thaheen design system.

---

## 📱 Features Overview

### 1. Courses Screen
* **Course List**: Displays bundled course thumbnails, title, instructor name, lesson count, and dynamically calculated progress percentage.
* **Continue Watching Card**: Automatically identifies the most recently watched unfinished lesson and displays a prominent continue card with direct deep-linking into playback.
* **Instant Course Search (Bonus)**: Real-time search bar that filters courses and instructors case-insensitively with clear and empty state handling.
* **Language & Theme Toggles**: Top AppBar quick switches for Arabic (ع) / English (EN) and Light / Dark modes.

### 2. Course Details Screen
* **Curriculum Breakdown**: Sections and lessons with exact lesson duration (`mm:ss`).
* **Lesson Progress Badges**: Visual status indicators for `Not Started`, `In Progress`, and `Completed`.
* **Sequential Unlock Rule**: Lesson 1 is unlocked by default; every subsequent lesson is locked until the preceding lesson is 100% completed.
* **Locked Interaction**: Tapping a locked lesson displays a localized, friendly SnackBar informing the student to complete previous lessons first.
* **Per-Lesson Notes Access (Bonus)**: Dedicated notes action directly on each lesson tile.

### 3. Lesson Player Screen
* **Offline Video Playback**: Plays local bundled video assets with zero internet requirement.
* **Custom Playback Controls**: Play/pause, 10-second skip forward/backward, and a scrubbable Slider seek bar with elapsed and total duration timers.
* **Playback Speed Selector**: Bottom sheet allowing playback at `1.0x`, `1.25x`, `1.5x`, and `2.0x`, persisting the user's last chosen speed across sessions.
* **Fullscreen & Landscape**: Auto-rotates orientation to landscape and enables immersive sticky UI in fullscreen mode.
* **Last Position Resume**: Automatically resumes playback from the exact second where the user last paused or exited.
* **90% Completion Rule**: Automatically marks the lesson as `completed` the moment playback reaches 90% of the video duration.
* **Next Lesson Progression**: "Next lesson" button that respects sequential unlock rules and transitions smoothly to the next video.
* **Per-Lesson Offline Notes (Bonus)**: Interactive bottom sheet to take, edit, and delete notes for any lesson, persisted locally.

### 4. Arabic-First & RTL
* Native Arabic design with Cairo typography, correct RTL padding, icons, and RTL-compliant player seek controls.
* Complete localization support (`intl_ar.arb` / `intl_en.arb`) with instant language switching without app reload.

---

## 🛠 Architecture & State Management Rationale

### Feature-First + Clean Architecture
The codebase is structured using **Feature-First + Clean Architecture**:

```
lib/
  core/
    cache/          // Local storage engine & cache keys
    constants/      // Asset paths, fonts, icons
    di/             // Dependency injection setup (GetIt + Injectable)
    localization/   // Generated l10n and ARB localization files
    network/        // ApiResult wrapper & network state abstractions
    rules/          // Pure business rules (90% completion, sequential unlock)
    services/       // Local persistence services (Progress, Notes)
    styles/         // ColorManager (Thaheen palette) & TextStyles
    widgets/        // Reusable atomic UI components (CustomText, ImageHelper, etc.)
  features/
    courses/        // Course list, search, continue watching
    course_details/ // Curriculum breakdown & section/lesson tiles
    lesson_player/  // Video player, custom controls, speed sheet, notes sheet
    splash/         // Branded launch screen
```

### Why Bloc / Cubit?
* **Predictability & Unidirectional Data Flow**: Cubits emit immutable states based on user actions, making state transitions deterministic and straightforward to trace.
* **Testability**: Pure business logic resides in Cubits and helper rules, allowing 100% test coverage without needing complex widget mounting.
* **Strict Separation of Concerns**: UI screens (`BlocBuilder`, `BlocListener`) strictly render state and dispatch events, with zero direct database or asset-reading code.
* **Screen-Scoped Instances**: Each screen manages its own Cubit (`CoursesCubit`, `CourseDetailsCubit`, `LessonPlayerCubit`), while `SettingsCubit` acts as the single global application state.

---

## 💾 Local Storage Choice & Justification

The project uses **Hive** wrapped in [CacheHelper](file:///F:/base%20project/lib/core/cache/cache_helper.dart) and [ProgressLocalService](file:///F:/base%20project/lib/core/services/progress_local_service.dart) for local persistence.

### Why Hive over SharedPreferences / SQLite / Isar?
1. **Performance**: Hive is a lightweight, ultra-fast NoSQL key-value database written in pure Dart. Reads are synchronous in-memory lookups after initialization, eliminating UI micro-stutters when fetching playback positions.
2. **Offline-First Fit**: Course progress, last-watched timestamps, playback speed, and notes are key-value in nature. An SQL database (SQLite/sqflite) adds unnecessary schema migration complexity and foreign-key overhead for a client-side offline viewer.
3. **No Native Compilation Friction**: Unlike Isar or complex SQLite bindings that require native C++ compilation, Hive runs everywhere (Android, iOS, Web, macOS, Windows, Linux) with zero build configuration issues.

---

## 🚀 How to Run the App

### Prerequisites
* Flutter SDK (3.22.0 or higher)
* Dart SDK (3.4.0 or higher)

### Installation & Run

1. **Clone the repository**:
   ```bash
   git clone https://github.com/minanader11/Thaheen-Flutter-Screening-Task.git
   cd Thaheen-Flutter-Screening-Task
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Generate code (Localization & Dependency Injection)**:
   ```bash
   flutter pub run intl_utils:generate
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run static analysis**:
   ```bash
   dart analyze lib test
   ```

5. **Run the test suite**:
   ```bash
   flutter test
   ```

6. **Launch the application**:
   ```bash
   flutter run
   ```

---

## 🧪 Testing Suite

The app includes **56 passing automated tests** covering unit logic, cubits, persistence, and widgets:

* **Progress Business Rules** (`test/core/lesson_rules_test.dart`):
  * Verifies 90% auto-completion boundary condition (89% is incomplete, 90% and above is complete).
  * Verifies sequential unlock rule (index 0 is always unlocked; index > 0 requires previous lesson completion).
  * Verifies course progress percentage calculation (0%, fractional, and 100% completion).
* **Local Persistence** (`test/core/cache/cache_helper_test.dart`):
  * Verifies progress persistence and isolation across courses.
  * Verifies per-lesson notes saving, retrieval, and deletion.
  * Verifies last-watched course and lesson recording.
* **Cubit & State Logic**:
  * `CoursesCubit`: verifies course loading, continue-watching resolution, and search filtering.
  * `CourseDetailsCubit`: verifies course detail resolution, error handling, and refresh.
  * `LessonPlayerCubit`: verifies speed changes, fullscreen toggles, and next lesson navigation.
* **Widget & Localization Tests**:
  * `SplashScreen`: verifies branded logo rendering and navigation timeout.
  * `Localization`: verifies Arabic RTL and English LTR text directions and translation accuracy.

To run all tests:
```bash
flutter test
```

---

## ⚖️ Trade-offs & What I'd Do with More Time

### Current Trade-offs:
1. **Bundled Asset Videos**: Bundling MP4 files in `assets/videos/` provides a zero-setup offline experience, but increases the application binary size. In a production app, videos would be served from a CDN with an encrypted HLS stream and selective background download management.
2. **Single-Box Persistence**: Storing progress and notes in a single Hive box is simple and fast. For enterprise scalability, separate boxes or SQLite tables per domain would allow granular data purge policies.

### With More Time:
* **Background Audio & Picture-in-Picture (PiP)**: Enable students to listen to lectures while taking notes in other apps.
* **Video Scrubbing Thumbnail Previews**: Generate and display thumbnail previews when scrubbing through the player slider.
* **Rich Markdown Notes**: Upgrade per-lesson notes to support rich text, bullet points, and timestamp bookmarks that seek the video upon tapping.
* **Interactive In-Video Quizzes**: Pause video playback at specific timestamps to test comprehension before continuing.

---

## ⏱ Time Spent
* **Architecture, Core Setup & DI**: ~45 minutes
* **Domain Models & Offline JSON Repository**: ~30 minutes
* **Course List, Details & Sequential Unlock Flow**: ~45 minutes
* **Video Player, Fullscreen, Custom Controls & Speed Selector**: ~1 hour 15 minutes
* **Arabic-First UX, Localization & Dark Mode**: ~45 minutes
* **Course Search & Per-Lesson Notes Features**: ~45 minutes
* **Unit, Cubit & Widget Test Suite (56 tests)**: ~45 minutes
* **Documentation & Polish**: ~30 minutes
* **Total**: ~6 hours (within the 4–6 hour timebox).
