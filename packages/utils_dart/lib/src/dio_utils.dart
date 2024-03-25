import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:rxdart/rxdart.dart';

class DioUtils {
  static Stream<T> makeCancelableStreamRequest<T>(
    Future<T> Function(CancelToken ct) request, {
    bool? startImmediately,
  }) {
    startImmediately ??= false;

    final cancelToken = CancelToken();
    Future<T>? requestFuture;
    if (startImmediately) requestFuture = request(cancelToken);
    BehaviorSubject<T>? c;
    return c = BehaviorSubject<T>(
      onListen: () => c!.addStream((requestFuture ?? request(cancelToken)).asStream()),
      onCancel: () => cancelToken.cancel(),
    );
  }

  static ObservableStream<T> makeCancelableObsStreamRequest<T>(Future<T> Function(CancelToken ct) request) =>
      makeCancelableStreamRequest(request).asObservable();

  DioUtils._();
}
