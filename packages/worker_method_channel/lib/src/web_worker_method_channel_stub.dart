import 'package:disposing/disposing.dart';
import 'package:meta/meta.dart';

import 'web_worker_method_channel_platform_interface.dart';
import 'worker_base.dart';

@internal
WebWorkerMethodChannel getWebWorkerMethodChannel(
        {required WorkerBase worker}) =>
    WebWorkerMethodChannelStub();

class WebWorkerMethodChannelStub
    with DisposableBag
    implements WebWorkerMethodChannel {
  @override
  Future<Object?> invokeMethod(String method, [Object? body]) {
    throw UnimplementedError();
  }

  @override
  SyncDisposable setMethodCallHandler(
      String method, MethodCallHandler handler) {
    throw UnimplementedError();
  }
}
