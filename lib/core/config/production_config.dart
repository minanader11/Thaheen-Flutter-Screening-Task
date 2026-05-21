import 'package:injectable/injectable.dart';

import 'api_config.dart';
@LazySingleton(as: ApiConfiguration, env: [Environment.prod])
class ProductionApiConfiguration extends ApiConfiguration {
  @override
  String get baseUrl => "http://localhost:5171/api/";

  // Uncomment and implement the below lines if Microsoft authentication is needed
  @override
  String get clientId => "prod-client";

  @override
  String get scope => "prod-scope";

  @override
  String get clientSecret => "prod-secret";
}
