import 'dart:async';

import 'package:disposing/disposing.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart' hide Listenable;
import 'package:rxdart/rxdart.dart';
import 'package:utils/src/utils.dart';

class MobxStoreBase extends DisposableBag {
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
    addDisposable(SyncCallbackDisposable(() => disposers.forEach((e) => e())));
  }

  @override
  Future<void> dispose() async {
    _disposeStreamC.add(null);
    await futureWait([
      super.dispose(),
      _disposeStreamC.close(),
    ]);
  }

  final _disposeStreamC = StreamController<void>();
  late final disposeStream = _disposeStreamC.stream.shareReplay(maxSize: 1);
}

extension DisposableBagExtension on DisposableBag {
  void addDisposable(Disposable disposable) => add(disposable);

  void addDisposables(Iterable<Disposable> disposables) {
    for (final disposable in disposables) {
      add(disposable);
    }
  }
}
