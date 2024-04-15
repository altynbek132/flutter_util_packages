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
      responseChecker: (responseOriginal, responseByWorker, expect) => expect(responseOriginal, responseByWorker),
    ),
    ResponseHandler(
      methodName: 'echoError',
      response: (request) async => throw Exception('echoError'),
      responseChecker: (responseOriginal, responseByWorker, expect) => expect(responseOriginal, responseByWorker),
    ),
    ResponseHandler(
      methodName: 'returnMap',
      response: (request) async => {'key': 'value'},
      responseChecker: (responseOriginal, responseByWorker, expect) {
        expect(responseOriginal, responseByWorker);
        (responseByWorker as Map).cast<String, String>();
      },
    ),
    ResponseHandler(
      methodName: 'returnList',
      response: (request) async => ['value1', 'value2'],
      responseChecker: (responseOriginal, responseByWorker, expect) {
        expect(responseOriginal, responseByWorker);
        (responseByWorker as List).cast<String>();
      },
    ),
    ResponseHandler(
      methodName: 'returnNull',
      response: (request) async => null,
      responseChecker: (responseOriginal, responseByWorker, expect) => expect(responseOriginal, responseByWorker),
    ),
    ResponseHandler(
      methodName: 'returnUintList',
      response: (request) async => Uint8List.fromList([1, 2, 3, 4, 5]),
      responseChecker: (responseOriginal, responseByWorker, expect) {
        expect(responseOriginal, responseByWorker);
        assert(responseByWorker is Uint8List);
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
        expect(responseOriginal, responseByWorker);
        final map = (responseByWorker as Map).castMap();
        final list = (map['list'] as List).map((e) => (e as Map).castMap()).toList();
        assert(list[0]['key2'] is Uint8List);
      },
    ),
  ];
}

/// A function type used to check the response of a method call.
typedef ResponseChecker<T> = T Function(
  Object? responseOriginal,
  Object? responseByWorker,
  void Function(dynamic a, dynamic b) expect,
);

/// A helper class for testing responses of method calls.
class ResponseHandler {
  final String methodName;

  final Object? requestBody;

  final Future<Object?> Function(Object? request) response;

  /// always returns boolean
  final ResponseChecker<bool> responseChecker;

  /// Creates a new instance of [ResponseHandler].
  ///
  /// The [methodName] is the name of the method being tested.
  /// The [response] is a function that takes a request object and returns a future response object.
  /// The [responseChecker] is a function that checks if the original response matches the response received by the
  /// worker. It can should throw an exception.
  ResponseHandler({
    required this.methodName,
    this.requestBody,
    required this.response,
    required ResponseChecker<void> responseChecker,
  }) : responseChecker = ((responseOriginal, responseByWorker, expect) {
          return onErrorSync(
            () {
              responseChecker(responseOriginal, responseByWorker, expect);
              return true;
            },
            (error, stackTrace) => false,
          );
        });
}
