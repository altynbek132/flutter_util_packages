import 'dart:async';

import 'package:disposing/disposing.dart';

Future<void> main() async {
  final streamDisp = Stream.periodic(Duration(milliseconds: 100))
      .listen((v) => {print('stream')})
      .asDisposable();
  final bag = DisposableBag();
  bag.add(streamDisp);

  await Future.delayed(const Duration(milliseconds: 1000));
  bag.dispose();
}
