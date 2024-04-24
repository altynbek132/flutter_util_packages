import 'package:test/test.dart';
import 'package:worker_method_channel/src/exception.dart';

void main() {
  group('WebPlatformException', () {
    test('should create an instance with default values', () {
      final exception = WebPlatformException();

      expect(exception, isA<Exception>());
    });
    test('should create an instance with the provided values', () {
      final exception = WebPlatformException(
        code: 'error_code',
        message: 'error_message',
        exception: Exception('inner_exception'),
        stacktrace: StackTrace.current,
      );

      expect(exception.code, 'error_code');
      expect(exception.message, 'error_message');
      expect(exception.exception, isA<Exception>());
      expect(exception.exception.toString(), 'Exception: inner_exception');
      expect(exception.stacktrace, isA<StackTrace>());
    });

    test('should create an instance from JSON', () {
      final json = {
        'code': 'error_code',
        'message': 'error_message',
        'exception': 'inner_exception',
        'stacktrace': 'stack_trace',
      };

      final exception = WebPlatformException.fromJson(json);

      expect(exception.code, 'error_code');
      expect(exception.message, 'error_message');
      expect(exception.exception, 'inner_exception');
      expect(exception.stacktrace, isA<StackTrace>());
      expect(exception.stacktrace.toString().contains('stack_trace'), true);
    });

    test('should convert an instance to JSON', () {
      final json = {
        'code': 'error_code',
        'message': 'error_message',
        'exception': 'inner_exception',
        'stacktrace': 'stack_trace',
      };

      final exception = WebPlatformException.fromJson(json);

      expect(exception.toJson(), json);
    });
  });
}
