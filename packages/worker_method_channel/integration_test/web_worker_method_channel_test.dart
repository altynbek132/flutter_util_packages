@TestOn('chrome')
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:utils_dart/utils_dart.dart';
import 'package:worker_method_channel/worker_method_channel.dart';
import 'responses.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('should not finish', (widgetTester) async {
    // return;
    print('start');
    await widgetTester.runAsync(() async {
      () async {
        await Future.delayed(const Duration(milliseconds: 100));
        () async {
          await Future.delayed(const Duration(milliseconds: 1000));
          throw 1;
        }();
      }();
      print("🚀~_demo_flutter_test.dart:12~");
      await Future.delayed(const Duration(milliseconds: 2000));
      print("🚀~_demo_flutter_test.dart:12~2");
    });
    print('finish');
  });
  testWidgets('should respond', (widgetTester) async {
    // return;
    await widgetTester.runAsync(() async {
      //Arrange - Setup facts, Put Expected outputs or Initilize
      final channel = WebWorkerMethodChannel(scriptURL: './integration_test/worker_js.dart.js');

      //Act - Call the function that is to be tested
      await Future.wait(Responses.workerResponses.entries.map((entry) async {
        final key = entry.key;
        final value = entry.value;

        await value(null).thenSideEffect((expectedResponse) async {
          final actualResponse = await channel.invokeMethod(key);
          expect(actualResponse, expectedResponse);
        }).onErrorNullable((error, stackTrace) async {
          final responseFuture = channel.invokeMethod(key);
          expect(await responseFuture, throwsA(isA<WebPlatformException>()));
          expect(await responseFuture,
              throwsA(predicate((WebPlatformException e) => e.exception.toString() == error.toString())));
        });
      }));

      //Assert - Compare the actual result and expected result

      await channel.disposeAsync();
      await Future.delayed(const Duration(milliseconds: 100000000));
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
}
