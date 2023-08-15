part of '../extensions.dart';

/// Turn the Future into an ObservableFuture.
extension ObservableFutureExtension<T> on Future<T> {
  ObservableFuture<T> asObservable({ReactiveContext? context, String? name}) =>
      ObservableFuture<T>(this, context: context, name: name);

  ObservableFuture<T> obs({ReactiveContext? context, String? name}) => asObservable(context: context, name: name);
}
