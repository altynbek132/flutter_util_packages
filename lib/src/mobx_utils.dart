import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:rxdart/rxdart.dart';

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

  static Stream<T> observableFieldToStream<T>(T Function() getter) {
    BehaviorSubject<T>? controller;
    ReactionDisposer? disposer;
    return controller = BehaviorSubject<T>(
      onListen: () => disposer = autorun((_) => controller!.add(getter())),
      onCancel: () => disposer?.call(),
    );
  }

  static ObservableStream<T> observableFieldToObsStream<T>(
          T Function() getter) =>
      observableFieldToStream(getter).asObservable();

  static Stream<T> observableToStream<T>(Observable<T> obs) =>
      observableFieldToStream(() => obs.value);

  static ObservableStream<T> observableToObsStream<T>(Observable<T> obs) =>
      observableToStream(obs).asObservable();

  MobxUtils._();
}
