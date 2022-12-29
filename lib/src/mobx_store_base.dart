import 'dart:async';

import 'package:disposing/disposing.dart';
import 'package:disposing/disposing.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart' hide Disposable;
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart' hide Listenable;
import 'package:rxdart/rxdart.dart';
import 'package:utils/src/utils.dart';

abstract class MobxStoreBase extends DisposableBag {
  Logger get log;

  MobxStoreBase({this.getState});

  State Function()? getState;

  BuildContext get bContext => getState!().context;

  final _initCompleter = Completer<void>();

  bool get inited => _initCompleter.isCompleted;

  late final initialization = _initCompleter.future.asObservable();

  @protected
  void notifyInitSuccess() {
    _initCompleter.complete();
  }

  @protected
  void notifyInitError(Object e, [StackTrace? st]) {
    _initCompleter.completeError(e, st);
  }

  @protected
  void setupObservableLoggers(
      Iterable<ValueGetter> formattedValueGetters, Logger log) {
    // calling toList invokes lambda
    final disposers =
        formattedValueGetters.map((e) => autorun((_) => log.i(e()))).toList();
    autoDispose(SyncCallbackDisposable(() => disposers.forEach((e) => e())));
  }

  @protected
  void registerAsSingletonUntilDispose<T extends MobxStoreBase>() {
    final locator = GetIt.instance;
    locator.registerSingleton<T>(this as T);
    SyncCallbackDisposable(() => locator.unregister<T>(instance: this))
        .disposeOn(this);
  }

  @override
  Future<void> dispose() async {
    log.i('dispose init');
    _disposeStreamC.add(null);
    await super.dispose();
    _disposeStreamC.close();
    log.i('dispose finish');
  }

  final _disposeStreamC = StreamController<void>();
  late final disposeStream = _disposeStreamC.stream.shareReplay(maxSize: 1);
}

extension DisposableBagExtension on DisposableBag {
  void autoDispose(Disposable disposable) => add(disposable);

  void autoDisposeList(Iterable<Disposable> disposables) {
    for (final disposable in disposables) {
      add(disposable);
    }
  }
}
