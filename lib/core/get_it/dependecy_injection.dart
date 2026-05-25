// import 'package:LJF_admin/core/config/api_config.dart';
//
// import 'package:LJF_admin/core/get_it/connectivity_di/connectivity_di.dart';
// import 'package:LJF_admin/core/get_it/dio_di/dio_di.dart';
// import 'package:LJF_admin/core/get_it/local_storage_di/cache_helper_di.dart';
// import 'package:LJF_admin/core/get_it/localization_di/localization_di.dart';
//
// import 'package:flutter/material.dart';
//
// import 'package:get_it/get_it.dart';
//
// //final GetIt getIttt = GetIt.instance;
//
// Future<void> getItInit({required ApiConfiguration apiConfiguration}) async {
//   // ================  Registering the global navigator key ====================
//   getIttt.registerLazySingleton<GlobalKey<NavigatorState>>(
//     () => GlobalKey<NavigatorState>(),
//   );
//   // ================= Registering CacheHelper =================================
//   await cacheHelperDi();
//   // ================= Registering Connectivity ================================
//   connectivityDI();
//   // ================= Registering Dio Dependencies ============================
//   dioDi(config: apiConfiguration);
//   // ================= Registering Localization Dependencies ===================
//   localizationDi();
//
//   //================= other Features ============================================
//   //make sure to create a similar function like loginCubitDi() for each feature
//   //and call that function here
// }
