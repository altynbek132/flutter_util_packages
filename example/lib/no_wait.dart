import 'package:tuple/tuple.dart';
import 'package:utils/utils.dart';

Future<void> main() async {
  final a = f();
  final b = f();
  final c = f();
  final ab = (() async => await a + await b)();
  final abNoWait = noWait2(Tuple2(a, b), (tuple) => tuple.item1 + tuple.item2);
}

Future<int> f() async {
  await Future.delayed(const Duration(milliseconds: 1000));
  return 0;
}

Future<R> noWait2<R, T1, T2>(
  Tuple2<Future<T1>, Future<T2>> futures,
  R Function(Tuple2<T1, T2> values) cb,
) async {
  final values = await futureWait(futures.toList());
  return cb(Tuple2(values[0], values[1]));
}
