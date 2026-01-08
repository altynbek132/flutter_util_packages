import 'package:mobx/mobx.dart';
import 'package:test/test.dart';
import 'package:utils/utils_dart.dart';

Future<void> main() async {
  test('should ', () async {
    final screenLoadingLock = ObservableLock();
    final c = 0.obs();
    bool isLoading() => screenLoadingLock.obs.value.locked;
    var count = 0;
    autorun(
      (_) {
        // print('value: ${c.value}');
        print('count: ${++count}');
        print('isLoading: ${isLoading()}');
      },
    );
    autorun(
      (_) {
        print('value: ${c.value}');
      },
    );
    await Future.delayed(const Duration(milliseconds: 100));
    print('START---------------');

    try {
      await screenLoadingLock.synchronized(() async {
        runInAction(() {
          c.value++;
        });
        await Future.delayed(const Duration(milliseconds: 100));
        runInAction(() {
          c.value++;
        });
      }, label: 'first');
      print('---------------');

      await screenLoadingLock.synchronized(() async {
        runInAction(() {
          c.value++;
        });
        await Future.delayed(const Duration(milliseconds: 100));
        runInAction(() {
          c.value++;
        });
      }, label: 'second');
      print('---------------');

      await screenLoadingLock.synchronized(() async {
        runInAction(() {
          c.value++;
        });
        await Future.delayed(const Duration(milliseconds: 100));
        runInAction(() {
          c.value++;
        });
        throw Exception('asdf');
      });
    } catch (e) {}
  });
}
