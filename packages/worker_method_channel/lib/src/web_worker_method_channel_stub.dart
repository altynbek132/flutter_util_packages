import 'package:disposing/disposing.dart';
import 'package:meta/meta.dart';
import 'package:worker_method_channel/worker_method_channel.dart';

@internal
WebWorkerMethodChannel getWebWorkerMethodChannel({required String name, WorkerBase? worker}) =>
    WebWorkerMethodChannelStub();

class WebWorkerMethodChannelStub with DisposableBag implements WebWorkerMethodChannel {
  @override
  Future<Object?> invokeMethod(String method, [Object? body]) {
    throw UnimplementedError();
  }

  @override
  SyncDisposable setMethodCallHandler(String method, MethodCallHandler handler) {
    throw UnimplementedError();
  }
}
