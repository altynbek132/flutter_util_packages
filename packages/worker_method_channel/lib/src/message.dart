// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'exception.dart';

/// Represents a message sent between the worker and the main thread.
class Message {
  /// The unique identifier for the request.
  final int requestId;

  /// The method associated with the message.
  final String method;

  /// The body of the message, which can be a primitive type, List, or Map.
  final Object? body;

  /// An exception that occurred while processing the message, if any.
  final WebPlatformException? exception;

  /// Creates a new instance of the [Message] class.
  Message({
    required this.requestId,
    required this.method,
    this.body,
    this.exception,
  });

  @override
  String toString() {
    return 'Message(requestId: $requestId, method: $method, body: $body, exception: $exception)';
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      requestId: map['requestId'] as int,
      method: map['method'] as String,
      body: map['body'],
      exception:
          map['exception'] == null ? null : WebPlatformException.fromMap(map['exception'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestId': requestId,
      'method': method,
      'body': body,
      'exception': exception?.toMap(),
    };
  }
}
