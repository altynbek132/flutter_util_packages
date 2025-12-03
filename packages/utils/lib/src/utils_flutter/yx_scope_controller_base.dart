import 'package:disposing/disposing_dart.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:utils/utils_dart.dart';
import 'package:utils/src/utils_flutter/utils_flutter.dart';
import 'package:yx_scope/yx_scope.dart';

abstract class YxScopeControllerBase with DisposableBag, LoggerMixin, SafeDisposeMixin implements AsyncLifecycle {
  final loadingLock = ObservableLock();
  bool get isLoading => loadingLock.obs.value.locked;

  @override
  @mustCallSuper
  Future<void> init() async {
    logger.i('YxScopeControllerBase');
    setupLoggers();
  }

  @protected
  void setupLoggers() {}

  @protected
  void setupObservableLoggers(Iterable<ValueGetter> formattedValueGetters, Logger log) {
    setupObservableLoggersInner([() => 'isLoading: $isLoading', ...formattedValueGetters], log, this);
  }
}

mixin SafeDisposeMixin on DisposableBag implements AsyncLifecycle {
  bool _disposed = false;

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    await super.disposeAsync();
  }

  @override
  Future<void> disposeAsync() async {
    await dispose();
  }
}
