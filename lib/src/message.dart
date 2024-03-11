// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'exception.dart';

class Message {
  final int requestId;
  final String method;
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
}
