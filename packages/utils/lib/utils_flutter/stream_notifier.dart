import 'dart:async';

import 'package:flutter/foundation.dart';

/// https://stackoverflow.com/a/71532680
class StreamNotifier extends ChangeNotifier {
  StreamNotifier(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

extension StreamToNotifierExtension<T> on Stream<T> {
  ChangeNotifier toNotifier() {
    return StreamNotifier(this);
  }
}
