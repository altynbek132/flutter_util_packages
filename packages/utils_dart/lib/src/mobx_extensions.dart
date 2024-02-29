import 'dart:async';

import 'package:mobx/mobx.dart' hide Listenable;
import 'package:rxdart/rxdart.dart';

extension ObservableToStream<T> on Observable<T> {
  Stream<T> toStream() => _fromGetter(() => value);

  ObservableStream<T> toObsStream() => toStream().obs();
}

Stream<T> _fromGetter<T>(T Function() getter) {
  BehaviorSubject<T>? controller;
  ReactionDisposer? disposer;
  return controller = BehaviorSubject<T>(
    onListen: () => disposer = autorun((_) => controller!.add(getter())),
    onCancel: () => disposer?.call(),
  );
}
