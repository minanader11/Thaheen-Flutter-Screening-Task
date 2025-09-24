import 'package:dio/dio.dart';
import 'package:base_project/core/config/api_config.dart';
import 'package:base_project/core/networking/interceptors/interceptor_handler.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class DioHelper {
  final ApiConfiguration config;
  final InterceptorsHandler interceptorHandler;
  static Dio? _dio;

  DioHelper( this.interceptorHandler, this.config);
  Dio getDio() {
    if (_dio != null) return _dio!;

    _dio = Dio();
    _dio!.options = _defaultBaseOption;
    _dio!.interceptors.add(_interceptorsWrapper());
    return _dio!;
  }

  BaseOptions get _defaultBaseOption => BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        baseUrl: config.baseUrl,
      );
      
  @visibleForTesting
  InterceptorsWrapper get exposedInterceptorsWrapper => _interceptorsWrapper();

  InterceptorsWrapper _interceptorsWrapper() {
    return InterceptorsWrapper(
      onRequest: interceptorHandler.onRequest,
      onResponse: interceptorHandler.onResponse,
      onError: interceptorHandler.onError,
    );
  }
}
