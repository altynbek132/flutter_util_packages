import 'dart:async';
import 'dart:math';

import 'package:disposing/disposing.dart';
import 'package:meta/meta.dart';
import 'package:utils_dart/utils_dart.dart';

import 'exception.dart';
import 'message.dart';
import 'web_worker_method_channel_platform_interface.dart';
import 'worker_base.dart';

@internal
WebWorkerMethodChannel getWebWorkerMethodChannel(
        {required WorkerBase worker}) =>
    WebWorkerMethodChannelWeb(worker: worker);

class WebWorkerMethodChannelWeb
    with LoggerMixin, DisposableBag
    implements WebWorkerMethodChannel {
  final WorkerBase worker;

  final _requests = <int, Completer<Object?>>{};
  final _methodCallHandlers = <String, List<MethodCallHandler>>{};

  @override
  SyncDisposable setMethodCallHandler(
      String method, MethodCallHandler handler) {
    (_methodCallHandlers[method] ??= []).add(handler);
    return SyncCallbackDisposable(
        () => _methodCallHandlers[method]?.remove(handler));
  }

  int _generateRandomRequestId() {
    const maxSafeIntWeb = 9007199254740991;
    return Random().nextInt(maxSafeIntWeb);
  }

  @override
  Future<Object?> invokeMethod(String method, [Object? body]) {
    final requestId = _generateRandomRequestId();
    final completer = Completer<Object?>();
    _requests[requestId] = completer;
    worker.postMessage(Message(
      method: method,
      body: body,
      requestId: requestId,
    ));
    return completer.future;
  }

  WebWorkerMethodChannelWeb({
    required this.worker,
  }) {
    worker.addEventListener((Message data) async {
      final method = data.method;
      final requestId = data.requestId;

      if (_requests.containsKey(requestId)) {
        final error = data.exception;
        final completer = _requests.remove(requestId);
        if (error != null) {
          completer!.completeError(error);
          return;
        }
        final responseBody = data.body;
        completer!.complete(responseBody);
        return;
      }

      final handlers = _methodCallHandlers[method] ?? [];
      if (handlers.isEmpty) {
        logger.w('No handlers for method $method');
        return;
      }
      await Future.wait(handlers.map((hanlder) async {
        try {
          final response = await hanlder(data.body);
          worker.postMessage(Message(
            method: method,
            body: response,
            requestId: requestId,
          ));
        } on WebPlatformException catch (e) {
          worker.postMessage(Message(
            method: method,
            exception: e,
            requestId: requestId,
          ));
        } catch (e, st) {
          worker.postMessage(Message(
            method: method,
            exception: WebPlatformException(
              code: 'unknown',
              message: e.toString(),
              exception: e,
              stacktrace: st,
            ),
            requestId: requestId,
          ));
        }
      }));
    }).disposeOn(this);
  }
}
