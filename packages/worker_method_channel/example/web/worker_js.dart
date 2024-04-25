// ignore_for_file: avoid_print

import 'dart:js_interop' as js_interop;

import 'package:web/web.dart' as web;
import 'package:worker_method_channel/worker_method_channel.dart';

@js_interop.JS('self')
external web.DedicatedWorkerGlobalScope get self;

Future<void> main() async {
  print('worker_js.dart init');
  final channel = WebWorkerMethodChannel(scriptURL: './web/worker_js.dart.js');
  channel.setMethodCallHandler('echo', (request) {
    return request;
  });
  await Future.delayed(const Duration(milliseconds: 1000));
  channel.invokeMethod('echo', 'hi from worker_js.dart');
}
