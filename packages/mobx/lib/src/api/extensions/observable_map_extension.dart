part of '../extensions.dart';

/// Turn the Map into an ObservableMap.
extension ObservableMapExtension<K, V> on Map<K, V> {
  ObservableMap<K, V> asObservable({ReactiveContext? context, String? name}) =>
      ObservableMap<K, V>.of(this, context: context, name: name);

  ObservableMap<K, V> obs({ReactiveContext? context, String? name}) => asObservable(context: context, name: name);

  ObservableMap<K, V> obsIdentity({ReactiveContext? context, String? name}) =>
      ObservableMap<K, V>.identity(this, context: context, name: name);
}
