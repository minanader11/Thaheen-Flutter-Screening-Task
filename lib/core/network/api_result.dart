/// Generic Result wrapper for API and local operations.
/// Follows the specification in AGENTS.md Section 5.
class ApiResult<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  const ApiResult.success(this.data)
      : error = null,
        isSuccess = true;

  const ApiResult.failure(this.error)
      : data = null,
        isSuccess = false;

  bool get isFailure => !isSuccess;

  /// Helper to handle both success and failure cases cleanly.
  R when<R>({
    required R Function(T? data) success,
    required R Function(String? error) failure,
  }) {
    if (isSuccess) {
      return success(data);
    } else {
      return failure(error);
    }
  }

  @override
  String toString() {
    return isSuccess
        ? 'ApiResult.success(data: $data)'
        : 'ApiResult.failure(error: $error)';
  }
}
