import 'package:disposing/disposing_dart.dart';
import 'package:yx_scope/yx_scope.dart';

abstract class YxControllerBase with DisposableBag implements AsyncLifecycle {
  bool _disposed = false;

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    await super.disposeAsync();
  }

  @override
  Future<void> disposeAsync() async {
    await dispose();
  }
}
