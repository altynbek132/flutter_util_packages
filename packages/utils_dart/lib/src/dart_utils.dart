import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:logger/logger.dart';
import 'package:mobx/mobx.dart' hide Listenable;
import 'package:rxdart/rxdart.dart';
import 'package:utils_dart/src/loggers/logger_mixin.dart';

final seed = math.Random();

double randomDouble() => (500 - seed.nextInt(1000)) / 1000;

extension MapRecursiveCastExtension on Map {
  Map<String, dynamic> castMap() {
    return cast<String, dynamic>();
  }

  Map<K, dynamic> castRecursive<K>() {
    return map((key, value) {
      if (value is Map) {
        return MapEntry(key as K, value.castRecursive<K>());
      }
      return MapEntry(key as K, value);
    }).cast<K, dynamic>();
  }

  Map<String, dynamic> castRecursiveMap() {
    return castRecursive<String>();
  }
}

extension DynamicRecursiveCastExtension on Object {
  Map<String, dynamic> castMap() {
    return (this as Map).cast<String, dynamic>();
  }

  Map<K, dynamic> castRecursive<K>() {
    return (this as Map).castRecursive<K>();
  }

  Map<String, dynamic> castRecursiveMap() {
    return castRecursive<String>();
  }
}

extension ListInsrtionExtension<T> on List<T> {
  set addLast(T value) {
    add(value);
  }

  set addAllSetter(Iterable<T> value) {
    addAll(value);
  }

  set replaceAll(Iterable<T> value) {
    value = value.toList();
    clear();
    addAll(value);
  }
}

extension ListEdgesExtension<T> on List<T> {
  (V?, V?) edges<V>([V? Function(T? value)? selector]) {
    selector ??= (value) => value as V?;
    return (selector(firstOrNull), selector(lastOrNull));
  }
}

extension StringDupExtension on String {
  String dup(int count) {
    return List.generate(count, (index) => this).join(' ');
  }
}

extension ListDupExtension<T> on List<T> {
  List<T> dup([int count = 1]) {
    final res = <T>[];
    for (final el in List.generate(count, (index) => this)) {
      res.addAll(el);
    }
    return res;
  }

  T? elementAtOrNullSafe(int index) {
    if (index < 0 || index >= length) {
      return null;
    }
    return elementAt(index);
  }
}

Observable<T> makeObs<T>(T value) => Observable<T>(value);

Observable<T?> makeObsNull<T>([T? value]) => Observable<T?>(value);

typedef Obj = Map<String, dynamic>;

void configMobx([bool? spy]) {
  spy ??= false;
  final logger = getLogger('MOBX');
  mainContext
    ..config = mainContext.config.clone(
      writePolicy: ReactiveWritePolicy.never,
      isSpyEnabled: spy, /* disableErrorBoundaries: true */
    )
    ..spy((event) {
      if (spy!) logger.i('event: ${event}');
    });
}

(int start, int end) _ind(int length, int start, [int? end]) {
  end ??= length;
  if (end > length) {
    end = length;
  }
  if (start > length) {
    start = length;
  }
  if (end < 0) {
    end = length + end;
  }
  if (start < 0) {
    start = length + start;
  }
  if (start > end) {
    start = end;
  }
  return (start, end);
}

extension SliceExtension<T> on List<T> {
  List<T> slice_(int start, [int? end]) {
    final (start_, end_) = _ind(length, start, end);
    return sublist(start_, end_);
  }
}

extension SliceUint8Extension on Uint8List {
  Uint8List slice_(int start, [int? end]) {
    final (start_, end_) = _ind(length, start, end);
    return sublist(start_, end_);
  }
}

extension SliceUint32Extension on Uint32List {
  Uint32List slice_(int start, [int? end]) {
    final (start_, end_) = _ind(length, start, end);
    return sublist(start_, end_);
  }
}

extension FutureExtension<T> on Future<T> {
  Future<T> withCompleter(Completer<void> c) {
    return thenSideEffect((result) => c.complete()).onErrorWithRethrow(cb: (e, st) => c.completeError(e!, st));
  }
}

extension StringExtension on String {
  String substring_(int start, [int? end]) {
    if (end != null && end < 0) {
      end = length + end;
    }

    final (start_, end_) = _ind(length, start, end);
    return substring(start_, end_);
  }

  String substr(int start, [int length = 0]) {
    if (length < 0) {
      length = 0;
    }
    return substring_(start, start + length);
  }
}

extension ListExtension<T> on List<T> {
  T get random => this[math.Random().nextInt(length)];
}

String jsonStr(Object? object, {bool pretty = false}) {
  Object? toEncodable(object) {
    if (object is Completer) {
      return 'Completer';
    }
    if (object is BigInt) {
      return object.toString();
    }
    return object;
  }

  if (pretty) {
    return JsonEncoder.withIndent(' ', toEncodable).convert(object);
  }
  return json.encode(object, toEncodable: toEncodable);
}

extension ListInsertBetweenAllElements<T> on Iterable<T> {
  List<T> insertBetweenAllElements(T Function(int i, T el) f) {
    final list = toList();
    final result = <T>[];
    for (var i = 0; i < length; i++) {
      result.add(list[i]);
      if (i != length - 1) {
        result.add(f(i, list[i]));
      }
    }
    return result;
  }
}

extension ListExtension222<T> on List<T>? {
  List<T> get eff => this ?? [];
}

extension StringExtension123 on String? {
  String get eff => this ?? '';
}

extension ObservableListExtension<T> on ObservableList<T>? {
  ObservableList<T> get eff => this ?? <T>[].asObservable();
}

extension ObservableFutureExtension<T> on ObservableFuture<T> {
  bool get isLoading => status == FutureStatus.pending;

  bool get isFulfilled => status == FutureStatus.fulfilled;

  bool get isRejected => status == FutureStatus.rejected;
}

Observable<ObservableFuture<T>?> makeEmptyObsF<T>() {
  return Observable<ObservableFuture<T>?>(null);
}

// extension ObsFutureExtension<T> on Observable<ObservableFuture<T>?> {
//   set futureReplace(Future<T> future) {
//     value = value?.replaced(future) ?? future.asObservable();
//   }

//   set future(Future<T> future) {
//     value = future.asObservable();
//   }

//   T? get result {
//     return value?.value;
//   }
// }

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

var _logFunctionEnabled = false;

void enableLogFunction(bool value) {
  _logFunctionEnabled = value;
}

void logFunction(
  void Function(Object message) print, {
  Object? message,
  int? depth,
  bool? full,
}) {
  if (!_logFunctionEnabled) return;
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

extension StreamExtension123123<T> on Stream<T> {
  Stream<T> get skipError => handleError((e, st) {});
}

extension FutureExtension22<T> on Future<T> {
  Future<T> thenSideEffect(
    FutureOr Function(T result) cb, {
    bool shouldRethrow = false,
    bool shouldAwait = false,
  }) =>
      then((result) async {
        try {
          final f = cb(result);
          if (shouldAwait) {
            await f;
          }
          // todo Altynbek: check error log
        } catch (e) {
          if (shouldRethrow) {
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
