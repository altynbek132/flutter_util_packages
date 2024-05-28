import 'dart:async';
import 'dart:js_interop' as js_interop;
import 'dart:math';

import 'package:disposing/disposing_dart.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:utils/utils_dart.dart';
import 'package:web/web.dart' as web;
import 'package:worker_method_channel/src/exception_serializing/error_serializer_registry.dart';
import 'package:worker_method_channel/src/exception_serializing/exception_serializer.dart';
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
WebWorkerMethodChannel getWebWorkerMethodChannel({
  required String scriptURL,
  required ErrorSerializerRegistry serializerRegistry,
  Worker? worker,
}) {
  if (worker != null) {
    return WebWorkerMethodChannelWeb(worker: worker, serializerRegistry: serializerRegistry);
  }
  if (self.instanceOfString('Window')) {
    return WebWorkerMethodChannelWeb(worker: WorkerImpl(web.Worker(scriptURL)), serializerRegistry: serializerRegistry);
  }
  return WebWorkerMethodChannelWeb(
    worker: WorkerImplSelf(self as web.DedicatedWorkerGlobalScope),
    serializerRegistry: serializerRegistry,
  );
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

  final ErrorSerializerRegistry serializerRegistry;

  final Worker worker;

  /// A map that stores the pending requests along with their corresponding completers.
  @visibleForTesting
  final requests = <int, Completer<Object?>>{};

  /// A map that stores the method call handlers for different method names.
  @visibleForTesting
  final methodCallHandlers = <String, List<MethodCallHandler>>{};

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
    required this.serializerRegistry,
    required this.worker,
  }) {
    if (!worker.isMainThread) {
      SyncCallbackDisposable(() => worker.terminate()).disposeOn(this);
    }
    worker.addEventListener((Message data) async {
      final method = data.method;
      final requestId = data.requestId;
      if (requests.containsKey(requestId)) {
        var webPlatformException = data.exception;
        final completer = requests.remove(requestId);

        if (webPlatformException != null) {
          // deserialize exception
          if (webPlatformException.innerExceptionWithType != null) {
            final serializer = serializerRegistry.getSerializer(webPlatformException.innerExceptionWithType!.type) ??
                ExceptionSerializer();
            logger.d(
                "🚀~web_worker_method_channel_web.dart:118~WebWorkerMethodChannelWeb~worker.addEventListener~serializer.serializedExceptionType: ${serializer.serializedExceptionType}");

            webPlatformException = webPlatformException.copyWith.innerExceptionWithType!(
              exception: serializer.deserializeError(webPlatformException.innerExceptionWithType!.exception),
            );
          }
          completer!.completeError(webPlatformException);
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
            logger.e('Error while handling method call (WebPlatformException)', error: e);
            worker.postMessage(
              Message(
                method: method,
                exception: e,
                requestId: requestId,
              ),
            );
          } on Object catch (e, st) {
            logger.e('Error while handling method call (unknown error)', error: e, stackTrace: st);
            final serializer = serializerRegistry.getSerializerByType(e.runtimeType) ?? ExceptionSerializer();
            logger.d(
                "🚀~web_worker_method_channel_web.dart:161~WebWorkerMethodChannelWeb~handlers.map~serializer.serializedExceptionType: ${serializer.serializedExceptionType}");
            worker.postMessage(
              Message(
                method: method,
                exception: WebPlatformException(
                  innerExceptionWithType: ExceptionWithType(
                    type: serializer.serializedExceptionType,
                    exception: serializer.serializeError(e),
                  ),
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
}
