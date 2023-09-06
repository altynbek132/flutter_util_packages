import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:utils/utils.dart';
import 'package:mobx/mobx.dart';

import 'model.dart';

part 'app_state.g.dart';

@LazySingleton(dispose: disposeAppState)
class AppState = _AppStateBase with _$AppState;

abstract class _AppStateBase extends MobxWM with Store, LoggerMixin {
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
  Book? selectedBook;

  final books = <Book>[
    Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
    Book('Foundation', 'Isaac Asimov'),
    Book('Fahrenheit 451', 'Ray Bradbury'),
  ].asObservable();

  /// COMPUTED -----------------------------------------------------------------

  /// STREAM REACTION ----------------------------------------------------------

  /// ACTIONS ------------------------------------------------------------------

  /// UI -----------------------------------------------------------------------

  /// UTIL METHODS -------------------------------------------------------------

  void _setupLoggers() {
    setupObservableLoggers([
      () => 'initialization: ${initialization.status.name}',
    ], logger);
  }

  /// CONSTRUCTOR --------------------------------------------------------------
  _AppStateBase() {
    _init();
    _asyncInit().then((_) => notifyInitSuccess()).onErrorNullable(cb: notifyInitError);
  }
}

Future<void> disposeAppState(AppState instance) async => instance.disposeAsync();
