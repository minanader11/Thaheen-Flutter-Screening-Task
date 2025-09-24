import 'dart:async';

abstract class RefreshTokenHandler {
  Future<void> saveLoggedInUserSession({required String token});

  Future<String?> getRefreshToken();
}
