
import 'package:LJF_admin/core/networking/error_handle/error_handler_entity.dart';

class ApiResult<T> {
  final T? data;
  final ErrorHandler? error;

  bool get isSuccess => data != null;
  bool get isFailure => error != null;

  ApiResult.success(this.data) : error = null;
  ApiResult.failure(this.error) : data = null;
}
