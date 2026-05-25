import 'package:LJF_admin/core/networking/api_client/request_executer.dart';
import 'package:LJF_admin/core/networking/api_client/request_strategy.dart';
import 'package:LJF_admin/core/networking/api_result/api_result.dart';
import 'package:LJF_admin/core/networking/error_handle/error_parser.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiClient {
  RequestExecutor executor;

  ApiClient({
    required Dio dio,
    required ErrorParser errorParser,
  }) : executor = RequestExecutor(dio, errorParser);

  Future<ApiResult<T>> get<T>(
    String path, {
    String? functionName,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(dynamic data)? converter,
  }) =>
      executor.execute(
        GetStrategy(),
        path,
        queryParameters: queryParameters,
        headers: headers,
        converter: converter,
        functionName: functionName,
      );

  Future<ApiResult<T>> post<T>(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(dynamic data)? converter,
    String? functionName,
  }) =>
      executor.execute(
        PostStrategy(),
        path,
        body: body,
        queryParameters: queryParameters,
        headers: headers,
        converter: converter,
        functionName: functionName,
      );

  Future<ApiResult<T>> put<T>(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(dynamic data)? converter,
    required String functionName,
  }) =>
      executor.execute(
        PutStrategy(),
        path,
        body: body,
        queryParameters: queryParameters,
        headers: headers,
        converter: converter,
        functionName: functionName,
      );

  Future<ApiResult<T>> patch<T>(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(dynamic data)? converter,
    String? functionName,
  }) =>
      executor.execute(
        PatchStrategy(),
        path,
        body: body,
        queryParameters: queryParameters,
        headers: headers,
        converter: converter,
        functionName: functionName,
      );

  Future<ApiResult<T>> delete<T>(
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    T Function(dynamic data)? converter,
    String? functionName,
  }) =>
      executor.execute(
        DeleteStrategy(),
        path,
        body: body,
        queryParameters: queryParameters,
        headers: headers,
        converter: converter,
        functionName: functionName,
      );
}
