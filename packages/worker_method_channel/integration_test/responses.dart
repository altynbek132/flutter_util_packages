import 'dart:async';
import 'dart:typed_data';

class Responses {
  Responses._();

  static final workerResponses = <String, Future<Object?> Function(Object? body)>{
    'echo': (body) async => body,
    'echoError': (body) async => throw Exception('echoError'),
    'returnMap': (body) async => {'key': 'value'},
    'returnList': (body) async => ['value1', 'value2'],
    'returnNull': (body) async => null,
    'returnUintList': (body) async => Uint8List.fromList([1, 2, 3, 4, 5]),
  };
}
