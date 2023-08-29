import 'dart:async';

import 'package:disposing/disposing.dart';
import 'package:disposing/src/disposables/async_disposables.dart';
import 'package:disposing/src/extensions.dart';

class _AsyncWrapperDisposable extends AsyncDisposable {
  _AsyncWrapperDisposable(Disposable disposable) {
    AsyncDisposable disp;
    if (disposable is SyncDisposable) {
      disp = disposable.asAsync();
    } else if (disposable is AsyncDisposable) {
      disp = disposable;
    } else {
      throw UnknownDisposableException(disposable);
    }

    this.disposable = disposable;
    this._asyncDisposable = disp;
  }

  late final Disposable disposable;
  late final AsyncDisposable _asyncDisposable;

  @override
  bool get isDisposing => _asyncDisposable.isDisposing;

  @override
  bool get isDisposed => _asyncDisposable.isDisposed;

  @override
  Future<void> disposeAsync() {
    return _asyncDisposable.disposeAsync();
  }
}

class DisposableBag implements AsyncDisposable {
  late final AsyncCallbackDisposable _disposable = AsyncCallbackDisposable(_disposeInternal);
  final _disposables = <_AsyncWrapperDisposable>[];

  @override
  bool get isDisposing => _disposable.isDisposing;

  @override
  bool get isDisposed => _disposable.isDisposed;

  @override
  void throwIfNotAvailable([String? target]) {
    _disposable.throwIfNotAvailable(target);
  }

  void add(Disposable disposable) {
    disposable.throwIfNotAvailable();
    throwIfNotAvailable('add');
    _disposables.add(_AsyncWrapperDisposable(disposable));
  }

  void remove(Disposable disposable) {
    throwIfNotAvailable('remove');
    for (final d in _disposables) {
      if (d.disposable == disposable) {
        _disposables.remove(d);
        return;
      }
    }
  }

  void clear() {
    throwIfNotAvailable('clear');
    _disposables.clear();
  }

  @override
  Future<void> disposeAsync() {
    return _disposable.disposeAsync();
  }

  Future<void> _disposeInternal() async {
    final Map<Disposable, Object> exs = {};
    for (final d in _disposables) {
      try {
        await d.disposeAsync();
      } on Object catch (e) {
        exs[d.disposable] = e;
      }
    }

    _disposables.clear();

    if (exs.isNotEmpty) {
      throw BagAggregateException(exs);
    }
  }
}
