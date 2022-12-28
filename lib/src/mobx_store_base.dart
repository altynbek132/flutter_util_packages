import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart' hide Listenable;
import 'package:rxdart/rxdart.dart';
import 'package:utils/src/utils.dart';

class MobxStoreBase implements Disposable {
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
    addDisposer(() => disposers.map((e) => e()).toList());
  }

  @protected
  T makeDisposable<T>(T val, FutureOr Function() Function(T val) makeDispose) {
    addDisposer(makeDispose(val));
    return val;
  }

  void addDisposer(FutureOr Function() disposer) {
    _disposers.add(disposer);
  }

  void addDisposers(Iterable<FutureOr Function()> disposers) {
    _disposers.addAll(disposers);
  }

  final _disposers = <FutureOr Function()>[];

  @override
  Future<void> dispose() async {
    _disposeStreamC.add(null);
    await futureWait([
      ..._disposers.map((e) => e.call()),
      _disposeStreamC.close(),
    ]);
  }

  final _disposeStreamC = StreamController<void>();
  late final disposeStream = _disposeStreamC.stream.shareReplay(maxSize: 1);

  void disposeWithVm(MobxStoreBase vm) {
    vm.addDisposer(dispose);
  }
}
