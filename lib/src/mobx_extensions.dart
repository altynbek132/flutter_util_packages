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

  T disposeWithVm(MobxStoreBase vm) {
    vm.addDisposer(dispose);
    return value;
  }
}

extension ObservableToStream<T> on Observable<T> {
  Stream<T> toStream() => MobxUtils.fromGetter(() => value);

  ObservableStream<T> toObsStream() => toStream().obs();
}
