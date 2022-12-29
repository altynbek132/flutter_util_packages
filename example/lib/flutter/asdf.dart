import 'package:disposing/disposing.dart';
import 'package:disposing_flutter/disposing_flutter.dart';
import 'package:flutter/material.dart';

class Asdf extends StatefulWidget {
  const Asdf({
    super.key,
  });

  @override
  _AsdfState createState() => _AsdfState();
}

class _AsdfState extends CustomState<Asdf> {
  @override
  Widget build(BuildContext context) {
    final SyncDisposable a = initStateNotifier.addDisposableListener(
      () => 123,
    )..disposeOn(bag);
    return Container();
  }
}
