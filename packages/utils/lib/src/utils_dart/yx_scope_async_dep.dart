import 'dart:async';
import 'package:utils/src/utils_dart/utils_dart.dart';
import 'package:yx_scope/yx_scope.dart';

extension ScopeModuleRawAsyncDepExtension on ScopeModule {
  AsyncDep<Value> rawAsyncDep_<Value>(
    DepBuilder<Value> builder, {
    FutureOr<void> Function(Value dep)? init,
    FutureOr<void> Function(Value dep)? dispose,
    String? name,
  }) {
    // ignore: invalid_use_of_protected_member
    return rawAsyncDep(
      builder,
      init: (dep) async => await init?.call(dep),
      dispose: (dep) async => await dispose?.call(dep),
      name: name,
    );
  }

  AsyncDep<AsyncInitializerDep<Value>> asyncDep_<Value>(
    Future<Value> Function() initializer, {
    Future<void> Function(Value)? disposer,
    String? name,
  }) {
    // ignore: invalid_use_of_protected_member
    return asyncDep(
      () => AsyncInitializerDep<Value>(initializer, disposer: disposer),
      name: name,
    );
  }
}

extension ScopeContainerRawAsyncDepExtension on ScopeContainer {
  AsyncDep<Value> rawAsyncDep_<Value>(
    DepBuilder<Value> builder, {
    FutureOr<void> Function(Value dep)? init,
    FutureOr<void> Function(Value dep)? dispose,
    String? name,
  }) {
    // ignore: invalid_use_of_protected_member
    return rawAsyncDep(
      builder,
      init: (dep) async => await init?.call(dep),
      dispose: (dep) async => await dispose?.call(dep),
      name: name,
    );
  }

  AsyncDep<AsyncInitializerDep<Value>> asyncDep_<Value>(
    Future<Value> Function() initializer, {
    Future<void> Function(Value)? disposer,
    String? name,
  }) {
    // ignore: invalid_use_of_protected_member
    return asyncDep(
      () => AsyncInitializerDep<Value>(initializer, disposer: disposer),
      name: name,
    );
  }
}
