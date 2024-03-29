import 'dart:async';
import 'dart:math' as math;

double randomDouble() => (500 - math.Random.secure().nextInt(1000)) / 1000;

typedef Obj = Map<String, dynamic>;

extension StreamExtension123123<T> on Stream<T> {
  Stream<T> get skipError => handleError((e, st) {});
}

void initLateFields(dynamic) {}
