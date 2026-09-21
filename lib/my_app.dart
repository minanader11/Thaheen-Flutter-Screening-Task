// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:LJF_admin/core/config/api_config.dart';
import 'package:LJF_admin/core/get_it/dependecy_injection.dart';
import 'package:LJF_admin/core/get_it/injection.dart';
import 'package:LJF_admin/core/localization/localization_cubit/localization_cubit.dart';
import 'package:LJF_admin/core/routing/routes.dart';
import 'package:LJF_admin/core/services/app_life_cycle/app_life_cycle.dart';
import 'package:LJF_admin/core/services/connectivity_check/cubit/connectivity_cubit.dart';
import 'package:LJF_admin/core/styles/colors.dart';
import 'package:LJF_admin/core/styles/styles.dart';
import 'package:LJF_admin/features/admin/view/screen/admin_screen.dart';
import 'package:LJF_admin/features/admin/view_model/admin_cubit.dart';
import 'package:LJF_admin/features/job_order/view/screens/job_order_form_screen.dart';
import 'package:LJF_admin/features/job_order/view_model/job_order_cubit.dart';

import 'package:LJF_admin/main.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/localization/generated/l10n.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   final config = getIt<ApiConfiguration>();
  //   log("============ Base URL: ${config.baseUrl} ==============");
  //   sendRequest();
  //   return MultiBlocProvider(
  //     providers: [
  //       BlocProvider(
  //         create: (context) => getIt<LocalizationCubit>()..getSavedLanguage(),
  //       ),
  //     ],
  //     child: ScreenUtilInit(
  //       designSize: const Size(390, 844),
  //       minTextAdapt: true,
  //       splitScreenMode: true,
  //       builder: (context, child) {
  //         return BlocBuilder<LocalizationCubit, LocalizationState>(
  //           buildWhen: (previous, current) => previous.locale != current.locale,
  //           builder: (context, state) {
  //             return AnnotatedRegion<SystemUiOverlayStyle>(
  //               value: const SystemUiOverlayStyle(
  //                 statusBarColor: Color(0xFF4B0618),// Background color for the status bar
  //                 statusBarIconBrightness: Brightness.light,// For Android (light or dark icons)
  //                 statusBarBrightness: Brightness.dark,// For iOS (light or dark icons)
  //               ),
  //               child: MaterialApp(
  //                 title: "MSDF E-Services Citizen",
  //                 theme: ThemeData(
  //                   primaryColor: ColorManager.mainAppColor,
  //                   fontFamily: TextStyles.fontFamily,
  //                   scaffoldBackgroundColor: ColorManager.white
  //                 ),
  //              //   navigatorKey: getIttt<GlobalKey<NavigatorState>>(),
  //                 debugShowCheckedModeBanner: false,
  //                 locale: state.locale,
  //                 supportedLocales: S.delegate.supportedLocales,
  //                 localizationsDelegates: const [
  //                   S.delegate,
  //                   GlobalMaterialLocalizations.delegate,
  //                   GlobalCupertinoLocalizations.delegate,
  //                   GlobalWidgetsLocalizations.delegate,
  //                 ],
  //                 // builder: (context, child) {
  //                 //   return AppLifecycleWrapper(
  //                 //     child: MediaQuery(
  //                 //       data: MediaQuery.of(context).copyWith(
  //                 //         textScaler:
  //                 //             const TextScaler.linear(1.0), // lock font scaling
  //                 //       ),
  //                 //       child: child!,
  //                 //     ),
  //                 //   );
  //                 // },
  //              //  initialRoute: Routes.onboarding,
  //                 home: const ScoreboardScreen(),
  //            //    onGenerateRoute: AppRouter.generateRoute,
  //               ),
  //             );
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AdminCubit>(),
        ),
          BlocProvider(
          create: (context) => getIt<JobOrderCubit>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844), // scoreboard is 1920x1080
        minTextAdapt: true,
        splitScreenMode: false,
        builder: (context, child) {
          return MaterialApp(
            title: 'Scoring admin app LJF 2026',
            home: const JobOrderFormScreen(),
            debugShowCheckedModeBanner: false,
            locale: Locale("en"),
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
