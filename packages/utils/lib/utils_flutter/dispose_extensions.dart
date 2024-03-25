import 'package:disposing/disposing_dart.dart';
import 'package:disposing/disposing_flutter.dart';
import 'package:flutter/widgets.dart';

extension ChangeNotifierDisposeExtension on ChangeNotifier {
  ChangeNotifier syncDisposeOnR(SyncDisposableBag bag) {
    syncDisposeOn(bag);
    return this;
  }

  ChangeNotifier disposeOnR(DisposableBag bag) {
    disposeOn(bag);
    return this;
  }
}
