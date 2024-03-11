import 'package:disposing/disposing.dart';
import 'package:worker_method_channel/src/message.dart';

abstract class WorkerBase {
  void postMessage(Message message);
  void terminate();

  SyncDisposable addEventListener(
    void Function(Message data) listener, [
    void Function(Object?)? onError,
  ]);
}
