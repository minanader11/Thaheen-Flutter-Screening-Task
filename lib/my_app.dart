// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

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
  final SettingsCubit? settingsCubit;
  const MyApp({super.key, this.settingsCubit});

  @override
  Widget build(BuildContext context) {
    final cubit = settingsCubit ?? getIt<SettingsCubit>();
    return BlocProvider.value(
      value: cubit, // already loaded in main() — don't recreate/reload here
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (context, child) {
          return BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              log("langg ${state.settings.language.name}");
              final isDark = state.settings.themeMode == AppThemeMode.dark;
              return MaterialApp(
                title: 'Thaheen',
                debugShowCheckedModeBanner: false,
                locale: Locale(state.settings.language.name),
                supportedLocales: const [
                  Locale('ar'),
                  Locale('en'),
                ],
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
                    // Keep surface tones consistent with the dark scaffold
                    surface: const Color(0xFF1E1E1E),
                    onSurface: const Color(0xFFE8E8E8),
                  ),
                ),
                themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
                navigatorKey: getIt<GlobalKey<NavigatorState>>(),
                initialRoute: Routes.splash,
                onGenerateRoute: AppRouter.generateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
