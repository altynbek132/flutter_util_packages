import 'dart:async';

import 'package:disposing/disposing.dart';
import 'package:disposing_flutter/disposing_flutter.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:mobx/mobx.dart' hide Listenable;
import 'package:rxdart/rxdart.dart';

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
  static SyncValueDisposable<Observable<T>>
      fromListenable<T extends Listenable>(T listenable) {
    final obs = Observable<T>(listenable);
    final disp = listenable.addDisposableListener(Action(() => obs
      ..value = listenable
      ..reportManualChange()));
    return SyncValueDisposable(obs, () => disp.dispose());
  }

  /// use it if you need [ValueNotifier]'s values as [Observable]
  ///
  /// usage:
  /// late final vnValueObs = MobxUtils.fromVnValue(VN)
  ///     .handleDispose((disposer) => addDisposer(disposer));
  static SyncValueDisposable<Observable<T>> fromVnValue<T>(
    ValueNotifier<T> vn, {
    bool? dispose,
  }) {
    final obs = Observable<T>(vn.value);
    final disp = vn.addDisposableListener(Action(() => obs
      ..value = vn.value
      ..reportManualChange()));
    return SyncValueDisposable(obs, () {
      disp.dispose();
      if (dispose ?? false) {
        vn.dispose();
      }
    });
  }

  /// you can wrap controllers which extend [ChangeNotifier] as
  /// [TextEditingController] and etc so that you can use notifier's value in
  /// reactions
  ///
  /// usage:
  /// late final textController = MobxUtils.fromCn(textControllerRaw)
  ///     .handleDispose((disposer) => addDisposer(disposer));
  static SyncValueDisposable<Observable<T>> fromCN<T extends ChangeNotifier>(
    T cn, {
    bool? dispose,
  }) {
    final obs = Observable<T>(cn);
    final disp = cn.addDisposableListener(Action(() => obs
      ..value = cn
      ..reportManualChange()));
    return SyncValueDisposable(obs, () {
      disp.dispose();
      if (dispose ?? false) {
        cn.dispose();
      }
    });
  }

  MobxUtils._();
}
