import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils.dart';

extension StreamExtension<T> on Stream<T> {
  Stream<T> startsWithFirst<V>(Stream<V> other) => other.take(1).switchMap((value) => this);

  Stream<T> toggle<V>(Stream<V> toggleStream, {bool? isActiveInitially}) {
    var active = isActiveInitially ?? true;
    // todo Altynbek: check if asobs listen?
    final t = toggleStream.asObservable();
    return this;
    // return skipWhile((element) => t.value ?? true);
  }

  Stream<T> log([String? name]) {
    final prefix = () {
      if (name == null || name.isEmpty) return '';
      return '${name}: ';
    }();
    return this
            .doOnListen(() => print('${prefix}listen'))
            .doOnCancel(() => print('${prefix}cancel'))
            .doOnData((event) => print('${prefix}event: ${event}'))
        //
        ;
  }

  Stream<T> noop() {
    return this;
  }
}

// toggle
Future<void> main234ecsd() async {
  final obs = 0.obs();
  Stream.periodic(Duration(milliseconds: 100)).listen((event) => Action(() => obs.value++)());
  // todo Altynbek: broadcast auto
  final s = MobxUtils.observableToObsStream(obs)
      .log()
      .toggle(Stream.periodic(Duration(milliseconds: 500)))
      .asBroadcastStream();
  s.listen(print);
}

Future<void> main() async {
  obsStream();
  // period();
}

Future<void> obsStream() async {
  final obs = 0.obs();
  // todo Altynbek: wtf
  final s = MobxUtils.observableToStream(obs).log('stream log');
  // final s = MobxUtils.observableToStream(obs);
  final p = Stream.periodic(Duration(milliseconds: 100)).listen((event) => Action(() => obs.value++)());
  for (var i = 0; i < 3; ++i) {
    final sub = s.listen(print);
    await Future.delayed(Duration(milliseconds: 500));
    sub.cancel();
    await Future.delayed(Duration(milliseconds: 500));
  }
  p.cancel();
}

Future<void> period() async {
  final c = BehaviorSubject<int>();
  final s = c.stream.log();
  final p =
      Stream.periodic(Duration(milliseconds: 100), (computationCount) => c.add(computationCount + 1)).listen(null);
  for (var i = 0; i < 3; ++i) {
    final sub = s.listen(print);
    await Future.delayed(Duration(milliseconds: 500));
    sub.cancel();
    await Future.delayed(Duration(milliseconds: 500));
  }
  p.cancel();
}
