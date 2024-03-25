import 'dart:async';
import 'package:test/test.dart';

Future<void> main() async {
  print('start');
  test('should await delay', () async {
    //Arrange - Setup facts, Put Expected outputs or Initilize

    //Act - Call the function that is to be tested
    await Future.delayed(const Duration(milliseconds: 1000));

    //Assert - Compare the actual result and expected result
    expect(1, 1);
    print('success');
  });
  test('should complete', () async {
    //Arrange - Setup facts, Put Expected outputs or Initilize
    final completer = Completer<int>();
    () async {
      await Future.delayed(const Duration(milliseconds: 1000));
      completer.complete(1);
    }();

    //Act - Call the function that is to be tested
    final res = await completer.future;

    //Assert - Compare the actual result and expected result
    expect(res, 1);
    print('success');
  });
}
