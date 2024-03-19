import 'dart:async';
import 'dart:math';

import 'package:disposing/disposing.dart';
import 'package:meta/meta.dart';
import 'package:utils_dart/utils_dart.dart';

import 'package:web/web.dart' as web;
import 'package:worker_method_channel/src/worker.dart';
import 'dart:js_interop' as js_interop;

import 'exception.dart';
import 'message.dart';
import 'web_worker_method_channel_platform_interface.dart';
import 'worker_base.dart';

@js_interop.JS('self')
external js_interop.JSAny get self;

@internal
WebWorkerMethodChannel getWebWorkerMethodChannel({required String name, WorkerBase? worker}) {
  if (worker != null) {
    return WebWorkerMethodChannelWeb(worker: worker);
  }
  if (self.instanceOfString('Window')) {
    return WebWorkerMethodChannelWeb(worker: Worker(web.Worker(name)));
  }
  return WebWorkerMethodChannelWeb(worker: WorkerSelf(self as web.DedicatedWorkerGlobalScope));
}

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
    const maxInt32 = 0x7FFFFFFF;
    return Random().nextInt(maxInt32);
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
