import 'api_config.dart';

class TestApiConfiguration extends ApiConfiguration {
  @override
  String get baseUrl => "https://test-base";

  // Uncomment and implement the below lines if Microsoft authentication is needed
  @override
  String get clientId => "test-client";

  @override
  String get scope => "test-scope";

  @override
  String get clientSecret => "test-secret";
}
