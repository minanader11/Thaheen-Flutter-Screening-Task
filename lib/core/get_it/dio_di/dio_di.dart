// import 'package:dio/dio.dart';
// import 'package:base_project/core/config/api_config.dart';
// import 'package:base_project/core/get_it/dependecy_injection.dart';
// import 'package:base_project/core/networking/api_client/api_client.dart';
// import 'package:base_project/core/networking/dio_helper/dio_helper.dart';
// import 'package:base_project/core/networking/error_handle/dio_error_parser.dart';
// import 'package:base_project/core/networking/error_handle/error_parser.dart';
// import 'package:base_project/core/networking/interceptors/interceptor_handler.dart';
// import 'package:base_project/core/networking/interceptors/interceptor_handler_imp.dart';
// import 'package:base_project/core/networking/refresh_token_handler/refresh_token_handler_impl.dart';
//
// void dioDi({required ApiConfiguration config}) {
//   // Register config
//   getIttt.registerSingleton<ApiConfiguration>(config);
//   // Error Parser
//   getIttt.registerLazySingleton<ErrorParser>(() => DioErrorParser());
//
//   // Refresh Token Handler
//   getIttt.registerLazySingleton<RefreshTokenHandlerImpl>(
//       () => RefreshTokenHandlerImpl(getIttt<ApiConfiguration>()));
//
//   // Interceptor Handler
//   getIttt.registerLazySingleton<InterceptorsHandler>(
//     () => InterceptorHandlerImp(getIttt<RefreshTokenHandlerImpl>()),
//   );
//
//   // DioHelper
//   getIttt.registerLazySingleton<DioHelper>(
//     () => DioHelper(getIttt<InterceptorsHandler>(), getIttt<ApiConfiguration>()),
//   );
//
//   // Dio
//   getIttt.registerLazySingleton<Dio>(() => getIttt<DioHelper>().getDio());
//
//   // inject Dio into RefreshTokenHandlerImpl (to break circular dep)
//   getIttt<RefreshTokenHandlerImpl>().setDio(getIttt<Dio>());
//
//   // ApiClient
//   getIttt.registerLazySingleton<ApiClient>(
//     () => ApiClient(
//       dio: getIttt<Dio>(),
//       errorParser: getIttt<ErrorParser>(),
//     ),
//   );
// }
