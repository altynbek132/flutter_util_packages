import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:utils/utils.dart';

part 'dragscrollsheet.g.dart';

class DragscrollsheetVm = _DragscrollsheetVmBase with _$DragscrollsheetVm;

abstract class _DragscrollsheetVmBase with Store, MobxStoreBase, LoggerMixin {
  /// INIT ---------------------------------------------------------------------

  // sync init
  void _init() {
    _setupLoggers();
    initLateFields([]);
  }

  // async init
  Future<void> _asyncInit() async {}

  /// DEPENDENCIES -------------------------------------------------------------

  /// FIELDS -------------------------------------------------------------------

  /// PROXY --------------------------------------------------------------------

  /// OBSERVABLES --------------------------------------------------------------
  final controllerRaw = DraggableScrollableController();
  late final controller = obsFromChangeNotifier(controllerRaw);

  @observable
  late double minChildSize = _minChildSize;
  final double _minChildSize = 0.1;
  @observable
  late double maxChildSize = _maxChildSize;
  final double _maxChildSize = 1;
  @observable
  late double initialChildSize = _initialChildSize;
  final double _initialChildSize = 0.2;

  /// COMPUTED -----------------------------------------------------------------
  @computed
  double get blur {
    if (!controller.value.isAttached) {
      return 0;
    }
    return controller.value.size;
  }

  /// STREAM REACTION ----------------------------------------------------------

  /// ACTIONS ------------------------------------------------------------------
  @action
  Future<void> animateTo(double value) => controller.value.animateTo(value,
      duration: Duration(milliseconds: 1000), curve: Curves.easeInOut);

  @action
  Future<void> jumpTo(double value) async => controller.value.jumpTo(value);

  @action
  Future<void> close() async {
    minChildSize = 0;
    // skip frame paint with min size
    WidgetsBinding.instance.addPostFrameCallback((_) => animateTo(0));
  }

  @action
  Future<void> open() async {
    await animateTo(_minChildSize);
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => minChildSize = _minChildSize);
    initialChildSize = minChildSize = _minChildSize;
  }

  /// UTIL METHODS -------------------------------------------------------------

  void _setupLoggers() {
    setupObservableLoggers([
      () => 'initialization: ${initialization.status.name}',
      () => 'controller: ${controller}',
      // () => 'blur: ${blur}',
    ], log);
  }

  /// CONSTRUCTOR --------------------------------------------------------------
  _DragscrollsheetVmBase() {
    _init();
    _asyncInit()
        .then((_) => notifyInitSuccess())
        .onErrorNullable(cb: notifyInitError);
  }
}

Future<void> dispose(DragscrollsheetVm instance) async => instance.dispose();

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final vm = DragscrollsheetVm();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('DraggableScrollableSheet'),
        ),
        body: Stack(
          children: [
            SizedBox.expand(
              child: DraggableScrollableSheet(
                controller: vm.controllerRaw,
                snap: true,
                minChildSize: vm.minChildSize,
                maxChildSize: vm.maxChildSize,
                initialChildSize: vm.initialChildSize,
                snapSizes: [
                  0.4,
                  0.6,
                ],
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    color: Colors.blue[100],
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: 25,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(title: Text('Item $index'));
                      },
                    ),
                  );
                },
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    TextButton(
                        onPressed: () => vm.animateTo(0.5),
                        child: Text('vm.animateTo(0.5)')),
                    TextButton(
                        onPressed: () => vm.animateTo(0),
                        child: Text('vm.animateTo(0)')),
                    TextButton(
                        onPressed: () => vm.animateTo(1),
                        child: Text('vm.animateTo(1)')),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () => vm.close(), child: Text('vm.close()')),
                    TextButton(
                        onPressed: () => vm.open(), child: Text('vm.open()')),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                child: Observer(builder: (context) {
                  return ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: vm.blur * 3,
                      sigmaY: vm.blur * 3,
                    ),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: FlutterLogo(),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

Future<void> main() async {
  runApp(App());
}
