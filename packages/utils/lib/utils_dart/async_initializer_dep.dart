import 'dart:async';
import 'package:yx_scope/yx_scope.dart';

class AsyncInitializerDep<T> implements AsyncLifecycle {
  final Future<T> Function() initializer;
  final Future<void> Function(T)? disposer;
  late final T value;

  AsyncInitializerDep(
    this.initializer, {
    this.disposer,
  });

  @override
  Future<void> init() async {
    value = await initializer();
  }

  @override
  Future<void> dispose() async {
    await disposer?.call(value);
  }
}
