import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:LJF_admin/core/config/api_config.dart';
import 'package:LJF_admin/core/constants/cache_keys.dart';
import 'package:LJF_admin/core/local_storage/secure_storage.dart';
import 'package:LJF_admin/core/networking/refresh_token_handler/refresh_token_hanlder.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: RefreshTokenHandler)
class RefreshTokenHandlerImpl implements RefreshTokenHandler {
  final ApiConfiguration config;

  late Dio dio; // not final anymore

  RefreshTokenHandlerImpl(this.config);

  void setDio(Dio dioInstance) {
    dio = dioInstance;
  }

  //===================== save Logged InUser Session =======================
  @override
  Future<void> saveLoggedInUserSession({required String token}) async {
    //  save access token
    await SecureStorageHelper.write(key: CacheKeys.accessToken, value: token);
  }

  //====================== get refresh token ====================================
  @override
  Future<String?> getRefreshToken() async {
    String oauth2Url =
        "https://login.microsoftonline.com/${config.tenantId}/oauth2/v2.0/token";

    var getAppTokenbody = {
      'grant_type': "client_credentials",
      "tenant": config.tenantId,
      "client_id": config.clientId,
      "scope": config.scope,
      "redirect_uri": config.redirectUri,
      "client_secret": config.clientSecret,
    };
    log("configration getAppTokenbody $getAppTokenbody");


    final response = await dio.post(
      oauth2Url,
      data: getAppTokenbody,
      options: Options(contentType: 'application/x-www-form-urlencoded'),
    );

    if (response.statusCode == 200) {
      String token = response.data['access_token'];
      log("======== Token : $token ======");
      await saveLoggedInUserSession(token: token);
      return token;
    } else {
      throw Exception("Failed to refresh token");
    }
  }
}
