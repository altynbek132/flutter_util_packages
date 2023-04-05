import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:utils/utils.dart';
import 'package:mobx/mobx.dart';

part 'screen_wm.g.dart';

ScreenWm screenWmFactory(BuildContext context) {
  return ScreenWm();
}

// @LazySingleton(dispose: disposeScreenWm)
class ScreenWm = _ScreenWmBase with _$ScreenWm;

abstract class _ScreenWmBase extends MobxWM with Store {
  /// INIT ---------------------------------------------------------------------

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  /// DEPENDENCIES -------------------------------------------------------------

  /// FIELDS -------------------------------------------------------------------

  /// PROXY --------------------------------------------------------------------

  /// OBSERVABLES --------------------------------------------------------------

  /// COMPUTED -----------------------------------------------------------------

  /// STREAM REACTION ----------------------------------------------------------

  /// ACTIONS ------------------------------------------------------------------

  /// UI -----------------------------------------------------------------------

  /// UTIL METHODS -------------------------------------------------------------

  @override
  void setupLoggers() {
    setupObservableLoggers([
      () => '',
    ], log);
  }

  /// CONSTRUCTOR --------------------------------------------------------------
}

Future<void> disposeScreenWm(ScreenWm instance) async => instance.dispose();
