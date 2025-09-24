import 'package:dio/dio.dart';

abstract class RequestStrategy {
  Future<Response> execute(
    Dio dio,
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });
}

//Get
class GetStrategy implements RequestStrategy {
  @override
  Future<Response> execute(
    Dio dio,
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }
}

//Post
class PostStrategy implements RequestStrategy {
  @override
  Future<Response> execute(
    Dio dio,
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return dio.post(
      path,
      data: body,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }
}

//Put

class PutStrategy implements RequestStrategy {
  @override
  Future<Response> execute(
    Dio dio,
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return dio.put(
      path,
      data: body,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }
}

//Patch
class PatchStrategy implements RequestStrategy {
  @override
  Future<Response> execute(
    Dio dio,
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return dio.patch(
      path,
      data: body,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }
}

//Delete
class DeleteStrategy implements RequestStrategy {
  @override
  Future<Response> execute(
    Dio dio,
    String path, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return dio.delete(
      path,
      data: body,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }
}
