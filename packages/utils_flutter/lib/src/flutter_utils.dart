import 'dart:async';

import 'package:disposing/disposing_dart.dart';
import 'package:disposing/disposing_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

AsyncValueDisposable<Stream<T>> listenableToStream<S extends Listenable, T>(
  S listenable,
  T Function(S listenable) select,
) {
  final sc = StreamController<T>();
  final disposer = listenable.addDisposableListener(() => sc.add(select(listenable)));
  return AsyncValueDisposable(sc.stream, () async {
    disposer.dispose();
    await sc.close();
  });
}

Future<void> postFrame() async {
  final completer = Completer<void>.sync();
  SchedulerBinding.instance.addPostFrameCallback((timeStamp) => completer.complete());
  await completer.future;
}

extension StreamExtension<T> on Stream<T> {
  ValueNotifier<V> toVN<V>(V value) {
    final vn = VN(value);
    final sub = listen((_) => vn.notifyListeners());
    vn.addOnDispose(() => sub.cancel());
    return vn;
  }
}

class VN<T> extends ValueNotifier<T> {
  VN(super.value);

  final disposers = <Function()>[];

  void addOnDispose(Function() fn) {
    disposers.add(fn);
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  @override
  void dispose() {
    for (final disposer in disposers) {
      disposer();
    }
    super.dispose();
  }
}

class CN extends ChangeNotifier {
  final disposers = <Function()>[];

  void addOnDispose(Function() fn) {
    disposers.add(fn);
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  @override
  void dispose() {
    for (final disposer in disposers) {
      disposer();
    }
    super.dispose();
  }
}
