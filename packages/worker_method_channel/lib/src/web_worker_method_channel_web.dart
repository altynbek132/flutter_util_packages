import 'dart:async';
import 'dart:math';

import 'package:disposing/disposing.dart';
import 'package:meta/meta.dart';
import 'package:utils_dart/utils_dart.dart';

import 'package:web/web.dart' as web;
import 'package:worker_method_channel/src/worker_impl.dart';
import 'dart:js_interop' as js_interop;

import 'exception.dart';
import 'message.dart';
import 'web_worker_method_channel.dart';
import 'worker.dart';

@js_interop.JS('self')
external js_interop.JSAny get self;

/// Returns a [WebWorkerMethodChannel] for communication between the main thread and a web worker.
///
/// The [scriptURL] parameter specifies the name of the channel.
/// The [worker] parameter is an optional [Worker] instance representing the web worker.
/// If [worker] is provided, a [WebWorkerMethodChannelWeb] is created with the given [worker].
/// If [worker] is not provided, a [WebWorkerMethodChannelWeb] is created based on the type of the global scope.
/// If the global scope is a 'Window' instance, a [WebWorkerMethodChannelWeb] is created with a new web worker using the given [scriptURL].
/// If the global scope is a 'DedicatedWorkerGlobalScope' instance, a [WebWorkerMethodChannelWeb] is created with the current web worker.
WebWorkerMethodChannel getWebWorkerMethodChannel({required String scriptURL, Worker? worker}) {
  if (worker != null) {
    return WebWorkerMethodChannelWeb(worker: worker);
  }
  if (self.instanceOfString('Window')) {
    return WebWorkerMethodChannelWeb(worker: WorkerImpl(web.Worker(scriptURL)));
  }
  return WebWorkerMethodChannelWeb(worker: WorkerImplSelf(self as web.DedicatedWorkerGlobalScope));
}

/// A class that represents a web implementation of the WorkerMethodChannel.
///
/// This class provides a communication channel between the main thread and a web worker
/// using the Worker API. It allows invoking methods on the web worker and handling method
/// calls from the web worker.
///
/// The [WebWorkerMethodChannelWeb] class implements the [WebWorkerMethodChannel] interface
/// and extends the [LoggerMixin] and [DisposableBag] classes.
class WebWorkerMethodChannelWeb with LoggerMixin, DisposableBag implements WebWorkerMethodChannel {
  final Worker worker;

  /// A map that stores the pending requests along with their corresponding completers.
  final _requests = <int, Completer<Object?>>{};

  /// A map that stores the method call handlers for different method names.
  final _methodCallHandlers = <String, List<MethodCallHandler>>{};

  @override
  SyncDisposable setMethodCallHandler(String method, MethodCallHandler handler) {
    (_methodCallHandlers[method] ??= []).add(handler);
    return SyncCallbackDisposable(() => _methodCallHandlers[method]?.remove(handler));
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
