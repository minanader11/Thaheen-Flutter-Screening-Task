import 'package:flutter_test/flutter_test.dart';
import 'package:LJF_admin/core/network/api_result.dart';

void main() {
  group('ApiResult', () {
    test('success creates instance with data, null error, and isSuccess=true', () {
      const result = ApiResult<String>.success('test_data');

      expect(result.isSuccess, isTrue);
      expect(result.isFailure, isFalse);
      expect(result.data, 'test_data');
      expect(result.error, isNull);
    });

    test('failure creates instance with null data, error message, and isSuccess=false', () {
      const result = ApiResult<String>.failure('An error occurred');

      expect(result.isSuccess, isFalse);
      expect(result.isFailure, isTrue);
      expect(result.data, isNull);
      expect(result.error, 'An error occurred');
    });

    test('when executes success callback on success', () {
      const result = ApiResult<int>.success(42);

      final value = result.when(
        success: (data) => 'Got $data',
        failure: (error) => 'Failed: $error',
      );

      expect(value, 'Got 42');
    });

    test('when executes failure callback on failure', () {
      const result = ApiResult<int>.failure('Network timeout');

      final value = result.when(
        success: (data) => 'Got $data',
        failure: (error) => 'Failed: $error',
      );

      expect(value, 'Failed: Network timeout');
    });

    test('toString formats correctly for success and failure', () {
      const successResult = ApiResult<String>.success('hello');
      expect(successResult.toString(), 'ApiResult.success(data: hello)');

      const failureResult = ApiResult<String>.failure('not found');
      expect(failureResult.toString(), 'ApiResult.failure(error: not found)');
    });
  });
}
