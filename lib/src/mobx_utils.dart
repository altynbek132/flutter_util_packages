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

  /// use it if you need to wrap [Listenable] to [Observable]
  ///
  /// usage:
  /// late final listenableObs = MobxUtils.fromListenable(listenable)
  ///     .handleDispose((disposer) => addDisposer(disposer));
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

  /// use it if you need [ValueNotifier]'s values as [Observable]
  ///
  /// usage:
  /// late final vnValueObs = MobxUtils.fromVnValue(VN)
  ///     .handleDispose((disposer) => addDisposer(disposer));
  static WithDisposer<Observable<T>> fromVnValue<T>(
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

  /// you can wrap controllers which extend [ChangeNotifier] as
  /// [TextEditingController] and etc so that you can use notifier's value in
  /// reactions
  ///
  /// usage:
  /// late final textController = MobxUtils.fromCn(textControllerRaw)
  ///     .handleDispose((disposer) => addDisposer(disposer));
  static WithDisposer<Observable<T>> fromCN<T extends ChangeNotifier>(
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
