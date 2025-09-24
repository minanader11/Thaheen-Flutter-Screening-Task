import 'dart:async';

import 'package:injectable/injectable.dart';
abstract class RefreshTokenHandler {
  Future<void> saveLoggedInUserSession({required String token});

  Future<String?> getRefreshToken();
}
