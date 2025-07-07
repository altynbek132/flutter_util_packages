import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';

class RxDb {
  final FlutterSecureStorage storage;

  RxDb({required this.storage});

  final streams = <String, BehaviorSubject<String?>>{};

  Future<void> write({
    required String key,
    required String value,
  }) async {
    await storage.write(key: key, value: value);
    streams[key]?.add(value);
  }

  Stream<String?> read({
    required String key,
  }) {
    if (streams[key] == null) {
      streams[key] = BehaviorSubject<String?>();
      storage.read(key: key).then((value) => streams[key]!.add(value));
    }
    return streams[key]!.stream;
  }
}
