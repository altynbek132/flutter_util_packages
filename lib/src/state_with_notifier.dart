import 'package:disposing_flutter/disposing_flutter.dart';
import 'package:flutter/widgets.dart';

abstract class CustomState<T extends StatefulWidget> extends State<T>
    with DisposableBagStateMixin {
  late final initStateNotifier = ChangeNotifier();
  @override
  void initState() {
    autoDispose(initStateNotifier.asDisposable());
    autoDispose(didChangeDependenciesNotifier.asDisposable());
    autoDispose(disposeNotifier.asDisposable());
    autoDispose(activateNotifier.asDisposable());
    autoDispose(deactivateNotifier.asDisposable());
    autoDispose(didUpdateWidgetNotifier.asDisposable());

    initStateNotifier.notifyListeners();
    super.initState();
  }

  final didChangeDependenciesNotifier = ChangeNotifier();
  @override
  void didChangeDependencies() {
    didChangeDependenciesNotifier.notifyListeners();
    super.didChangeDependencies();
  }

  final disposeNotifier = ChangeNotifier();
  @override
  void dispose() {
    disposeNotifier.notifyListeners();
    super.dispose();
  }

  final activateNotifier = ChangeNotifier();
  @override
  void activate() {
    activateNotifier.notifyListeners();
    super.activate();
  }

  final deactivateNotifier = ChangeNotifier();
  @override
  void deactivate() {
    deactivateNotifier.notifyListeners();
    super.deactivate();
  }

  final didUpdateWidgetNotifier = ValueNotifier<T?>(null);
  @override
  void didUpdateWidget(T oldWidget) {
    didUpdateWidgetNotifier.value = oldWidget;
    super.didUpdateWidget(oldWidget);
  }
}
