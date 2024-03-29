import 'dart:async';
import 'dart:typed_data';

import 'package:utils/utils_dart.dart';

/// A class that contains a collection of worker responses.
class Responses {
  Responses._();

  /// A map that stores worker responses.
  static final Map<
      String,
      ({
        Future<Object?> Function(Object? request) response,
        bool Function(Object? object)? responseTypeChecker,
      })> workerResponses = {
    /// A response that echoes the request body.
    'echo': (response: (body) async => body, responseTypeChecker: null),

    /// A response that throws an exception with the message 'echoError'.
    'echoError': (response: (body) async => throw Exception('echoError'), responseTypeChecker: null),

    /// A response that returns a map with a single key-value pair.
    'returnMap': (
      response: (body) async => {'key': 'value'},
      responseTypeChecker: (response) {
        try {
          (response as Map).cast<String, String>();
          return true;
        } on Exception catch (_) {
          return false;
        }
      }
    ),

    /// A response that returns a list of strings.
    'returnList': (
      response: (body) async => ['value1', 'value2'],
      responseTypeChecker: (response) {
        try {
          (response as List).cast<String>();
          return true;
        } on Exception catch (_) {
          return false;
        }
      }
    ),

    /// A response that returns null.
    'returnNull': (response: (body) async => null, responseTypeChecker: null),

    /// A response that returns a Uint8List.
    'returnUintList': (
      response: (body) async => Uint8List.fromList([1, 2, 3, 4, 5]),
      responseTypeChecker: (response) => response is Uint8List
    ),

    /// A response function named 'returnComplex' that returns a complex data structure.
    'returnComplex': (
      response: (body) async {
        final uint8list = Uint8List.fromList([1, 2, 3, 4, 5]);
        final map = {'key1': 'value1', 'key2': uint8list};
        return {
          'list': [map, map],
          'map': map,
          'null': null,
          'uint8list': uint8list,
        };
      },
      responseTypeChecker: (response) {
        try {
          final map = (response as Map).castMap();
          final list = (map['list'] as List).map((e) => (e as Map).castMap()).toList();
          return list[0]['key2'] is Uint8List;
        } on Exception catch (_) {
          return false;
        }
      }
    ),
  };
}
