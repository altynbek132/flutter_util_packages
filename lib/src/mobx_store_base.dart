import 'dart:async';

import 'package:disposing/disposing.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart' hide Disposable;
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart' hide Listenable;
import 'package:rxdart/rxdart.dart';

import '../utils.dart';

abstract class MobxWM<W extends ElementaryWidget> extends WidgetModel<W>
    with LoggerMixin, DisposableBag {
  @override
  void initWidgetModel() {
    super.initWidgetModel();
    setupLoggers();
    registerAsSingletonUntilDispose();
    log.i('initWidgetModel');
  }

  @protected
  void setupLoggers() {}

  @protected
  void logOnStringChange(ValueGetter getter) {
    _logOnStringChange(getter, disposeStream, log, this);
  }

  @protected
  void setupObservableLoggers(
      Iterable<ValueGetter> formattedValueGetters, Logger log) {
    _setupObservableLoggers(formattedValueGetters, log, this);
  }

  @protected
  void registerAsSingletonUntilDispose<T extends MobxWM>() {
    GetIt.I.registerSingleton<T>(this as T);
    SyncCallbackDisposable(() => GetIt.I.unregister<T>(instance: this))
        .disposeOn(this);
  }

  @override
  Future<void> dispose() async {
    log.i('dispose init');
    _disposeStreamC.add(null);
    _disposeStreamC.close();
    log.i('dispose finish');
    await super.dispose();
  }

  late final disposeStream = _disposeStreamC.stream.shareReplay(maxSize: 1);
  final _disposeStreamC = StreamController<void>();
}

abstract class MobxStoreBase with LoggerMixin, DisposableBag {
  @protected
  void logOnStringChange(ValueGetter getter) {
    _logOnStringChange(getter, disposeStream, log, this);
  }

  @protected
  void setupObservableLoggers(
      Iterable<ValueGetter> formattedValueGetters, Logger log) {
    _setupObservableLoggers(formattedValueGetters, log, this);
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
    _disposeStreamC.close();
    log.i('dispose finish');
    await super.dispose();
  }

  late final disposeStream = _disposeStreamC.stream.shareReplay(maxSize: 1);
  final _disposeStreamC = StreamController<void>();
}

void _logOnStringChange(ValueGetter<dynamic> getter,
    ReplayStream<void> disposeStream, Logger logger, DisposableBag bag) {
  MobxUtils.fromGetter(getter)
      .takeUntil(disposeStream)
      .map((event) => event.toString())
      .distinct()
      .listen((event) => logger.i('toString change: ${event}'))
      .disposeOn(bag);
}

void _setupObservableLoggers(
    Iterable<ValueGetter<dynamic>> formattedValueGetters,
    Logger log,
    DisposableBag bag) {
  // calling toList invokes lambda
  final disposers =
      formattedValueGetters.map((e) => autorun((_) => log.i(e()))).toList();
  SyncCallbackDisposable(() => disposers.forEach((e) => e())).disposeOn(bag);
}
