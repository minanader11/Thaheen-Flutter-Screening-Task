import 'dart:io';
import 'package:dio/dio.dart';
import 'package:LJF_admin/core/localization/generated/l10n.dart';
import 'package:LJF_admin/core/networking/error_handle/error_handler_entity.dart';
import 'package:LJF_admin/core/networking/error_handle/error_parser.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: ErrorParser)
class DioErrorParser implements ErrorParser {
  @override
  ErrorHandler parse(Object error) {
    if (error is DioException) {
      final response = error.response;
      final statusCode = response?.statusCode ?? 0;
      final responseData = response?.data;

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.connectionError:
          return ErrorHandler(
            message: S.current.connectionTimeOutOrNetworkError,
            errorType: ErrorType.timeout,
            statusCode: statusCode,
            originalError: error,
          );

        case DioExceptionType.badCertificate:
          return ErrorHandler(
            message: S.current.sslCertificateIsInvalid,
            errorType: ErrorType.badCertificate,
            statusCode: statusCode,
            originalError: error,
          );

        case DioExceptionType.badResponse:
          String extractedMessage =
              '${S.current.Servererror} ($statusCode)'; //Todo change this message
          if (responseData is Map && responseData.containsKey('message')) {
            extractedMessage = responseData['message'].toString();
          } else if (responseData is String) {
            extractedMessage = responseData;
          }

          final errorType = statusCode == 401
              ? ErrorType.unauthorized
              : ErrorType.serverError;

          return ErrorHandler(
            message: extractedMessage,
            errorType: errorType,
            statusCode: statusCode,
            originalError: error,
          );

        case DioExceptionType.cancel:
          return ErrorHandler(
            message: S.current.RequestWasCancelled,
            errorType: ErrorType.cancel,
            originalError: error,
          );

        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            return ErrorHandler(
              message: S.current.NoInternetConnection,
              errorType: ErrorType.noInternet,
              originalError: error,
            );
          }
          return ErrorHandler(
            message: S.current.UnexpectedErrorOccurred,
            errorType: ErrorType.unknown,
            originalError: error,
          );
      }
    }

    return ErrorHandler(
      message:
          'Unexpected error: ${error.toString()}', //Todo change this message
      errorType: ErrorType.unknown,
      originalError: error,
    );
  }
}
