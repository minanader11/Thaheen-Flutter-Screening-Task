import 'dart:async';
import 'dart:developer';
import 'package:Thaheen/core/config/api_config.dart';
import 'package:Thaheen/core/get_it/injection.dart';
import 'package:Thaheen/core/networking/refresh_token_handler/refresh_token_handler_impl.dart';
import 'package:dio/dio.dart';
import 'package:Thaheen/core/constants/cache_keys.dart';
import 'package:Thaheen/core/local_storage/secure_storage.dart';
import 'package:Thaheen/core/networking/interceptors/interceptor_handler.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: InterceptorsHandler)
class InterceptorHandlerImp extends InterceptorsHandler {
  final RefreshTokenHandlerImpl refreshTokenHandler=RefreshTokenHandlerImpl(getIt<ApiConfiguration>());

  Completer<String?>? _refreshCompleter;

  InterceptorHandlerImp();

  //====================== onRequest =========================
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SecureStorageHelper.read<String>(
      key: CacheKeys.accessToken,
    );
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  //====================== onResponse =========================
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  //====================== onError =========================
  @override
  Future<void> onError(
      DioException error, ErrorInterceptorHandler handler) async {
    log("ERROR ON THIS REQUEST PATH: ${error.requestOptions.path}");
    log("ERROR StatusCode ${error.response?.statusCode}");
    log("ERROR ${error.response}");

    if (error.response?.statusCode == 401) {
      return _handle401Error(error, handler);
    } else {
      return handler.next(error);
    }
  }

  //====================== handle 401 Error ========================
  Future<void> _handle401Error(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final isRetry = err.requestOptions.extra['isRetry'] == true;
    if (isRetry) {
      log("❌ Retry already attempted. Rejecting.");
      return handler.reject(err);
    }

    String? newToken;

    try {
      if (_refreshCompleter != null) {
        // Another request is already refreshing → wait for it
        log("🔒 Waiting for ongoing token refresh...");
        newToken = await _refreshCompleter!.future;
      } else {
        // Start refresh
        log("🔄 Refreshing token...");
        _refreshCompleter = Completer<String?>();

        try {
          newToken = await refreshTokenHandler.getRefreshToken();
          _refreshCompleter!.complete(newToken);
          log("✅ Token refreshed.");
        } catch (e) {
          _refreshCompleter!.completeError(e);
          rethrow;
        } finally {
          _refreshCompleter = null;
        }
      }
    } catch (e) {
      log("❌ Refresh failed: $e");
      return handler.reject(err);
    }

    // Retry logic with new token
    try {
      final originalOptions = err.requestOptions;

      final retryOptions = Options(
        method: originalOptions.method,
        headers: {
          ...originalOptions.headers,
          'Authorization': 'Bearer $newToken',
        },
        responseType: originalOptions.responseType,
        contentType: originalOptions.contentType,
        extra: {...originalOptions.extra, 'isRetry': true},
        followRedirects: originalOptions.followRedirects,
        receiveDataWhenStatusError: originalOptions.receiveDataWhenStatusError,
        validateStatus: originalOptions.validateStatus,
        requestEncoder: originalOptions.requestEncoder,
        responseDecoder: originalOptions.responseDecoder,
        sendTimeout: originalOptions.sendTimeout,
        receiveTimeout: originalOptions.receiveTimeout,
      );

      final retryResponse = await refreshTokenHandler.dio.request(
        originalOptions.path,
        data: originalOptions.data,
        queryParameters: originalOptions.queryParameters,
        options: retryOptions,
      );

      log("✅ Retry successful for ${originalOptions.path}");
      return handler.resolve(retryResponse);
    } catch (e) {
      log("❌ Retry request failed: $e");
      return handler.reject(err);
    }
  }
}
