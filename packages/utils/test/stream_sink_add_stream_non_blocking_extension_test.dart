// ignore_for_file: avoid_print

import 'dart:async';

import 'package:test/test.dart';
import 'package:utils/src/utils_dart/stream_sink_add_stream_non_blocking_extension.dart';

Future<void> main() async {
  test('should add stream', () async {
    final sc = StreamController.broadcast();
    final sc2 = StreamController()
      ..addStreamNonBlocking(sc.stream)
      ..addStreamNonBlocking(sc.stream);
    sc2.stream.listen(
      (event) {
        print('event: $event');
      },
      onError: (error) {
        print('error: $error');
      },
      onDone: () {
        print('done');
      },
    );
    sc.add('Hello');
    sc.add('World');
    sc.addError(Exception());
    sc.add('after error');
  });
}
