import 'package:disposing/disposing_dart.dart';
import 'package:worker_method_channel/src/message.dart';

abstract class Worker {
  bool get isMainThread;
  void postMessage(Message message);
  void terminate();

  SyncDisposable addEventListener(
    void Function(Message data) listener, [
    void Function(Object?)? onError,
  ]);
}
