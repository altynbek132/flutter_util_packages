import 'dart:js_interop' as js_interop;

import 'package:utils/utils_dart.dart';
import 'package:web/web.dart' as web;
import 'package:worker_method_channel/src/exception_with_type.dart';
import 'package:worker_method_channel/src/web_worker_method_channel_web.dart';
import 'package:worker_method_channel/worker_method_channel.dart';

import 'custom_exception.dart';
import 'responses.dart';

@js_interop.JS('self')
external web.DedicatedWorkerGlobalScope get self;

/// Entry point of the worker script.
/// Initializes the worker and sets up method call handlers.
Future<void> main() async {
  loggerGlobal.i('worker inited');
  final channel = WebWorkerMethodChannel(scriptURL: '');
  channel.setExceptionSerializer((error) {
    if (error is CustomException) {
      return ExceptionWithType(type: 'CustomException', exception: error.toJson());
    }
    return null;
  });

  // Set up method call handlers for each worker response
  for (var handler in Responses.responseHandlers) {
    channel.setMethodCallHandler(handler.methodName, (request) => handler.response(request));
  }

  // Log the method call handlers
  (channel as WebWorkerMethodChannelWeb).methodCallHandlers.forEach((key, value) {
    loggerGlobal.i('key: $key, value: $value');
  });
}
