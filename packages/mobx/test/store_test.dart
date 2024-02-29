import 'package:mobx/mobx.dart';
import 'package:test/test.dart';

class TestStore with Store {}

final customContext = ReactiveContext();

class CustomStore with Store {
  @override
  ReactiveContext get reactiveContext => customContext;
}

void main() {
  group('Store', () {
    test('can get context', () {
      final store = TestStore();
      expect(store.reactiveContext, mainContext);
    });

    test('Store with custom context', () {
      final store = CustomStore();
      expect(store.reactiveContext, customContext);
    });
  });
}
