import 'package:test/test.dart';
import 'package:utils/utils_dart.dart';

void main() {
  group('onErrorSync', () {
    test('should execute the callback function and handle synchronous errors', () {
      // Define the callback function
      int callback() {
        throw Exception('Something went wrong');
      }

      // Define the error handler function
      int errorHandler(Exception error, StackTrace stackTrace) {
        // Handle the error
        return -1;
      }

      // Call the onErrorSync function
      final int result = onErrorSync<int, Exception>(callback, errorHandler);

      // Verify the result
      expect(result, -1);
    });

    test('should not handle errors that do not match the specified type', () {
      // Define the callback function
      int callback() {
        throw ArgumentError('Invalid argument');
      }

      // Define the error handler function
      int errorHandler(StateError error, StackTrace stackTrace) {
        // Handle the error
        return -1;
      }

      // Call the onErrorSync function
      void testFunction() {
        onErrorSync<int, StateError>(callback, errorHandler);
      }

      // Verify that the error is rethrown
      expect(testFunction, throwsA(isA<ArgumentError>()));
    });

    test('should handle errors that match the specified type and test function', () {
      // Define the callback function
      int callback() {
        throw StateError('Invalid state');
      }

      // Define the error handler function
      int errorHandler(StateError error, StackTrace stackTrace) {
        // Handle the error
        return -1;
      }

      // Call the onErrorSync function
      final int result = onErrorSync<int, StateError>(
        callback,
        errorHandler,
        test: (error) => error.message == 'Invalid state',
      );

      // Verify the result
      expect(result, -1);
    });
  });

  group('tryCatch', () {
    group('async', () {
      test('async: should execute the callback function and handle successful completion', () async {
        // Define the callback function
        Future<int> callback() async {
          return 42;
        }

        var called = false;
        // Define the success handler function
        Future<void> successHandler(int value) async {
          // Handle the success
          expect(value, 42);
          called = true;
        }

        // Call the tryCatch function
        await tryCatchAsync<int>(
          callback,
          onSuccess: successHandler,
        );
        expect(called, true);
      });

      test('async: should execute the callback function and handle errors', () async {
        // Define the callback function
        Future<int> callback() async {
          throw Exception('Something went wrong');
        }

        var called = false;

        // Define the error handler function
        Future<void> errorHandler(Object error, StackTrace stackTrace) async {
          // Handle the error
          expect(error, isA<Exception>());
          expect((error as Exception).toString().contains('Something went wrong'), true);
          called = true;
        }

        // Call the tryCatch function
        await tryCatchAsync<int>(
          callback,
          onError: errorHandler,
        );
        expect(called, true);
      });
    });
    group('async', () {
      test('sync: should execute the callback function and handle successful completion', () async {
        // Define the callback function
        int callback() {
          return 42;
        }

        var called = false;
        // Define the success handler function
        void successHandler(int value) {
          // Handle the success
          expect(value, 42);
          called = true;
        }

        // Call the tryCatch function
        tryCatchSync<int>(
          callback,
          onSuccess: successHandler,
        );
        expect(called, true);
      });

      test('sync: should execute the callback function and handle errors', () async {
        // Define the callback function
        int callback() {
          throw Exception('Something went wrong');
        }

        var called = false;

        // Define the error handler function
        void errorHandler(Object error, StackTrace stackTrace) {
          // Handle the error
          expect(error, isA<Exception>());
          expect((error as Exception).toString().contains('Something went wrong'), true);
          called = true;
        }

        // Call the tryCatch function
        tryCatchSync<int>(
          callback,
          onError: errorHandler,
        );
        expect(called, true);
      });
    });
  });
}
