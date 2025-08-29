import 'dart:async';
import 'package:yx_scope/yx_scope.dart';

class AsyncInitializerDep<T> implements AsyncLifecycle {
  late final T value;

  final Future<T> Function() _initializer;
  final Future<void> Function(T)? _disposer;

  AsyncInitializerDep(
    this._initializer, {
    Future<void> Function(T)? disposer,
  }) : _disposer = disposer;

  @override
  Future<void> init() async {
    value = await _initializer();
  }

  @override
  Future<void> dispose() async {
    await _disposer?.call(value);
  }
}
