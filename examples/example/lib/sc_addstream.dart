import 'dart:async';
import 'package:rxdart/rxdart.dart';

extension StreamControllerExtension<T> on StreamController<T> {
  Future<void> addStreamNonBlocking(Stream<T> s) async {
    late StreamSubscription<T> ss;
    final completer = Completer<void>();
    ss = s.listen(add, onError: addError, onDone: () {
      ss.cancel();
      completer.complete();
    });

    final stream = this.stream;
    stream.doOnCancel(() {
      print('doOnCancel');
      return ss.cancel();
    });
    stream.doOnPause(() {
      print('doOnPause');
      ss.pause();
    });
    stream.doOnResume(() {
      print('doOnResume');
      ss.resume();
    });
    return completer.future;
  }
}

Future<void> main() async {
  final sc = StreamController<int>();
  final ss = sc.stream.listen(print);

  sc.addStreamNonBlocking(Stream.periodic(
    Duration(milliseconds: 1000),
    (computationCount) => computationCount,
  ));

  () async {
    // await Future.delayed(const Duration(milliseconds: 2000));
    // ss.pause();
    // await Future.delayed(const Duration(milliseconds: 2000));
    // ss.resume();
    // await Future.delayed(const Duration(milliseconds: 2000));
    // ss.cancel();
  }();

  for (var i = 0; i < 10; ++i) {
    await Future.delayed(const Duration(milliseconds: 1500));
    sc.add(123);
  }
}
