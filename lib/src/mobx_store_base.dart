import 'dart:async';

import 'package:disposing/disposing.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart' hide Disposable;
import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart' hide Listenable;
import 'package:rxdart/rxdart.dart';

import '../utils.dart';

abstract class MobxStoreBase<W extends ElementaryWidget> extends WidgetModel<W>
    with LoggerMixin, DisposableBag {
  @override
  void initWidgetModel() {
    super.initWidgetModel();
    setupLoggers();
    log.i('initWidgetModel');
  }

  @protected
  void setupLoggers() {}

  @protected
  void logOnStringChange(ValueGetter getter) {
    MobxUtils.fromGetter(getter)
        .takeUntil(disposeStream)
        .map((event) => event.toString())
        .distinct()
        .listen((event) => log.i('toString change: ${event}'))
        .disposeOn(this);
  }

  @protected
  void setupObservableLoggers(
      Iterable<ValueGetter> formattedValueGetters, Logger log) {
    // calling toList invokes lambda
    final disposers =
        formattedValueGetters.map((e) => autorun((_) => log.i(e()))).toList();
    SyncCallbackDisposable(() => disposers.forEach((e) => e())).disposeOn(this);
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
    super.dispose();
  }

  late final disposeStream = _disposeStreamC.stream.shareReplay(maxSize: 1);
  final _disposeStreamC = StreamController<void>();
}
