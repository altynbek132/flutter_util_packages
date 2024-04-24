import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:worker_method_channel/src/freezed_annotations.dart';

part 'exception.freezed.dart';
part 'exception.g.dart';

/// Thrown to indicate that a platform interaction failed in the platform
/// plugin.
@freezedMutable
class WebPlatformExceptionFreezed with _$WebPlatformExceptionFreezed {
  @Implements<Exception>()
  factory WebPlatformExceptionFreezed({
    /// An error code.
    final String? code,

    /// A human-readable error message
    final String? message,

    /// Inner exception
    final Object? exception,

    /// Error stacktrace
    // ignore: invalid_annotation_target
    @JsonKey(
      fromJson: _stackFromJson,
      toJson: _stackToJson,
    )
    final StackTrace? stacktrace,
  }) = WebPlatformException;

  factory WebPlatformExceptionFreezed.fromJson(Map<String, dynamic> json) =>
      _$WebPlatformExceptionFreezedFromJson(json);
}

StackTrace? _stackFromJson(Object? value) {
  return value is String ? StackTrace.fromString(value) : null;
}

String? _stackToJson(StackTrace? stack) {
  return stack?.toString();
}
