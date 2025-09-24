import 'package:injectable/injectable.dart';

import 'api_config.dart';

@LazySingleton(as: ApiConfiguration, env: [Environment.test])
class TestApiConfiguration extends ApiConfiguration {
  @override
  String get baseUrl => "https://jsonplaceholder.typicode.com";

  // Uncomment and implement the below lines if Microsoft authentication is needed
  @override
  String get clientId => "test-client";

  @override
  String get scope => "test-scope";

  @override
  String get clientSecret => "test-secret";
}
