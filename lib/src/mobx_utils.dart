import 'dart:async';

import 'package:flutter/widgets.dart' hide Action;
import 'package:mobx/mobx.dart' hide Listenable;
import 'package:rxdart/rxdart.dart';

import 'mobx_extensions.dart';

class MobxUtils {
  static Stream<T> fromGetter<T>(T Function() getter) {
    BehaviorSubject<T>? controller;
    ReactionDisposer? disposer;
    return controller = BehaviorSubject<T>(
      onListen: () => disposer = autorun((_) => controller!.add(getter())),
      onCancel: () => disposer?.call(),
    );
  }

  static WithDisposer<Observable<T>> fromListenable<T extends Listenable>(
      T listenable) {
    final obs = Observable<T>(listenable);
    final cb = Action(() => obs
      ..value = listenable
      ..reportManualChange());
    listenable.addListener(cb);
    return WithDisposer(
      obs,
      () => listenable.removeListener(cb),
    );
  }

  static WithDisposer<Observable<T>> fromVn<T>(
    ValueNotifier<T> vn, {
    bool? dispose,
  }) {
    final obs = Observable<T>(vn.value);
    final cb = Action(() => obs
      ..value = vn.value
      ..reportManualChange());
    vn.addListener(cb);
    return WithDisposer(
      obs,
      () {
        vn.removeListener(cb);
        if (dispose ?? false) {
          vn.dispose();
        }
      },
    );
  }

  static WithDisposer<Observable<T>> fromVnWrap<T extends ValueNotifier>(
    T vn, {
    bool? dispose,
  }) {
    final obs = Observable<T>(vn);
    final cb = Action(() => obs
      ..value = vn
      ..reportManualChange());
    vn.addListener(cb);
    return WithDisposer(
      obs,
      () {
        vn.removeListener(cb);
        if (dispose ?? false) {
          vn.dispose();
        }
      },
    );
  }

  MobxUtils._();
}
