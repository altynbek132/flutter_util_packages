import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:utils/utils.dart';

part 'mobxx.g.dart';

// @LazySingleton(dispose: disposeMobxx)
class Mobxx extends MobxWM with Store, LoggerMixin, _$Mobxx {
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
  @observable
  var asdf = false;

  /// COMPUTED -----------------------------------------------------------------

  /// STREAM REACTION ----------------------------------------------------------

  /// ACTIONS ------------------------------------------------------------------

  /// UI -----------------------------------------------------------------------

  /// UTIL METHODS -------------------------------------------------------------

  void _setupLoggers() {
    setupObservableLoggers([
      () => 'initialization: ${initialization.status.name}',
    ], log);
  }

  /// CONSTRUCTOR --------------------------------------------------------------
  Mobxx({super.getState}) {
    _init();
    _asyncInit()
        .then((_) => notifyInitSuccess())
        .onErrorNullable(cb: notifyInitError);
  }
}

Future<void> disposeMobxx(Mobxx instance) async => instance.dispose();
