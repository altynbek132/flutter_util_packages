part of '../extensions.dart';

/// Turn the Set into an ObservableSet.
extension ObservableSetExtension<T> on Set<T> {
  ObservableSet<T> asObservable({ReactiveContext? context, String? name}) =>
      ObservableSet<T>.of(this, context: context, name: name);

  ObservableSet<T> obs({ReactiveContext? context, String? name}) => asObservable(context: context, name: name);

  ObservableSet<T> obsIdentity({ReactiveContext? context, String? name}) =>
      ObservableSet<T>.identity(this, context: context, name: name);
}
