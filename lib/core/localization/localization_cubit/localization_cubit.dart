import 'dart:developer';
import 'dart:ui';

import 'package:LJF_admin/core/constants/cache_keys.dart';
import 'package:LJF_admin/core/local_storage/cache_helper.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../constants/localization.dart';

part 'localization_state.dart';
@LazySingleton()
class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit()
      : super(const LocalizationState(
          locale: Locale(LocalizationConstants.arabicLang),
        ));

  /// Loads the saved language from [CacheHelper] and updates the state.
  Future<void> getSavedLanguage() async {
    try {
      final String? cachedLanguageCode =
          CacheHelper.getData(key: CacheKeys.appLanguage);

      // Validate cached language code against supported languages.
      final String languageCode = cachedLanguageCode != null &&
              LocalizationConstants.supportedLanguageCodes.contains(
                cachedLanguageCode,
              )
          ? cachedLanguageCode
          : LocalizationConstants.arabicLang;

      emit(LocalizationState(locale: Locale(languageCode)));
    } catch (e) {
      emit(
        const LocalizationState(
          locale: Locale(LocalizationConstants.arabicLang),
        ),
      );
    }
  }

  /// Changes the app's language, persists it, and updates the state.
  Future<void> changeLanguageCode(String languageCode) async {
    // Validate language code and use SharedPrefsService.
    if (LocalizationConstants.supportedLanguageCodes.contains(languageCode) &&
        languageCode != state.locale.languageCode) {
      try {
        // Save the selected language code to CacheHelper.
        await CacheHelper.saveData(
          key: CacheKeys.appLanguage,
          value: languageCode,
        );

        emit(LocalizationState(locale: Locale(languageCode)));
      } catch (e) {
        log(" Error saving language code: $e");
        emit(state); // Re-emit current state on error.
      }
    } else if (!LocalizationConstants.supportedLanguageCodes.contains(
      languageCode,
    )) {
      emit(state); // CHANGE: Re-emit current state for unsupported language.
    }
  }
}
