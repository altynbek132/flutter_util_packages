import 'dart:async';
import 'dart:math' as math;

import 'package:disposing/disposing.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:utils/utils.dart';

import 'other.dart';

part 'draggable_scrollable_controller_wrapper.g.dart';

class DraggableScrollableControllerWrapper = _DraggableScrollableControllerWrapperBase
    with _$DraggableScrollableControllerWrapper;

abstract class _DraggableScrollableControllerWrapperBase extends MobxStoreBase
    with Store, LoggerMixin {
  /// INIT ---------------------------------------------------------------------

  // sync init
  void _init() {
    _setupLoggers();
    initLateFields([]);
  }

  // async init
  Future<void> _asyncInit() async {}

  /// DEPENDENCIES -------------------------------------------------------------

  /// FIELDS -------------------------------------------------------------------

  /// PROXY --------------------------------------------------------------------

  /// OBSERVABLES --------------------------------------------------------------
  final controllerRaw = DraggableScrollableController();
  late final controller =
      (MobxUtils.fromCN(controllerRaw)..disposeOn(this)).value;

  @observable
  late var minChildSize = math.min(initialChildSizeRef, minChildSizeRef);
  @observable
  double minChildSizeRef;

  @observable
  late var maxChildSize = maxChildSizeRef;
  @observable
  double maxChildSizeRef;

  @observable
  double initialChildSizeRef;

  // todo Altynbek: report bugfix
  // proxy, bugfix
  double get initialChildSize {
    // first build
    if (!controllerRaw.isAttached) {
      return initialChildSizeRef;
    }
    // later builds
    return controllerRaw.size;
  }

  /// COMPUTED -----------------------------------------------------------------

  /// STREAM REACTION ----------------------------------------------------------

  /// ACTIONS ------------------------------------------------------------------
  @action
  Future<void> close({Duration? duration, Curve? curve}) async {
    minChildSize = 0;
    WidgetsBinding.instance
        .addPostFrameCallback((_) => controller.value.animateTo(
              0,
              duration: duration ?? const Duration(milliseconds: 1000),
              curve: curve ?? Curves.easeInOut,
            ));
  }

  @action
  Future<void> open({double? value, Duration? duration, Curve? curve}) async {
    if (![value].contains(null)) assert(value! >= minChildSizeRef);
    await controller.value.animateTo(
      value ?? minChildSizeRef,
      duration: duration ?? const Duration(milliseconds: 1000),
      curve: curve ?? Curves.easeInOut,
    );
    if (controllerRaw.size >= minChildSizeRef) {
      minChildSize = minChildSizeRef;
    }
  }

  /// UI -----------------------------------------------------------------------

  /// UTIL METHODS -------------------------------------------------------------

  @action
  Future<void> animateTo(double value,
          {Duration? duration, Curve? curve}) async =>
      controller.value.animateTo(
        value,
        duration: duration ?? const Duration(milliseconds: 1000),
        curve: curve ?? Curves.easeInOut,
      );

  void _setupLoggers() {
    setupObservableLoggers([
      // () => 'initialization: ${initialization.status.name}',
    ], log);
  }

  /// CONSTRUCTOR --------------------------------------------------------------
  _DraggableScrollableControllerWrapperBase({
    required this.initialChildSizeRef,
    required this.minChildSizeRef,
    required this.maxChildSizeRef,
  }) {
    _init();
    _asyncInit()
        .then((_) => notifyInitSuccess())
        .onErrorNullable(cb: notifyInitError);
  }
}
