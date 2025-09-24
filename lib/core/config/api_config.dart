import 'package:injectable/injectable.dart';

abstract class ApiConfiguration {
  String get baseUrl;

  //if you want to use microsoft auth uncomment below lines and implement it in test and production configration classes
  String get clientId;
  String get scope;
  String get clientSecret;
  String get tenantId => 'tenantId';
  String get redirectUri => 'redirect';

  // Config get msConfig => Config(
  //       tenant: tenantId,
  //       clientId: clientId,
  //       scope: scope,
  //       clientSecret: clientSecret,
  //       redirectUri: redirectUri,
  //       navigatorKey: getIt<GlobalKey<NavigatorState>>(),
  //     );
}
