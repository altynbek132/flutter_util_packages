import 'dart:convert';
import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:utils/utils_dart.dart';

@internal
class BigIntWrapper {
  static const key = 'BigIntWrapper';
  final BigInt value;

  BigIntWrapper(this.value);

  Obj toJson() {
    return {key: jsonEncode(value.toString())};
  }

  static BigIntWrapper fromJson(Obj json) {
    final valueString = jsonDecode(json[key]);
    return BigIntWrapper(BigInt.parse(valueString));
  }

  static bool isBigIntWrapper(Obj json) {
    return json.containsKey(key);
  }
}

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
