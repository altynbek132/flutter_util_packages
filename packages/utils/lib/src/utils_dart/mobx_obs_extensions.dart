import 'dart:async';
import 'package:mobx/mobx.dart';

/// Turn the Future into an ObservableFuture.
extension ObservableFutureExtensionCustom<T> on Future<T> {
  ObservableFuture<T> obs({ReactiveContext? context, String? name}) => asObservable(context: context, name: name);
}

/// Turn the List into an ObservableList.
extension ObservableListExtensionCustom<T> on List<T> {
  ObservableList<T> obs({ReactiveContext? context, String? name}) => asObservable(context: context, name: name);

  ObservableList<T> obsProxy({ReactiveContext? context, String? name}) =>
      ObservableList<T>.proxy(this, context: context, name: name);
}

/// Turn the Map into an ObservableMap.
extension ObservableMapExtensionCustom<K, V> on Map<K, V> {
  ObservableMap<K, V> obs({ReactiveContext? context, String? name}) => asObservable(context: context, name: name);

  ObservableMap<K, V> obsProxy({ReactiveContext? context, String? name}) =>
      ObservableMap<K, V>.proxy(this, context: context, name: name);
}

/// Turn the Set into an ObservableSet.
extension ObservableSetExtension<T> on Set<T> {
  ObservableSet<T> obs({ReactiveContext? context, String? name}) => asObservable(context: context, name: name);

  ObservableSet<T> obsProxy({ReactiveContext? context, String? name}) =>
      ObservableSet<T>.proxy(this, context: context, name: name);
}

/// Turn the Stream into an ObservableStream.
extension ObservableStreamExtensionCustom<T> on Stream<T> {
  ObservableStream<T> obs({T? initialValue, bool cancelOnError = false, ReactiveContext? context, String? name}) =>
      asObservable(initialValue: initialValue, cancelOnError: cancelOnError, context: context, name: name);
}
