import 'package:dio/dio.dart';
import 'package:base_project/core/config/api_config.dart';
import 'package:base_project/core/get_it/dependecy_injection.dart';
import 'package:base_project/core/networking/api_client/api_client.dart';
import 'package:base_project/core/networking/dio_helper/dio_helper.dart';
import 'package:base_project/core/networking/error_handle/dio_error_parser.dart';
import 'package:base_project/core/networking/error_handle/error_parser.dart';
import 'package:base_project/core/networking/interceptors/interceptor_handler.dart';
import 'package:base_project/core/networking/interceptors/interceptor_handler_imp.dart';
import 'package:base_project/core/networking/refresh_token_handler/refresh_token_handler_impl.dart';

void dioDi({required ApiConfiguration config}) {
  // Register config
  getIt.registerSingleton<ApiConfiguration>(config);
  // Error Parser
  getIt.registerLazySingleton<ErrorParser>(() => DioErrorParser());

  // Refresh Token Handler
  getIt.registerLazySingleton<RefreshTokenHandlerImpl>(
      () => RefreshTokenHandlerImpl(getIt<ApiConfiguration>()));

  // Interceptor Handler
  getIt.registerLazySingleton<InterceptorsHandler>(
    () => InterceptorHandlerImp(getIt<RefreshTokenHandlerImpl>()),
  );

  // DioHelper
  getIt.registerLazySingleton<DioHelper>(
    () => DioHelper(getIt<InterceptorsHandler>(), getIt<ApiConfiguration>()),
  );

  // Dio
  getIt.registerLazySingleton<Dio>(() => getIt<DioHelper>().getDio());

  // inject Dio into RefreshTokenHandlerImpl (to break circular dep)
  getIt<RefreshTokenHandlerImpl>().setDio(getIt<Dio>());

  // ApiClient
  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(
      dio: getIt<Dio>(),
      errorParser: getIt<ErrorParser>(),
    ),
  );
}
