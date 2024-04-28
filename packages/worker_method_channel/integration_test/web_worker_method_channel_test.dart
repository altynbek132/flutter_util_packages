@TestOn('chrome')
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:utils/utils_dart.dart';
import 'package:utils/utils_dart/utils_dart.dart';
import 'package:worker_method_channel/worker_method_channel.dart';

import 'error_serializer_registry.dart';
import 'responses.dart';

final logger = loggerGlobal;

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  /// Test case to verify that the method channel responds in sequence.
  testWidgets('should respond in sequence', (widgetTester) async {
    await widgetTester.runAsync(() async {
      await _testResponses(false);
    });
  });

  /// Test case to verify that the method responds in parallel.
  testWidgets('should respond in parallel', (widgetTester) async {
    await widgetTester.runAsync(() async {
      await _testResponses(true);
    });
  });

  testWidgets('should terminate', (widgetTester) async {
    await widgetTester.runAsync(() async {
      () async {
        final channel = WebWorkerMethodChannel(
          scriptURL: './integration_test/worker_js.dart.js',
          serializerRegistry: serializerRegistry,
        );
        await channel.disposeAsync();

        await expectLater(
          channel.invokeMethod('echo').timeout(const Duration(milliseconds: 100)),
          throwsA(isA<TimeoutException>()),
        );
      }();
    });
  });

  // _manualTerminateTests();
}

/// Tests the responses of the worker method channel.
///
/// The [parallel] parameter determines whether the responses should be handled in parallel or sequentially.
/// By default, the responses are handled in parallel.
///
/// This method creates a [WebWorkerMethodChannel] with the specified script URL and then handles the worker responses.
/// If [parallel] is true, the responses are handled concurrently using [Future.wait].
/// If [parallel] is false, the responses are handled sequentially using a for loop.
///
/// After handling the responses, the method disposes of the channel.
Future<void> _testResponses([bool parallel = true]) async {
  loggerGlobal.i("test started");
  final channel =
      WebWorkerMethodChannel(scriptURL: './integration_test/worker_js.dart.js', serializerRegistry: serializerRegistry);

  if (parallel) {
    await Future.wait(
      Responses.responseHandlers.map((handler) async {
        await _testResponse(handler, channel);
      }),
    );
  } else {
    for (final handler in Responses.responseHandlers) {
      await _testResponse(handler, channel);
      logger.d("---------");
    }
  }

  await channel.disposeAsync();
}

/// Tests the response of a web worker method channel.
///
/// This function takes a [MapEntry] containing the method name and a callback
/// function that provides the response for that method. It also takes a
/// [WebWorkerMethodChannel] instance representing the communication channel
/// with the web worker.
///
/// The function sends a request to the web worker using the specified method
/// and compares the response with the expected response provided by the
/// callback function. If the response matches the expected response, the test
/// passes. If an exception is thrown during the request, the function verifies
/// that the exception matches the expected exception.
Future<void> _testResponse(
  ResponseHandler handler,
  WebWorkerMethodChannel channel,
) async {
  await tryCatchAsync(
    () async => await handler.response(handler.requestBody),
    onSuccess: (responseOriginal) async {
      final responseByWorker = await channel.invokeMethod(handler.methodName, handler.requestBody);

      expect(handler.responseChecker(responseOriginal, responseByWorker), true);
      if (handler.expectEqualResponse) {
        expect(responseOriginal, responseByWorker);
      }

      loggerGlobal.i("method: ${handler.methodName} complete");
    },
    onError: (expectedError, stackTrace) async {
      final responseFuture = channel.invokeMethod(handler.methodName, handler.requestBody);
      await expectLater(responseFuture, throwsA(isA<WebPlatformException>()));
      await responseFuture.onErrorNull(
        cb: (e, st) {
          if (handler.expectEqualException) {
            expect((e as WebPlatformException).innerExceptionWithType?.exception, expectedError);
          }
          expect(handler.exceptionChecker?.call(e as WebPlatformException), true);
        },
      );

      loggerGlobal.i("method with exception: ${handler.methodName} complete");
    },
  );
}

/// ! WARNING
/// This method is used to prevent the tests from terminating.
// ignore: unused_element
void _manualTerminateTests() {
  testWidgets('do not terminate', (widgetTester) async {
    var terminate = false;
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () {
                terminate = true;
              },
              child: const Text('terminate test', style: TextStyle(fontSize: 24)),
            ),
          ),
        ),
      ),
    );
    await widgetTester.runAsync(() async {
      while (true) {
        await Future.delayed(const Duration(milliseconds: 100));
        if (terminate) {
          break;
        }
      }
    });
  });
}
