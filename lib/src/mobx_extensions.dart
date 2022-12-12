import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart' hide Listenable;
import 'package:utils/utils.dart';

class WithDisposer<T> implements Disposable {
  final T value;
  final FutureOr Function()? disposer;

  const WithDisposer(this.value, [this.disposer]);

  @override
  Future<void> dispose() async {
    await disposer?.call();
  }

  void attachToVm(MobxStoreBase vm) {
    if (![disposer].contains(null)) {
      return;
    }
    vm.addDisposer(disposer!);
  }
}

extension ObservableToStream<T> on Observable<T> {
  Stream<T> toStream() => MobxUtils.fromGetter(() => value);

  ObservableStream<T> toObsStream() => toStream().obs();
}

extension ValueNotifierExtension<T> on ValueNotifier<T> {
  WithDisposer<Observable<T>> obsValue({bool? dispose}) {
    final obs = Observable<T>(value);
    final cb = Action(() => obs
      ..value = value
      ..manualReportChange());
    addListener(cb);
    return WithDisposer(
      obs,
      () {
        removeListener(cb);
        if (dispose ?? false) {
          this.dispose();
        }
      },
    );
  }

  WithDisposer<Observable<ValueNotifier<T>>> obsWrap({bool? dispose}) {
    final obs = Observable<ValueNotifier<T>>(this);
    final cb = Action(() => obs
      ..value = this
      ..manualReportChange());
    addListener(cb);
    return WithDisposer(
      obs,
      () {
        removeListener(cb);
        if (dispose ?? false) {
          this.dispose();
        }
      },
    );
  }
}
