import 'package:disposing/disposing_dart.dart';
import 'package:meta/meta.dart';
import 'package:worker_method_channel/worker_method_channel.dart';

@internal
WebWorkerMethodChannel getWebWorkerMethodChannel({required String scriptURL, Worker? worker}) =>
    WebWorkerMethodChannelStub();

/// A stub implementation of the [WebWorkerMethodChannel] interface.
/// This class provides default implementations for the methods defined in the [WebWorkerMethodChannel] interface.
class WebWorkerMethodChannelStub with DisposableBag implements WebWorkerMethodChannel {
  @override
  Future<Object?> invokeMethod(String method, [Object? body]) {
    throw UnimplementedError();
  }

  @override
  SyncDisposable setMethodCallHandler(String method, MethodCallHandler handler) {
    throw UnimplementedError();
  }

  @override
  void setExceptionDeserializer(ExceptionDeserializer? deserializer) {
    throw UnimplementedError();
  }

  @override
  void setExceptionSerializer(ExceptionSerializer? serializer) {
    throw UnimplementedError();
  }
}
