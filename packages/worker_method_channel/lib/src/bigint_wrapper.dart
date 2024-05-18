import 'dart:convert';
import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:utils/utils_dart.dart';

/// A wrapper class for [BigInt] that provides serialization and deserialization methods.
@internal
class BigIntWrapper {
  static const key = 'BigIntWrapper';
  final BigInt value;

  /// Constructs a [BigIntWrapper] with the given [value].
  BigIntWrapper(this.value);

  /// Converts the [BigIntWrapper] to a JSON object.
  Obj toJson() {
    return {key: jsonEncode(value.toString())};
  }

  /// Creates a [BigIntWrapper] from a JSON object.
  static BigIntWrapper fromJson(Obj json) {
    final valueString = jsonDecode(json[key]);
    return BigIntWrapper(BigInt.parse(valueString));
  }

  /// Checks if the given JSON object is a [BigIntWrapper].
  static bool isBigIntWrapper(Obj json) {
    return json.containsKey(key);
  }
}

/// Recursively wraps [BigInt] objects in a JSON-compatible format.
@internal
dynamic wrapBigIntRecurse(dynamic obj) {
  if (obj is BigInt) {
    return BigIntWrapper(obj).toJson();
  }
  if (obj is Map) {
    return obj.map((key, value) => MapEntry(key, wrapBigIntRecurse(value)));
  }
  if (obj is List && obj is! TypedData) {
    return obj.map((e) => wrapBigIntRecurse(e)).toList();
  }
  return obj;
}

/// Recursively unwraps [BigIntWrapper] objects from a JSON-compatible format.
@internal
dynamic unWrapBigIntRecurse(dynamic obj) {
  if (obj is Map) {
    if (BigIntWrapper.isBigIntWrapper(obj.castMap())) {
      return BigIntWrapper.fromJson(obj.castMap()).value;
    }
    return obj.map((key, value) => MapEntry(key, unWrapBigIntRecurse(value)));
  }
  if (obj is List && obj is! TypedData) {
    return obj.map((e) => unWrapBigIntRecurse(e)).toList();
  }
  return obj;
}
