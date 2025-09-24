import 'package:base_project/core/networking/error_handle/error_handler_entity.dart';

abstract class ErrorParser {
  ErrorHandler parse(Object error);
}
