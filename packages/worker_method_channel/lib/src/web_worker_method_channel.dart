import 'dart:async';

import 'package:disposing/disposing_dart.dart';
import 'package:worker_method_channel/src/exception_with_type.dart';
import 'package:worker_method_channel/worker_method_channel.dart';

import 'web_worker_method_channel_web.dart' if (dart.library.io) 'web_worker_method_channel_stub.dart';

/// A typedef representing a method call handler.
///
/// The [MethodCallHandler] is a function that takes an [Object] as a parameter
/// representing the body of the method call, and returns a [Future] or [Object?].
/// It is used to handle method calls in a web worker environment.
typedef MethodCallHandler = FutureOr<dynamic> Function(Object? request);

/// A typedef representing an exception serializer and deserializer.
/// if null returned from serializer, default serialization will be used.
typedef ExceptionSerializer = ExceptionWithType? Function(Object error);
typedef ExceptionDeserializer = ExceptionWithType? Function(ExceptionWithType exceptionWithType);

/// An abstract class representing a method channel for communication between the main thread and a web worker.
///
/// This class provides methods for setting a method call handler and invoking methods on the channel.
abstract class WebWorkerMethodChannel with DisposableBag {
  /// Creates a new instance of [WebWorkerMethodChannel].
  ///
  /// The [scriptURL] parameter specifies the name of the method channel.
  /// The [worker] parameter specifies and overrides the web worker associated with the channel.
  factory WebWorkerMethodChannel({required String scriptURL, Worker? worker}) =>
      getWebWorkerMethodChannel(scriptURL: scriptURL, worker: worker);

  /// Sets the method call handler for the specified method.
  ///
  /// The [method] parameter specifies the name of the method.
  /// The [handler] parameter specifies the method call handler.
  ///
  /// Returns a [SyncDisposable] that can be used to dispose the method call handler.
  SyncDisposable setMethodCallHandler(String method, MethodCallHandler handler);

  void setExceptionSerializer(ExceptionSerializer? serializer);

  void setExceptionDeserializer(ExceptionDeserializer? deserializer);

  /// Invokes the specified method on the channel.
  ///
  /// The [method] parameter specifies the name of the method.
  /// The [body] parameter specifies the optional body of the method call.
  ///
  /// Returns a [Future] that completes with the result of the method call.
  Future<Object?> invokeMethod(String method, [Object? body]);
}
