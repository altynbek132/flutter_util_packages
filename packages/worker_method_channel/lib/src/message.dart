// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'exception.dart';

class Message {
  final int requestId;
  final String method;
  // primitive types or List, Map
  final Object? body;
  final WebPlatformException? exception;

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
