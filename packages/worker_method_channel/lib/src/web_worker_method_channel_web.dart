import 'dart:async';
import 'dart:js_interop' as js_interop;
import 'dart:math';

import 'package:disposing/disposing_dart.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:utils/utils_dart.dart';
import 'package:web/web.dart' as web;
import 'package:worker_method_channel/src/exception_with_type.dart';
import 'package:worker_method_channel/src/worker_impl.dart';

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
  @override
  Logger get logger => getLogger('${runtimeType} worker.isMainThread:${worker.isMainThread}');

  final Worker worker;

  /// A map that stores the pending requests along with their corresponding completers.
  @visibleForTesting
  final requests = <int, Completer<Object?>>{};

  /// A map that stores the method call handlers for different method names.
  @visibleForTesting
  final methodCallHandlers = <String, List<MethodCallHandler>>{};

  /// The exception serializer used to serialize exceptions.
  ExceptionSerializer? _exceptionSerializer;

  /// The exception deserializer used to deserialize exceptions.
  ExceptionDeserializer? _exceptionDeserializer;

  @override
  SyncDisposable setMethodCallHandler(String method, MethodCallHandler handler) {
    (methodCallHandlers[method] ??= []).add(handler);
    return SyncCallbackDisposable(() => methodCallHandlers[method]?.remove(handler));
  }

  int _generateRandomRequestId() {
    const maxInt32 = 0x7FFFFFFF;
    return Random().nextInt(maxInt32);
  }

  @override
  Future<Object?> invokeMethod(String method, [Object? body]) {
    final requestId = _generateRandomRequestId();
    final completer = Completer<Object?>();
    requests[requestId] = completer;
    worker.postMessage(
      Message(
        method: method,
        body: body,
        requestId: requestId,
      ),
    );
    return completer.future;
  }

  WebWorkerMethodChannelWeb({
    required this.worker,
  }) {
    if (!worker.isMainThread) {
      SyncCallbackDisposable(() => worker.terminate()).disposeOn(this);
    }
    worker.addEventListener((Message data) async {
      final method = data.method;
      final requestId = data.requestId;
      if (requests.containsKey(requestId)) {
        var error = data.exception;
        final completer = requests.remove(requestId);
        if (error != null) {
          logger.d("🚀~web_worker_method_channel_web.dart:106~WebWorkerMethodChannelWeb~");
          // deserialize exception
          if (error.innerExceptionWithType != null && _exceptionDeserializer != null) {
            logger.d("🚀~web_worker_method_channel_web.dart:109~WebWorkerMethodChannelWeb~");
            error = error.copyWith(
              innerExceptionWithType:
                  _exceptionDeserializer?.call(error.innerExceptionWithType!) ?? error.innerExceptionWithType,
            );
            logger.d("🚀~web_worker_method_channel_web.dart:115~WebWorkerMethodChannelWeb~");
          }
          completer!.completeError(error);
          return;
        }
        final responseBody = data.body;
        completer!.complete(responseBody);
        return;
      }

      final handlers = methodCallHandlers[method] ?? [];
      if (handlers.isEmpty) {
        logger.w('No handlers for method $method');
        return;
      }
      await Future.wait(
        handlers.map((hanlder) async {
          try {
            final response = await hanlder(data.body);
            worker.postMessage(
              Message(
                method: method,
                body: response,
                requestId: requestId,
              ),
            );
          } on WebPlatformException catch (e) {
            logger.e('Error while handling method call (WebPlatformException)', e);
            worker.postMessage(
              Message(
                method: method,
                exception: e,
                requestId: requestId,
              ),
            );
          } on Object catch (e, st) {
            logger.e('Error while handling method call (unknown error)', e, st);
            worker.postMessage(
              Message(
                method: method,
                exception: WebPlatformException(
                  innerExceptionWithType:
                      _exceptionSerializer?.call(e) ?? ExceptionWithType(type: 'String', exception: e.toString()),
                  stacktrace: st,
                ),
                requestId: requestId,
              ),
            );
          }
        }),
      );
    }).disposeOn(this);
  }

  @override
  void setExceptionDeserializer(ExceptionDeserializer? deserializer) {
    _exceptionDeserializer = deserializer;
  }

  @override
  void setExceptionSerializer(ExceptionSerializer? serializer) {
    _exceptionSerializer = serializer;
  }
}
