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
}
