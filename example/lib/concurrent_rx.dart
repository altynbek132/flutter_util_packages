import 'package:rxdart/rxdart.dart';

Future<void> main() async {
  final res = await makePizza('sauceType');
  print('\n$res');
}

final sw = Stopwatch()..start();

Future<List<String>> makePizza(String sauceType) async {
  final sauce = makeSauce(2).asStream().shareReplay(maxSize: 1);
  Type Dough = List<String>;
  final dough = makeDough(3).asStream().shareReplay(maxSize: 1);
  final salt = makeSalt(1).asStream().shareReplay(maxSize: 1);
  final cheese = ForkJoinStream.list([sauce, dough])
      .asyncMap((values) => grateCheese(values[0] as String, 2))
      .shareReplay(maxSize: 1);
  ForkJoinStream.list([dough, sauce])
      .map((values) => (values[0] as List<String>).add(values[1] as String));
  (() async {
    (await dough).add(await sauce);
  })();
  (() async {
    (await dough).add(await cheese);
  })();
  (() async {
    (await dough).add(await salt);
  })();
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

Future<String> _grateCheese(String sauce, double seconds) async {
  print('grateCheese start ${sw.elapsed.inSeconds}');
  await delay(seconds);
  print('grateCheese end ${sw.elapsed.inSeconds}');
  return '$sauce-cheese';
}

Stream<String> grateCheese(String sauce, double seconds) async* {
  print('grateCheese start ${sw.elapsed.inSeconds}');
  await delay(seconds);
  print('grateCheese end ${sw.elapsed.inSeconds}');
  yield '$sauce-cheese';
}

Future<void> delay(double seconds) {
  return Future.delayed(Duration(milliseconds: (seconds * 1000).toInt()));
}

extension ListExtension<T> on List<T> {
  set newLast(T val) {
    add(val);
  }
}
