import 'dart:async';
import 'package:mobx/mobx.dart';
import 'package:rxdart/rxdart.dart';

class MobxUtilsDart {
  MobxUtilsDart._();

  /// Converts a getter function into a stream of values.
  ///
  /// The [fromGetter] method takes a getter function as input and returns a [Stream] of type [T].
  /// The getter function is responsible for retrieving the current value of type [T].
  /// The returned stream will emit the current value of the getter function whenever it changes.
  /// The stream will automatically update its value whenever the getter function is called.
  ///
  /// Example usage:
  /// ```dart
  /// Stream<int> countStream = fromGetter(() => count);
  /// ```
  ///
  /// In the above example, `countStream` is a stream that emits the current value of the `count` getter function.
  /// Whenever the `count` getter function is called and its value changes, the stream will emit the new value.
  ///
  /// Note: This method uses the `BehaviorSubject` class from the `rxdart` package to create the stream.
  /// Make sure to include the `rxdart` package in your project's dependencies.
  ///
  /// Returns a [Stream] of type [T] that emits the current value of the getter function whenever it changes.
  static Stream<T> fromGetter<T>(T Function() getter) {
    BehaviorSubject<T>? controller;
    ReactionDisposer? disposer;
    return controller = BehaviorSubject<T>(
      onListen: () => disposer = autorun((_) => controller!.add(getter())),
      onCancel: () => disposer?.call(),
    );
  }
}
