import 'package:disposing/disposing_dart.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:utils/utils_dart.dart';
import 'package:utils/utils_flutter/utils_flutter.dart';
import 'package:yx_scope/yx_scope.dart';

abstract class YxScopeControllerBase with DisposableBag, LoggerMixin implements AsyncLifecycle {
  bool? _disposeCalledForBag;

  @override
  Future<void> init() async {
    logger.i('YxScopeControllerBase');
    setupLoggers();
  }

  @override
  Future<void> dispose() async {
    if (_disposeCalledForBag == true) {
      return;
    }
    _disposeCalledForBag = false;
    return disposeAsync();
  }

  @override
  Future<void> disposeAsync() async {
    if (_disposeCalledForBag == false) {
      return;
    }
    _disposeCalledForBag = true;
    await super.disposeAsync();
    return dispose();
  }

  @protected
  void setupLoggers() {}

  @protected
  void setupObservableLoggers(Iterable<ValueGetter> formattedValueGetters, Logger log) {
    setupObservableLoggersInner(formattedValueGetters, log, this);
  }
}
