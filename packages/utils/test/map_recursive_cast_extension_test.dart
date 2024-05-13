// ignore_for_file: require_trailing_commas

import 'package:test/test.dart';
import 'package:utils/utils_dart/map_recursive_cast_extension.dart';

void main() {
  group('cast map', () {
    test('MapRecursiveCastExtension - castMap', () {
      final map = {'name': 'John', 'age': 30};
      final castedMap = map.castMap();
      expect(castedMap, isA<Map<String, dynamic>>());
      expect(castedMap, equals(map));
    });

    test('MapRecursiveCastExtension - castRecursive', () {
      final map = {
        'name': 'John',
        'age': 30,
        'address': {'city': 'New York'}
      };
      final castedMap = map.castRecursive<String>();
      expect(castedMap, isA<Map<String, dynamic>>());
      expect(castedMap['address'], isA<Map<String, dynamic>>());

      expect(castedMap, equals(map));
    });

    test('MapRecursiveCastExtension - castRecursiveMap', () {
      final map = {
        'name': 'John',
        'age': 30,
        'address': {'city': 'New York'}
      };
      final castedMap = map.castRecursiveMap();
      expect(castedMap, isA<Map<String, dynamic>>());
      expect(castedMap['address'], isA<Map<String, dynamic>>());

      expect(castedMap, equals(map));
    });

    test('IterableCastExtension - castRecursive', () {
      final list = [
        1,
        2,
        {'name': 'John', 'age': 30}
      ];
      final castedList = list.castRecursive<String>();
      expect(castedList, isA<List>());
      expect(castedList[2], isA<Map<String, dynamic>>());

      expect(castedList, equals(list));
    });

    test('ObjectRecursiveCastExtension - castMap', () {
      final object = {'name': 'John', 'age': 30};
      final castedMap = object.castMap();
      expect(castedMap, isA<Map<String, dynamic>>());
      expect(castedMap, equals(object));
    });

    test('ObjectRecursiveCastExtension - castRecursive', () {
      final object = {
        'name': 'John',
        'age': 30,
        'address': {'city': 'New York'}
      };
      final castedMap = object.castRecursive<String>();
      expect(castedMap, isA<Map<String, dynamic>>());
      expect(castedMap['address'], isA<Map<String, dynamic>>());

      expect(castedMap, equals(object));
    });

    test('ObjectRecursiveCastExtension - castRecursiveMap', () {
      final object = {
        'name': 'John',
        'age': 30,
        'address': {'city': 'New York'}
      };
      final castedMap = object.castRecursiveMap();
      expect(castedMap, isA<Map<String, dynamic>>());
      expect(castedMap['address'], isA<Map<String, dynamic>>());
      expect(castedMap, equals(object));
    });

    test('MapRecursiveCastExtension - castRecursive with nested lists', () {
      final map = {
        'name': 'John',
        'age': 30,
        'address': {'city': 'New York'},
        'hobbies': [
          'reading',
          'coding',
          {'name': 'painting', 'category': 'art'}
        ]
      };
      final castedMap = map.castRecursive<String>();
      expect(castedMap, isA<Map<String, dynamic>>());
      expect(castedMap['address'], isA<Map<String, dynamic>>());
      expect(castedMap['hobbies'], isA<List>());
      expect(castedMap['hobbies'][2], isA<Map<String, dynamic>>());
      expect(castedMap, equals(map));
    });
  });
}
