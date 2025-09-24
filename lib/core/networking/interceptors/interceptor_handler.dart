import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class InterceptorsHandler {
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler);

  void onResponse(Response response, ResponseInterceptorHandler handler);

  Future<void> onError(DioException err, ErrorInterceptorHandler handler);
}
