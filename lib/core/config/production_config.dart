import 'package:injectable/injectable.dart';

import 'api_config.dart';
@LazySingleton(as: ApiConfiguration, env: [Environment.prod])
class ProductionApiConfiguration extends ApiConfiguration {
  @override
  String get baseUrl => "https://prod-base";

  // Uncomment and implement the below lines if Microsoft authentication is needed
  @override
  String get clientId => "prod-client";

  @override
  String get scope => "prod-scope";

  @override
  String get clientSecret => "prod-secret";
}
