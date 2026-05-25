import 'dart:developer';
import 'package:LJF_admin/core/config/api_config.dart';
import 'package:LJF_admin/core/get_it/injection.dart';
import 'package:LJF_admin/core/networking/api_client/request_strategy.dart';
import 'package:LJF_admin/core/networking/api_result/api_result.dart';
import 'package:LJF_admin/core/networking/dio_helper/dio_helper.dart';
import 'package:LJF_admin/core/networking/error_handle/error_parser.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
@module
abstract class RegisterModule {
  @lazySingleton
  Dio dio(ApiConfiguration config) {
    return getIt<DioHelper>().getDio();
  }
}
@lazySingleton
class RequestExecutor {
  final Dio dio;
  final ErrorParser errorParser;

  RequestExecutor(this.dio, this.errorParser);

  Future<ApiResult<T>> execute<T>(
    RequestStrategy strategy,
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(dynamic data)? converter,
    String? functionName,
  }) async {
    try {
      log("========= Method: ${strategy.runtimeType.toString()} =========");
      final finalHeaders = await _buildHeaders(
        headers,
        method: strategy.runtimeType.toString(),
      );
      final response = await strategy.execute(
        dio,
        path,
        body: body,
        queryParameters: queryParameters,
        headers: finalHeaders,
      );

      final data = converter != null ? converter(response.data) : response.data;

      log("=========== $functionName RESPONSE: ${response.data} ==========");

      return ApiResult.success(data as T);
    } catch (e) {
      log("=========== $functionName ERROR: ${e.toString()} ===========");
      return ApiResult.failure(errorParser.parse(e));
    }
  }

  /// ========== HEADERS BUILDER ==========
  Future<Map<String, String>> _buildHeaders(
    Map<String, String>? customHeaders, {
    required String method,
    String? prefer,
  }) async {
    final finalHeaders = Map<String, String>.from(dio.options.headers);

    if (customHeaders != null) {
      // override headers with custom headers
      // delete headers with and add custom headers
      finalHeaders.addAll(customHeaders);
    } else {
      // Use Default headers
      finalHeaders["Content-Type"] = "application/json";
      finalHeaders['Prefer'] = prefer ??
          (method.toLowerCase().contains('get')
              ? 'odata.include-annotations=OData.Community.Display.V1.FormattedValue'
              : 'return=representation');
    }

    return finalHeaders;
  }
}
