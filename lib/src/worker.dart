import 'dart:js_interop' as js_interop;
import 'package:web/web.dart' as web;

import 'package:disposing/disposing.dart';
import 'package:utils_dart/utils_dart.dart';

import 'message.dart';

abstract class WorkerBase {
  void postMessage(Message message);
  void terminate();

  web.EventTarget get eventTarget;

  SyncDisposable addEventListener(
    void Function(Message data) listener, [
    void Function(js_interop.JSAny)? onError,
  ]) {
    final listenerJS = ((web.MessageEvent e) {
      final data = e.data.dartify()!.castRecursiveMap();
      listener(data as Message);
    }).toJS;
    final onErrorJS = onError?.toJS;
    eventTarget.addEventListener('message', listenerJS);
    if (onErrorJS != null) {
      eventTarget.addEventListener('error', onErrorJS);
    }
    return SyncCallbackDisposable(() {
      eventTarget.removeEventListener('message', listenerJS);
      if (onErrorJS != null) {
        eventTarget.removeEventListener('error', onErrorJS);
      }
    });
  }
}

final class Worker extends WorkerBase {
  final web.Worker worker;

  Worker(this.worker);

  @override
  void postMessage(Message message) {
    worker.postMessage(message.toJSBox);
  }

  @override
  void terminate() {
    worker.terminate();
  }

  @override
  web.EventTarget get eventTarget => worker;
}

final class WorkerSelf extends WorkerBase {
  final web.DedicatedWorkerGlobalScope self;

  WorkerSelf(this.self);

  @override
  void postMessage(Message message) {
    self.postMessage(message.toJSBox);
  }

  @override
  void terminate() {}

  @override
  web.EventTarget get eventTarget => self;
}
