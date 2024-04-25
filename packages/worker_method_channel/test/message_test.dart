import 'package:test/test.dart';
import 'package:worker_method_channel/src/exception.dart';
import 'package:worker_method_channel/src/exception_with_type.dart';
import 'package:worker_method_channel/src/message.dart';

void main() {
  group('Message', () {
    test('should create a message with the provided values', () {
      final message = Message(
        requestId: 1,
        method: 'testMethod',
        body: 'testBody',
        exception: null,
      );

      expect(message.requestId, 1);
      expect(message.method, 'testMethod');
      expect(message.body, 'testBody');
      expect(message.exception, isNull);
    });

    test('should create a message from JSON', () {
      final json = {
        'requestId': 1,
        'method': 'testMethod',
        'body': 'testBody',
        'exception': null,
      };

      final message = Message.fromJson(json);

      expect(message.requestId, 1);
      expect(message.method, 'testMethod');
      expect(message.body, 'testBody');
      expect(message.exception, isNull);
    });
    test('should convert an instance to JSON', () {
      final json = {
        'requestId': 1,
        'method': 'testMethod',
        'body': 'testBody',
        'exception': null,
      };

      final message = Message.fromJson(json);

      expect(message.toJson(), json);
    });
    test('should convert an instance to JSON 2', () {
      final json = Message(
        requestId: 1,
        method: 'testMethod',
        body: 'testBody',
        exception: WebPlatformException(
          code: 'error_code',
          message: 'error_message',
          innerExceptionWithType: ExceptionWithType(exception: Exception('inner_exception'), type: 'Exception'),
          stacktrace: StackTrace.current,
        ),
      ).toJson();

      final message = Message.fromJson(json);

      expect(message.toJson(), json);
    });
  });
}
