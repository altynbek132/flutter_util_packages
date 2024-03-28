import 'dart:async';

import 'package:disposing/disposing_dart.dart';
import 'package:disposing/disposing_flutter.dart';
import 'package:flutter/foundation.dart';
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
  static SyncValueDisposable<Observable<T>> fromListenable<T extends Listenable>(T listenable) {
    final obs = Observable<T>(listenable);
    final disp = listenable.addDisposableListener(
      Action(() {
        obs.value = listenable;
        if (obs.hasObservers) {
          obs.reportManualChange();
        }
      }).call,
    );
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
    final disp = vn.addDisposableListener(
      Action(() {
        obs.value = vn.value;
        if (obs.hasObservers) {
          obs.reportManualChange();
        }
      }).call,
    );
    return SyncValueDisposable(obs, () {
      disp.dispose();
      if (dispose ?? true) {
        vn.dispose();
      }
    });
  }

  /// use it if you need [ValueListenable]'s values as [Observable]
  ///
  /// usage:
  /// late final vnValueObs = MobxUtils.fromVnValue(VN)
  ///     .handleDispose((disposer) => addDisposer(disposer));
  static SyncValueDisposable<Observable<T>> fromVlValue<T>(
    ValueListenable<T> vl,
  ) {
    final obs = Observable<T>(vl.value);
    final disp = vl.addDisposableListener(
      Action(() {
        obs.value = vl.value;
        if (obs.hasObservers) {
          obs.reportManualChange();
        }
      }).call,
    );
    return SyncValueDisposable(obs, () {
      disp.dispose();
    });
  }

  /// you can wrap controllers which extend [ChangeNotifier] as
  /// [TextEditingController] and etc so that you can use notifier's value in
  /// reactions
  ///
  /// usage:
  /// late final textController = MobxUtils.fromCN(textControllerRaw)
  ///   ..disposeOn(this);
  static SyncValueDisposable<Observable<T>> fromCN<T extends ChangeNotifier>(
    T cn, {
    bool? dispose,
  }) {
    final obs = Observable<T>(cn);
    final disp = cn.addDisposableListener(
      Action(() {
        obs.value = cn;
        if (obs.hasObservers) {
          obs.reportManualChange();
        }
      }).call,
    );
    return SyncValueDisposable(obs, () {
      disp.dispose();
      if (dispose ?? true) {
        cn.dispose();
      }
    });
  }

  MobxUtils._();
}

extension ListenableObsExtension on Listenable {
  SyncValueDisposable<Observable<T>> obs<T extends Listenable>() {
    return MobxUtils.fromListenable(this as T);
  }
}

extension ValueNotifierObsExtension<T> on ValueNotifier<T> {
  SyncValueDisposable<Observable<T>> obs([bool? dispose]) {
    return MobxUtils.fromVnValue(this, dispose: dispose);
  }
}

extension ValueListenableObsExtension<T> on ValueListenable<T> {
  SyncValueDisposable<Observable<T>> obs() {
    return MobxUtils.fromVlValue(this);
  }
}

extension ChangeNotifierObsExtension on ChangeNotifier {
  SyncValueDisposable<Observable<T>> obs<T extends ChangeNotifier>([bool? dispose]) {
    return MobxUtils.fromCN(this as T, dispose: dispose);
  }
}
