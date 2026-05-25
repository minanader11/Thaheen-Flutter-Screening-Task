import 'package:LJF_admin/core/networking/error_handle/error_handler_entity.dart';

abstract class ErrorParser {
  ErrorHandler parse(Object error);
}
