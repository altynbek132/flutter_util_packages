import 'dart:async';
import 'package:mobx/mobx.dart';
import 'package:synchronized/synchronized.dart';
import 'package:utils/utils_dart.dart';

class ObservableLock {
  final Lock _lock;
  late final obs = Observable(_lock);

  ObservableLock([Lock? lock]) : _lock = lock ?? Lock();

  Future<T> synchronized<T>(FutureOr<T> Function() computation, {Duration? timeout, String? label}) async {
    FutureOr<T> computation_() async {
      // report lock
      runInAction(() {
        obs.reportManualChange();
      });
      return await computation();
    }

    try {
      return await _lock.synchronized(computation_, timeout: timeout);
    } finally {
      // report unlock
      runInAction(() {
        obs.reportManualChange();
      });
    }
  }
}
