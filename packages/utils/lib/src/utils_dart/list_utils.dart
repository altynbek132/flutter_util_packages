import 'dart:typed_data';

import 'package:utils/utils_dart.dart';
import 'dart:math' as math;

import 'index_start_end.dart';

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

extension IterableSeparatedExtension<T> on Iterable<T> {
  Iterable<T> separated(T separator) sync* {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return;
    yield iterator.current;
    while (iterator.moveNext()) {
      yield separator;
      yield iterator.current;
    }
  }
}

extension ListEdgesExtension<T> on List<T> {
  (V?, V?) edges<V>([V? Function(T? value)? selector]) {
    selector ??= (value) => value as V?;
    return (selector(firstOrNull), selector(lastOrNull));
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

extension SliceExtension<T> on List<T> {
  List<T> slice_(int start, [int? end]) {
    final (start_, end_) = indexStartEnd(length, start, end);
    return sublist(start_, end_);
  }
}

extension SliceUint8Extension on Uint8List {
  Uint8List slice_(int start, [int? end]) {
    final (start_, end_) = indexStartEnd(length, start, end);
    return sublist(start_, end_);
  }
}

extension SliceUint32Extension on Uint32List {
  Uint32List slice_(int start, [int? end]) {
    final (start_, end_) = indexStartEnd(length, start, end);
    return sublist(start_, end_);
  }
}

extension ListExtension<T> on List<T> {
  T get random => this[math.Random().nextInt(length)];
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

extension ListExtensionEff<T> on List<T>? {
  List<T> get eff => this ?? [];
}
