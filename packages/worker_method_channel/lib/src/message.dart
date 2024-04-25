import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:worker_method_channel/src/exception.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class MessageFreezed with _$MessageFreezed {
  factory MessageFreezed({
    /// The unique identifier for the request.
    required final int requestId,

    /// The method associated with the message.
    required final String method,

    /// The body of the message, which can be a primitive type, List, or Map.
    final Object? body,

    /// An exception that occurred while processing the message, if any.
    final WebPlatformException? exception,
  }) = Message;

  factory MessageFreezed.fromJson(Map<String, dynamic> json) => _$MessageFreezedFromJson(json);
}
