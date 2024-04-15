import 'dart:async';
import 'dart:typed_data';

import 'package:utils/utils_dart.dart';

/// A class that contains a collection of worker responses.
class Responses {
  Responses._();

  static final responseHandlers = <ResponseHandler>[
    ResponseHandler(
      methodName: 'echo',
      response: (request) async => request,
      responseChecker: (responseOriginal, responseByWorker, expect) {
        expect(responseOriginal, responseByWorker);
        return true;
      },
    ),
    ResponseHandler(
      methodName: 'echoError',
      response: (request) async => throw Exception('echoError'),
      responseChecker: (responseOriginal, responseByWorker, expect) {
        expect(responseOriginal, responseByWorker);
        return true;
      },
    ),
    ResponseHandler(
      methodName: 'returnMap',
      response: (request) async => {'key': 'value'},
      responseChecker: (responseOriginal, responseByWorker, expect) {
        expect(responseOriginal, responseByWorker);
        try {
          (responseByWorker as Map).cast<String, String>();
          return true;
        } on Exception catch (_) {
          return false;
        }
      },
    ),
    ResponseHandler(
      methodName: 'returnList',
      response: (request) async => ['value1', 'value2'],
      responseChecker: (responseOriginal, responseByWorker, expect) {
        try {
          (responseByWorker as List).cast<String>();
          return true;
        } on Exception catch (_) {
          return false;
        }
      },
    ),
    ResponseHandler(
      methodName: 'returnNull',
      response: (request) async => null,
      responseChecker: (responseOriginal, responseByWorker, expect) {
        expect(responseOriginal, responseByWorker);
        return true;
      },
    ),
    ResponseHandler(
      methodName: 'returnUintList',
      response: (request) async => Uint8List.fromList([1, 2, 3, 4, 5]),
      responseChecker: (responseOriginal, responseByWorker, expect) {
        expect(responseOriginal, responseByWorker);
        return true;
      },
    ),
    ResponseHandler(
      methodName: 'returnComplex',
      response: (request) async {
        final uint8list = Uint8List.fromList([1, 2, 3, 4, 5]);
        final map = {'key1': 'value1', 'key2': uint8list};
        return {
          'list': [map, map],
          'map': map,
          'null': null,
          'uint8list': uint8list,
        };
      },
      responseChecker: (responseOriginal, responseByWorker, expect) {
        try {
          final map = (responseByWorker as Map).castMap();
          final list = (map['list'] as List).map((e) => (e as Map).castMap()).toList();
          return list[0]['key2'] is Uint8List;
        } on Exception catch (_) {
          return false;
        }
      },
    ),
  ];
}

/// A function type used to check the response of a method call.
typedef ResponseChecker = bool Function(
    Object? responseOriginal, Object? responseByWorker, void Function(dynamic a, dynamic b) expect);

/// A helper class for testing responses of method calls.
class ResponseHandler {
  final String methodName;

  final Object? requestBody;

  final Future<Object?> Function(Object? request) response;

  /// always returns boolean
  final ResponseChecker responseChecker;

  /// Creates a new instance of [ResponseHandler].
  ///
  /// The [methodName] is the name of the method being tested.
  /// The [response] is a function that takes a request object and returns a future response object.
  /// The [responseChecker] is a function that checks if the original response matches the response received by the worker. It can return Boolean or throw an exception.
  ResponseHandler({
    required this.methodName,
    this.requestBody,
    required this.response,
    required ResponseChecker responseChecker,
  }) : responseChecker = ((responseOriginal, responseByWorker, expect) => onErrorSync(
              (() => responseChecker(responseOriginal, responseByWorker, expect)),
              (error, stackTrace) => false,
            ));
}
