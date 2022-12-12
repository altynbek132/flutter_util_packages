import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart' hide Listenable;
import 'package:rxdart/rxdart.dart';
import 'package:utils/src/utils.dart';

class MobxStoreBase implements Disposable {
  final _initCompleter = Completer<void>();

  bool get inited => _initCompleter.isCompleted;

  late final initialization = _initCompleter.future.asObservable();

  @protected
  void initLateFields(dynamic) {}

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

  /// [l] stands for listenable
  ///
  /// usage:
  ///
  /// ```late final cityTextController = createFromListenable(
  ///     TextEditingController(), (l) => l.addListener, (l, cb) => () {
  ///   // unnecessary if we dispose controller
  ///   l.removeListener(cb);
  ///   l.dispose();
  /// });```
  @protected
  Observable<T> obsFromListenable<T>(
      T l,
      Function Function(T l) makeAddListener,
      VoidCallback Function(T l, Function() cb) makeDisposer) {
    final obs = Observable<T>(l);
    cb() => obs.manualReportChange();
    makeAddListener(l)(cb);
    addDisposer(makeDisposer(l, cb));
    return obs;
  }

  @protected
  Observable<T> obsFromValueNotifierValue<T>(ValueNotifier<T> vl) {
    final obs = Observable<T>(vl.value);
    cb() => obs.value = vl.value;
    vl.addListener(cb);
    addDisposer(() {
      vl.removeListener(cb);
      vl.dispose();
    });
    return obs;
  }

  @protected
  Observable<T> obsFromValueNotifier<T extends ValueNotifier>(T vl) {
    final obs = Observable<T>(vl);
    cb() => obs.value = vl;
    vl.addListener(cb);
    addDisposer(() {
      vl.removeListener(cb);
      vl.dispose();
    });
    return obs;
  }

  @protected
  Observable<T> obsFromListenable_<T extends Listenable>(T vl) {
    final obs = Observable<T>(vl);
    cb() => obs.value = vl;
    vl.addListener(cb);
    addDisposer(() {
      vl.removeListener(cb);
    });
    return obs;
  }

  @protected
  Observable<T> obsFromChangeNotifier<T extends ChangeNotifier>(T vl) {
    final obs = Observable<T>(vl);
    cb() => obs.value = vl;
    vl.addListener(cb);
    addDisposer(() {
      vl.removeListener(cb);
      vl.dispose();
    });
    return obs;
  }

  @protected
  T makeDisposable<T>(T val, VoidCallback Function(T val) makeDispose) {
    addDisposer(makeDispose(val));
    return val;
  }

  @protected
  void addDisposer(VoidCallback disposer) {
    _disposers.add(disposer);
  }

  @protected
  void addDisposers(Iterable<VoidCallback> disposers) {
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
}
