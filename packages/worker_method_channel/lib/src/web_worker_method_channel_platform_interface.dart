import 'dart:async';

import 'package:disposing/disposing.dart';

import 'worker_base.dart';

import 'web_worker_method_channel_web.dart'
    if (dart.library.js_interop) 'web_worker_method_channel_stub.dart';

typedef MethodCallHandler = FutureOr<Object?> Function(Object? body);

abstract class WebWorkerMethodChannel with DisposableBag {
  factory WebWorkerMethodChannel({required WorkerBase worker}) =>
      getWebWorkerMethodChannel(worker: worker);

  SyncDisposable setMethodCallHandler(String method, MethodCallHandler handler);

  Future<Object?> invokeMethod(String method, [Object? body]);
}
