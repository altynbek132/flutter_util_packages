import 'package:disposing/disposing_dart.dart';
import 'package:yx_scope/yx_scope.dart';

abstract class YxScopeControllerBase with DisposableBag implements AsyncLifecycle {
  bool? _disposeCalledForBag;

  @override
  Future<void> dispose() async {
    if (_disposeCalledForBag == true) {
      return;
    }
    _disposeCalledForBag = false;
    return disposeAsync();
  }

  @override
  Future<void> disposeAsync() async {
    if (_disposeCalledForBag == false) {
      return;
    }
    _disposeCalledForBag = true;
    await super.disposeAsync();
    return dispose();
  }
}
