import 'package:web/web.dart' as web;
import 'dart:js_interop' as js_interop;

import 'package:worker_method_channel/worker_method_channel.dart';

@js_interop.JS('self')
external web.DedicatedWorkerGlobalScope get self;

Future<void> main() async {
  print('worker_js.dart init');
  final channel = WebWorkerMethodChannel(name: './web/worker_js.dart.js');
  channel.setMethodCallHandler('echo', (body) {
    print("🚀~worker_js.dart:12~");
    return body;
  });
  await Future.delayed(const Duration(milliseconds: 1000));
  channel.invokeMethod('echo', 'hi from worker_js.dart');
}
