import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:mobx/mobx.dart' hide Listenable;
import 'package:rxdart/rxdart.dart';

import 'mobx_extensions.dart';

class MobxUtils {
  static Stream<T> makeCancelableStreamRequest<T>(
      Future<T> Function(CancelToken ct) request,
      {bool? startImmediately}) {
    startImmediately ??= false;

    final cancelToken = CancelToken();
    Future<T>? requestFuture;
    if (startImmediately) requestFuture = request(cancelToken);
    BehaviorSubject<T>? c;
    return c = BehaviorSubject<T>(
      onListen: () =>
          c!.addStream((requestFuture ?? request(cancelToken)).asStream()),
      onCancel: () => cancelToken.cancel(),
    );
  }

  static ObservableStream<T> makeCancelableObsStreamRequest<T>(
          Future<T> Function(CancelToken ct) request) =>
      makeCancelableStreamRequest(request).asObservable();

  static Stream<T> fromGetter<T>(T Function() getter) {
    BehaviorSubject<T>? controller;
    ReactionDisposer? disposer;
    return controller = BehaviorSubject<T>(
      onListen: () => disposer = autorun((_) => controller!.add(getter())),
      onCancel: () => disposer?.call(),
    );
  }

  WithDisposer<Observable<T>> fromListenable<T extends Listenable>(T vl) {
    final obs = Observable<T>(vl);
    final cb = Action(() => obs
      ..value = vl
      ..manualReportChange());
    vl.addListener(cb);
    return WithDisposer(
      obs,
      () => vl.removeListener(cb),
    );
  }

  MobxUtils._();
}
