/// Thrown to indicate that a platform interaction failed in the platform
/// plugin.
///
class WebPlatformException implements Exception {
  WebPlatformException({
    required this.code,
    this.message,
    this.stacktrace,
    this.exception,
  });

  /// An error code.
  final String code;

  /// A human-readable error message
  final String? message;

  /// Inner exception
  final Object? exception;

  /// Error stacktrace
  final StackTrace? stacktrace;

  @override
  String toString() {
    return 'WebPlatformException(code: $code, message: $message, exception: $exception, stacktrace: $stacktrace)';
  }
}
