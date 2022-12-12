Future<void> main() async {
  final res = await makePizza('sauceType');
  print('\n$res');
}

final sw = Stopwatch()..start();

Future<List<String>> makePizza(String sauceType) async {
  final List<Future> futures = [];
  final sauce = futures.newLast = makeSauce(2);
  final dough = futures.newLast = makeDough(3);
  final salt = futures.newLast = makeSalt(1);
  final cheese = futures.newLast = (() async => grateCheese(await sauce, 2))();
  futures.newLast = (() async {
    (await dough).add(await sauce);
  })();
  futures.newLast = (() async {
    (await dough).add(await cheese);
  })();
  futures.newLast = (() async {
    (await dough).add(await salt);
  })();
  await Future.wait(futures);
  return dough;
}

Future<List<String>> makeDough(double seconds) async {
  print('makeDough start ${sw.elapsed.inSeconds}');
  await delay(seconds);
  print('makeDough end ${sw.elapsed.inSeconds}');
  return [];
}

Future<String> makeSauce(double seconds) async {
  print('makeSauce start ${sw.elapsed.inSeconds}');
  await delay(seconds);
  print('makeSauce end ${sw.elapsed.inSeconds}');
  return 'sauce';
}

Future<String> makeSalt(double seconds) async {
  print('makeSalt start ${sw.elapsed.inSeconds}');
  await delay(seconds);
  print('makeSalt end ${sw.elapsed.inSeconds}');
  return 'salt';
}

Future<String> grateCheese(String sauce, double seconds) async {
  print('grateCheese start ${sw.elapsed.inSeconds}');
  await delay(seconds);
  print('grateCheese end ${sw.elapsed.inSeconds}');
  return '$sauce-cheese';
}

Future<void> delay(double seconds) {
  return Future.delayed(Duration(milliseconds: (seconds * 1000).toInt()));
}

extension ListExtension<T> on List<T> {
  set newLast(T val) {
    add(val);
  }
}
