import 'dart:async';
import 'dart:math' as math;

import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart';
import 'package:rxdart/rxdart.dart';

final seed = math.Random();

double randomDouble() => (500 - seed.nextInt(1000)) / 1000;

extension ListExtension<T> on List<T>? {
  List<T> get eff => this ?? [];
}

extension StringExtension on String? {
  String get eff => this ?? '';
}

extension ObservableListExtension<T> on ObservableList<T>? {
  ObservableList<T> get eff => this ?? <T>[].asObservable();
}

extension ObsFutureExtension<T> on Observable<ObservableFuture<T>> {
  set future(Future<T> future) {
    value = value.replace(future);
  }

  ObservableFuture<T> get future {
    return value;
  }

  T? get result {
    return value.value;
  }
}

Future<List<T>> futureWait<T>(
  Iterable<FutureOr<T>> futures, {
  bool eagerError = false,
  void Function(T successValue)? cleanUp,
}) =>
    Future.wait(
      futures.map((e) => (() async => await e)()),
      eagerError: eagerError,
      cleanUp: cleanUp,
    );

T? nullOnException<T>(T Function() f) {
  try {
    return f();
  } catch (e) {
    logFunction(Logger().e, depth: 2, message: e);
    return null;
  }
}

void logFunction(
  void Function(Object message) print, {
  Object? message,
  int? depth,
  bool? full,
}) {
  final str = () {
    if (full ?? false) {
      return StackTrace.current.toString();
    }
    return StackTrace.current
        .toString()
        .split('\n')[depth ?? 2]
        .split(' ')
        .map((e) => e.trim())
        .where((element) => element.isNotEmpty)
        .skip(1)
        .join(' ');
  }();
  print('${message ?? ''}: trace: ${str}');
}

extension StreamExtension<T> on Stream<T> {
  Stream<T> get skipError => handleError((e, st) {});
}

extension FutureExtension<T> on Future<T> {
  Future<T> sideEffect(
    FutureOr Function(T result) cb, {
    bool? shouldRethrow,
    bool? shouldAwait,
  }) =>
      then((result) async {
        try {
          final f = cb(result);
          if (shouldAwait ?? false) {
            await f;
          }
          // todo Altynbek: check error log
        } catch (e) {
          if (shouldRethrow ?? false) {
            rethrow;
          }
        }
        return result;
      });

  /// [FutureExtensions.onError]
  Future<T?> onErrorNullable<E extends Object>({
    FutureOr<void> Function(E e, StackTrace st)? cb,
    bool Function(E e)? test,
    bool? shouldRethrow,
  }) async {
    try {
      return await this;
    } catch (e, st) {
      if (e is E && (test == null || test(e))) {
        await cb?.call(e, st);
        if (shouldRethrow ?? false) rethrow;
        return null;
      }
      rethrow;
    }
  }

  /// [FutureExtensions.onError]
  Future<T> onErrorWithRethrow<E extends Object>({
    FutureOr<void> Function(E e, StackTrace st)? cb,
    bool Function(E e)? test,
  }) async {
    try {
      return await this;
    } catch (e, st) {
      if (e is E && (test == null || test(e))) {
        await cb?.call(e, st);
        rethrow;
      }
      rethrow;
    }
  }
}

extension DebounceExtensions<T> on Stream<T> {
  Stream<T> debounceTimeWithFirst(Duration duration) {
    var isFirst = true;
    StreamSubscription<bool>? sub;
    void scheduleReset() {
      sub?.cancel();
      sub = TimerStream(true, duration).listen((_) => isFirst = true);
    }

    return debounce((_) {
      scheduleReset();
      if (isFirst) {
        isFirst = false;
        return TimerStream(true, const Duration());
      }
      return TimerStream(true, duration);
    });
  }
}
