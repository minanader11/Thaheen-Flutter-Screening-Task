class ErrorHandler {
  final String message;
  final int? statusCode;
  final Object? originalError;
  final ErrorType errorType;

  ErrorHandler({
    required this.message,
    required this.errorType,
    this.statusCode,
    this.originalError,
  });

  @override
  String toString() =>
      'ErrorHandler(message: $message, statusCode: $statusCode, type: $errorType)';
}
enum ErrorType {
  timeout,
  noInternet,
  unauthorized,
  badCertificate,
  serverError,
  cancel,
  unknown,
}