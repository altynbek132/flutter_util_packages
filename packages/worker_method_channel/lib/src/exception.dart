// ignore_for_file: public_member_api_docs, sort_constructors_first

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
  final String? exception;

  /// Error stacktrace
  final StackTrace? stacktrace;

  @override
  String toString() {
    return 'WebPlatformException(code: $code, message: $message, exception: $exception, stacktrace: $stacktrace)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'message': message,
      'exception': exception,
      'stacktrace': stacktrace.toString(),
    };
  }

  factory WebPlatformException.fromMap(Map<String, dynamic> map) {
    return WebPlatformException(
      code: map['code'],
      message: map['message'],
      exception: map['exception'],
      stacktrace: map['stacktrace'] == null ? null : StackTrace.fromString(map['stacktrace']),
    );
  }
}
