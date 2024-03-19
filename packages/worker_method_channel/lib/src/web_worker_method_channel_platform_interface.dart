import 'dart:async';

import 'package:disposing/disposing.dart';
import 'package:worker_method_channel/worker_method_channel.dart';

import 'web_worker_method_channel_web.dart' if (dart.library.io) 'web_worker_method_channel_stub.dart';

typedef MethodCallHandler = FutureOr<Object?> Function(Object? body);

abstract class WebWorkerMethodChannel with DisposableBag {
  factory WebWorkerMethodChannel({required String name, WorkerBase? worker}) =>
      getWebWorkerMethodChannel(name: name, worker: worker);

  SyncDisposable setMethodCallHandler(String method, MethodCallHandler handler);

  Future<Object?> invokeMethod(String method, [Object? body]);
}
