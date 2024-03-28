import 'dart:js_interop' as js_interop;
import 'package:disposing/disposing_dart.dart';
import 'package:web/web.dart' as web;
import 'package:utils/utils_dart.dart';

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
      final data = e.data.dartify()!;
      listener(Message.fromMap((data as Map).castRecursiveMap()));
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

final class WorkerImpl extends Worker with _WorkerBaseImp {
  final web.Worker worker;

  WorkerImpl(this.worker);

  @override
  void postMessage(Message message) {
    worker.postMessage(message.toMap().jsify());
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

final class WorkerImplSelf extends Worker with _WorkerBaseImp {
  final web.DedicatedWorkerGlobalScope self;

  WorkerImplSelf(this.self);

  @override
  void postMessage(Message message) {
    self.postMessage(message.toMap().jsify());
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
