import 'dart:async';

import 'package:disposing/disposing_dart.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:mobx/mobx.dart' hide Listenable;
import 'package:rxdart/rxdart.dart';
import 'package:utils/utils_dart.dart';

abstract class MobxMVController with LoggerMixin, DisposableBag {
  Future<void> init() async {
    logger.i('initWidgetModel');
    setupLoggers();
  }

  @protected
  void setupLoggers() {}

  @protected
  void setupObservableLoggers(Iterable<ValueGetter> formattedValueGetters, Logger log) {
    setupObservableLoggersInner(formattedValueGetters, log, this);
  }

  @override
  Future<void> disposeAsync() async {
    await super.disposeAsync();
  }
}

mixin MobxMVControllerMixin<C extends MobxMVController, T extends StatefulWidget> on State<T> {
  C controllerFactory();

  late final C controller = controllerFactory();
  C get c => controller;

  @override
  void dispose() {
    controller.disposeAsync();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.init();
  }
}

abstract class MobxWM<W extends ElementaryWidget> extends WidgetModel<W, Null> with LoggerMixin, DisposableBag {
  final loadingLock = ObservableLock();
  bool get isLoading => loadingLock.obs.value.locked;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    logger.i('initWidgetModel');
    setupLoggers();
  }

  @protected
  void setupLoggers() {}

  @protected
  void setupObservableLoggers(Iterable<ValueGetter> formattedValueGetters, Logger log) {
    setupObservableLoggersInner([() => 'isLoading: $isLoading', ...formattedValueGetters], log, this);
  }

  Future<void> get disposeFuture => _disposeCompleter.future;
  final Completer<void> _disposeCompleter = Completer<void>();

  @override
  void dispose() {
    () async {
      logger.i('dispose init');
      _disposeStreamC.add(null);
      _disposeStreamC.close();
      super.dispose();
      await super.disposeAsync();
      _disposeCompleter.complete();
      logger.i('dispose finish');
    }();
  }

  late final disposeStream = _disposeStreamC.stream.shareReplay(maxSize: 1);
  final _disposeStreamC = StreamController<void>();
}

abstract class MobxStoreBase with LoggerMixin, DisposableBag {
  @protected
  void setupObservableLoggers(Iterable<ValueGetter> formattedValueGetters, Logger log) {
    setupObservableLoggersInner(formattedValueGetters, log, this);
  }

  @override
  Future<void> disposeAsync() async {
    logger.i('dispose init');
    _disposeStreamC.add(null);
    _disposeStreamC.close();
    await super.disposeAsync();
    logger.i('dispose finish');
    _disposeCompleter.complete();
  }

  Future<void> get disposeFuture => _disposeCompleter.future;
  final Completer<void> _disposeCompleter = Completer<void>();

  late final disposeStream = _disposeStreamC.stream.shareReplay(maxSize: 1);
  final _disposeStreamC = StreamController<void>();
}

@internal
void setupObservableLoggersInner(Iterable<ValueGetter<dynamic>> formattedValueGetters, Logger log, DisposableBag bag) {
  // calling toList invokes lambda
  final disposers = formattedValueGetters.map((e) => autorun((_) => log.i(e()))).toList();
  SyncCallbackDisposable(() {
    for (var e in disposers) {
      e();
    }
  }).disposeOn(bag);
}
