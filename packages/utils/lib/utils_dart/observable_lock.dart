import 'dart:async';
import 'package:mobx/mobx.dart';
import 'package:synchronized/synchronized.dart';
import 'package:utils/utils_dart.dart';

class ObservableLock {
  final Lock _lock;
  late final obs = Observable(_lock);

  ObservableLock([Lock? lock]) : _lock = lock ?? Lock();

  Future<T> synchronized<T>(FutureOr<T> Function() computation, {Duration? timeout, String? label}) async {
    loggerGlobal.d('synchronized start: $label');
    runInAction(() {
      obs.reportManualChange();
    });

    try {
      return await _lock.synchronized(computation, timeout: timeout);
    } finally {
      runInAction(() {
        obs.reportManualChange();
      });
      loggerGlobal.d('synchronized end: $label');
    }
  }
}
