import 'dart:async';

import 'package:disposing/disposing.dart';
import 'package:disposing_flutter/disposing_flutter.dart';
import 'package:flutter/widgets.dart';

extension SyncValueDisposableExtension<T> on SyncValueDisposable<T> {
  T disposeOnR(DisposableBag bag) {
    disposeOn(bag);
    return value;
  }
}

extension AsyncValueDisposableExtension<T> on AsyncValueDisposable<T> {
  T disposeOnR(DisposableBag bag) {
    disposeOn(bag);
    return value;
  }
}

extension MyStreamSubscriptionExtension<T> on StreamSubscription<T> {
  StreamSubscription<T> disposeOnR(DisposableBag bag) {
    disposeOn(bag);
    return this;
  }
}

extension MyStreamControllerExtension<T> on StreamController<T> {
  StreamController<T> disposeOnR(DisposableBag bag) {
    disposeOn(bag);
    return this;
  }
}

extension MyTimerExtension on Timer {
  Timer syncDisposeOnR(SyncDisposableBag bag) {
    syncDisposeOn(bag);
    return this;
  }

  Timer disposeOnR(DisposableBag bag) {
    disposeOn(bag);
    return this;
  }
}

extension ChangeNotifierDisposeExtension on ChangeNotifier {
  ChangeNotifier syncDisposeOnR(SyncDisposableBag bag) {
    syncDisposeOn(bag);
    return this;
  }

  ChangeNotifier disposeOnR(DisposableBag bag) {
    disposeOn(bag);
    return this;
  }
}
