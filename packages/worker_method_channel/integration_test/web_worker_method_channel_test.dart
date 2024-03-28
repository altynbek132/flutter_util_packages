@TestOn('chrome')
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:js_import/js_import.dart';
import 'package:l/l.dart';
import 'package:worker_method_channel/worker_method_channel.dart';
import 'responses.dart';
import 'package:utils/utils_dart.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('should respond', (widgetTester) async {
    await widgetTester.runAsync(() async {
      loggerGlobal.i("test started");
      //Arrange - Setup facts, Put Expected outputs or Initilize
      final channel = WebWorkerMethodChannel(scriptURL: './integration_test/worker_js.dart.js');

      //Act - Call the function that is to be tested
      await Future.wait(
        Responses.workerResponses.entries.map((entry) async {
          final method = entry.key;
          final response = entry.value;
          print("🚀~web_worker_method_channel_test.dart:23~");

          final requestBody = 'request';
          await response(requestBody).thenSideEffect((expectedResponse) async {
            print("🚀~web_worker_method_channel_test.dart:28~");
            final actualResponse = await channel.invokeMethod(method, requestBody);
            expect(actualResponse, expectedResponse);
            loggerGlobal.i("method: ${method} complete");
            loggerGlobal.d("🚀~web_worker_method_channel_test.dart:27~awaitvalue~actualResponse, expectedResponse: ${(
              actualResponse,
              expectedResponse
            )}");
          }).onErrorNull(
            cb: (error, stackTrace) async {
              print("🚀~web_worker_method_channel_test.dart:36~");
              final responseFuture = channel.invokeMethod(method, requestBody);
              expectLater(responseFuture, throwsA(isA<WebPlatformException>()));
              expectLater(
                responseFuture,
                throwsA(predicate((WebPlatformException e) => e.exception.toString() == error.toString())),
              );
              await responseFuture.onErrorNull(cb: (error, stackTrace) {
                loggerGlobal.i("method: ${method} error: ${error}");
              });
              loggerGlobal.i("method with exception: ${method} complete");
            },
          );
        }),
      );

      await channel.disposeAsync();
      await Future.delayed(const Duration(hours: 99999));
    });
  });

  testWidgets('should terminate', (widgetTester) async {
    return;
    await widgetTester.runAsync(() async {
      () async {
        //Arrange - Setup facts, Put Expected outputs or Initilize
        final channel = WebWorkerMethodChannel(scriptURL: './integration_test/worker_js.dart.js');
        await channel.disposeAsync();

        //Act - Call the function that is to be tested
        //Assert - Compare the actual result and expected result
        expect(channel.invokeMethod('echo'), doesNotComplete);
      }();
    });
  });

  _doNotTerminate();
}

void _doNotTerminate() {
  testWidgets('do not terminate', (widgetTester) async {
    await widgetTester.runAsync(() => Future.delayed(const Duration(milliseconds: 999999999999)));
  });
}
