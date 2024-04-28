import 'dart:async';
import 'dart:typed_data';

import 'package:utils/utils_dart.dart';
import 'package:worker_method_channel/worker_method_channel.dart';

import 'custom_exception.dart';

/// A class that contains a collection of worker responses.
class Responses {
  Responses._();

  static final responseHandlers = <ResponseHandler>[
    ...basicResponseHandlers,
    ...errorResponseHandlers,
  ];

  static final errorResponseHandlers = <ResponseHandler>[
    ResponseHandler(
      methodName: 'echoError',
      response: (request) async => throw Exception('echoError'),
      exceptionChecker: (exceptionByWorker) {
        return exceptionByWorker.innerExceptionWithType?.exception.toString() == 'Exception: echoError';
      },
    ),
    ResponseHandler(
      methodName: 'custom exception',
      response: (request) async => throw CustomException(message: 'exception message'),
      expectEqualException: true,
      exceptionChecker: (exceptionByWorker) => exceptionByWorker.innerExceptionWithType?.exception is Exception,
    ),
  ];

  static final basicResponseHandlers = <ResponseHandler>[
    ResponseHandler(
      methodName: 'echo',
      response: (request) async => request,
      expectEqualResponse: true,
    ),
    ResponseHandler(
      methodName: 'returnMap',
      response: (request) async => {'key': 'value'},
      expectEqualResponse: true,
      responseChecker: (responseOriginal, responseByWorker) {
        (responseByWorker as Map).cast<String, String>();
      },
    ),
    ResponseHandler(
      methodName: 'returnList',
      response: (request) async => ['value1', 'value2'],
      responseChecker: (responseOriginal, responseByWorker) {
        (responseByWorker as List).cast<String>();
      },
    ),
    ResponseHandler(
      methodName: 'returnNull',
      response: (request) async => null,
      responseChecker: (responseOriginal, responseByWorker) => true,
    ),
    ResponseHandler(
      methodName: 'returnUintList',
      response: (request) async => Uint8List.fromList([1, 2, 3, 4, 5]),
      responseChecker: (responseOriginal, responseByWorker) {
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
      responseChecker: (responseOriginal, responseByWorker) {
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
);

/// A helper class for testing responses of method calls.
class ResponseHandler {
  final String methodName;

  final Object? requestBody;

  final Future<Object?> Function(Object? request) response;

  /// always returns boolean
  final ResponseChecker<bool> responseChecker;

  /// always returns boolean
  final bool Function(WebPlatformException exceptionByWorker)? exceptionChecker;

  final bool expectEqualResponse;
  final bool expectEqualException;

  /// Creates a new instance of [ResponseHandler].
  ///
  /// The [methodName] is the name of the method being tested.
  /// The [response] is a function that takes a request object and returns a future response object.
  /// The [responseChecker] is a function that checks if the original response matches the response received by the
  /// worker. It can should throw an exception.
  ResponseHandler({
    required this.methodName,
    this.requestBody,
    this.expectEqualResponse = true,
    this.expectEqualException = false,
    required this.response,
    ResponseChecker<void>? responseChecker,
    this.exceptionChecker,
  }) : responseChecker = ((responseOriginal, responseByWorker) {
          return onErrorSync(
            () {
              responseChecker?.call(responseOriginal, responseByWorker);
              return true;
            },
            (error, stackTrace) => false,
          );
        });
}
