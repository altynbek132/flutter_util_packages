import 'package:test/test.dart';
import 'package:worker_method_channel/src/exception.dart';
import 'package:worker_method_channel/src/exception_with_type.dart';

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
        innerExceptionWithType: ExceptionWithType(exception: Exception('inner_exception'), type: 'Exception'),
        stacktrace: StackTrace.current,
      );

      expect(exception.code, 'error_code');
      expect(exception.message, 'error_message');
      expect(exception.innerExceptionWithType, isA<ExceptionWithType>());
      expect(exception.innerExceptionWithType?.exception, isA<Exception>());
      expect(exception.innerExceptionWithType?.exception.toString(), 'Exception: inner_exception');
      expect(exception.stacktrace, isA<StackTrace>());
    });

    test('should create an instance from JSON', () {
      final json = {
        'code': 'error_code',
        'message': 'error_message',
        'innerExceptionWithType': {'exception': 'inner_exception', 'type': 'String'},
        'stacktrace': 'stack_trace',
      };

      final exception = WebPlatformException.fromJson(json);

      expect(exception.code, 'error_code');
      expect(exception.message, 'error_message');
      expect(exception.innerExceptionWithType?.exception, 'inner_exception');
      expect(exception.stacktrace, isA<StackTrace>());
      expect(exception.stacktrace.toString().contains('stack_trace'), true);
    });

    test('should convert an instance to JSON', () {
      final json = {
        'code': 'error_code',
        'message': 'error_message',
        'innerExceptionWithType': {'exception': 'inner_exception', 'type': 'String'},
        'stacktrace': 'stack_trace',
      };

      final exception = WebPlatformException.fromJson(json);

      expect(exception.toJson(), json);
    });

    test('should be equal to another instance with the same values', () {
      final exception1 = WebPlatformException(
        code: 'error_code',
        message: 'error_message',
        innerExceptionWithType: ExceptionWithType(exception: Exception('inner_exception'), type: 'Exception'),
        stacktrace: StackTrace.fromString('stackTraceString'),
      );

      final exception2 = WebPlatformException(
        code: 'error_code',
        message: 'error_message',
        innerExceptionWithType: ExceptionWithType(exception: Exception('inner_exception'), type: 'Exception'),
        stacktrace: StackTrace.fromString('stackTraceString'),
      );

      expect(exception1.code, equals(exception2.code));
      expect(exception1.message, equals(exception2.message));

      expect(exception1.innerExceptionWithType?.exception, isNot(equals(exception2.innerExceptionWithType?.exception)));
      expect(exception1.stacktrace, isNot(equals(exception2.stacktrace)));
    });
  });
}
