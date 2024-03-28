import 'package:utils/utils_dart.dart';
import 'package:web/web.dart' as web;
import 'package:worker_method_channel/src/web_worker_method_channel_web.dart';
import 'dart:js_interop' as js_interop;

import 'package:worker_method_channel/worker_method_channel.dart';

import 'responses.dart';

@js_interop.JS('self')
external web.DedicatedWorkerGlobalScope get self;

Future<void> main() async {
  loggerGlobal.i('worker inited');
  final channel = WebWorkerMethodChannel(scriptURL: '');
  Responses.workerResponses.forEach((key, value) {
    channel.setMethodCallHandler(key, (body) async {
      return await value(body);
    });
  });
  (channel as WebWorkerMethodChannelWeb).methodCallHandlers.forEach((key, value) {
    loggerGlobal.i('key: $key, value: $value');
  });
}
