import 'dart:js_interop' as js_interop;

import 'package:disposing/disposing_dart.dart';
import 'package:meta/meta.dart';
import 'package:utils/utils_dart.dart';
import 'package:web/web.dart' as web;

import 'package:worker_method_channel/src/bigint_wrapper.dart';

import 'message.dart';
import 'worker.dart';

mixin _WorkerBaseImp on Worker {
  web.EventTarget get eventTarget;

  @override
  SyncDisposable addEventListener(
    void Function(Message data) listener, [
    void Function(Object?)? onError,
  ]) {
    final listenerJS = ((web.MessageEvent e) {
      final data = unWrapBigIntRecurse(e.data.dartify()!) as Object;
      listener(Message.fromJson(data.castRecursiveMap()));
    }).toJS;
    final onErrorJS = (js_interop.JSAny error) {
      onError?.call(error.dartify());
    }.toJS;
    eventTarget.addEventListener('message', listenerJS);
    eventTarget.addEventListener('error', onErrorJS);
    return SyncCallbackDisposable(() {
      eventTarget.removeEventListener('message', listenerJS);
      eventTarget.removeEventListener('error', onErrorJS);
    });
  }
}

@internal
final class WorkerImpl extends Worker with _WorkerBaseImp {
  final web.Worker worker;

  WorkerImpl(this.worker);

  @override
  void postMessage(Message message) {
    final wrappedBigInt = (wrapBigIntRecurse(message.toJson()) as Map);
    final jsify = wrappedBigInt.jsify();

    worker.postMessage(jsify);
  }

  @override
  void terminate() {
    worker.terminate();
  }

  @override
  web.EventTarget get eventTarget => worker;

  @override
  bool get isMainThread => true;
}

@internal
final class WorkerImplSelf extends Worker with _WorkerBaseImp {
  final web.DedicatedWorkerGlobalScope self;

  WorkerImplSelf(this.self);

  @override
  void postMessage(Message message) {
    final wrappedBigInt = (wrapBigIntRecurse(message.toJson()) as Map);
    final jsify = wrappedBigInt.jsify();

    self.postMessage(jsify);
  }

  @override
  void terminate() {
    throw UnimplementedError();
  }

  @override
  web.EventTarget get eventTarget => self;

  @override
  bool get isMainThread => false;
}
