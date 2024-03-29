import 'dart:async';
import 'dart:typed_data';

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
  };
}
