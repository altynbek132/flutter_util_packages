import 'package:async/async.dart';

Future<void> main() async {
  final a = CancelableOperation.fromFuture(op());
  await Future.delayed(const Duration(milliseconds: 300));
  a.cancel();
}

Future<void> op() async {
  for (var i = 0; i < 10; ++i) {
    await Future.delayed(const Duration(milliseconds: 100));
    print(i);
  }
}
