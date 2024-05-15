import 'package:test/test.dart';
import 'package:utils/utils_dart.dart';
import 'package:worker_method_channel/src/bigint_wrapper.dart';

void main() {
  group('BigIntWrapper', () {
    test('toJson should return a valid JSON object', () {
      final wrapper = BigIntWrapper(BigInt.from(42));
      final json = wrapper.toJson();

      expect(json, isA<Obj>());
      expect(json.containsKey(BigIntWrapper.key), isTrue);
      expect(json[BigIntWrapper.key], equals('"42"'));
    });

    test('fromJson should return a BigIntWrapper object', () {
      final json = {BigIntWrapper.key: '"42"'};
      final wrapper = BigIntWrapper.fromJson(json);

      expect(wrapper, isA<BigIntWrapper>());
      expect(wrapper.value, equals(BigInt.from(42)));
    });

    test('isBigIntWrapper should return true for a valid JSON object', () {
      final json = {BigIntWrapper.key: '"42"'};
      final isWrapper = BigIntWrapper.isBigIntWrapper(json);

      expect(isWrapper, isTrue);
    });

    test('isBigIntWrapper should return false for an invalid JSON object', () {
      final json = {'otherKey': '"42"'};
      final isWrapper = BigIntWrapper.isBigIntWrapper(json);

      expect(isWrapper, isFalse);
    });
  });

  group('wrapBigIntRecurse', () {
    test('should wrap BigInt values in a JSON object', () {
      final obj = {
        'key1': BigInt.from(42),
        'key2': [BigInt.from(10), BigInt.from(20)],
        'key3': {'nestedKey': BigInt.from(5)},
      };

      final wrappedObj = wrapBigIntRecurse(obj);

      expect(
        wrappedObj,
        equals({
          'key1': {BigIntWrapper.key: '"42"'},
          'key2': [
            {BigIntWrapper.key: '"10"'},
            {BigIntWrapper.key: '"20"'},
          ],
          'key3': {
            'nestedKey': {BigIntWrapper.key: '"5"'},
          },
        }),
      );
    });

    test('should not modify non-BigInt values', () {
      final obj = {
        'key1': 'value1',
        'key2': [1, 2, 3],
        'key3': {'nestedKey': true},
      };

      final wrappedObj = wrapBigIntRecurse(obj);

      expect(wrappedObj, equals(obj));
    });
  });

  group('unWrapBigIntRecurse', () {
    test('should unwrap BigIntWrapper values in a JSON object', () {
      final obj = {
        'key1': {BigIntWrapper.key: '"42"'},
        'key2': [
          {BigIntWrapper.key: '"10"'},
          {BigIntWrapper.key: '"20"'},
        ],
        'key3': {
          'nestedKey': {BigIntWrapper.key: '"5"'},
        },
      };

      final unwrappedObj = unWrapBigIntRecurse(obj);

      expect(
        unwrappedObj,
        equals({
          'key1': BigInt.from(42),
          'key2': [BigInt.from(10), BigInt.from(20)],
          'key3': {'nestedKey': BigInt.from(5)},
        }),
      );
    });

    test('should not modify non-BigIntWrapper values', () {
      final obj = {
        'key1': 'value1',
        'key2': [1, 2, 3],
        'key3': {'nestedKey': true},
      };

      final unwrappedObj = unWrapBigIntRecurse(obj);

      expect(unwrappedObj, equals(obj));
    });
  });
}
