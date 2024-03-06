import 'dart:async';

import 'package:disposing/disposing.dart';
import 'package:worker_method_channel/src/worker.dart';

typedef MethodCallHandler = FutureOr<Object?> Function(Object? body);

abstract class WebWorkerMethodChannel with DisposableBag {
  factory WebWorkerMethodChannel({required WorkerBase worker}) =>
      creator(worker);

  SyncDisposable setMethodCallHandler(String method, MethodCallHandler handler);

  Future<Object?> invokeMethod(String method, [Object? body]);
}
