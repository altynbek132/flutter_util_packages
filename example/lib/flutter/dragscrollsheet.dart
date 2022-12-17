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

  late final dragScrollController = DraggableScrollableControllerWrapper(
    initialChildSizeRef: 316 / 812,
    minChildSizeRef: 316 / 812,
    maxChildSizeRef: 707 / 812,
  )..disposeWithVm(this);

  /// COMPUTED -----------------------------------------------------------------

  /// STREAM REACTION ----------------------------------------------------------

  /// ACTIONS ------------------------------------------------------------------

  /// UTIL METHODS -------------------------------------------------------------

  void _setupLoggers() {
    setupObservableLoggers([
      () => 'initialization: ${initialization.status.name}',
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
              child: Observer(builder: (context) {
                final vm = this.vm.dragScrollController;
                return DraggableScrollableSheet(
                  controller: vm.controllerRaw,
                  initialChildSize: vm.initialChildSize,
                  minChildSize: vm.minChildSize,
                  maxChildSize: vm.maxChildSize,
                  snap: true,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
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
                );
              }),
            ),
            Column(
              children: [
                Row(
                  children: [
                    TextButton(
                        onPressed: () => vm.dragScrollController.animateTo(0.5),
                        child: Text('vm.animateTo(0.5)')),
                    TextButton(
                        onPressed: () => vm.dragScrollController.animateTo(0),
                        child: Text('vm.animateTo(0)')),
                    TextButton(
                        onPressed: () => vm.dragScrollController.animateTo(1),
                        child: Text('vm.animateTo(1)')),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () => vm.dragScrollController.close(),
                        child: Text('vm..close()')),
                    TextButton(
                        onPressed: () => vm.dragScrollController.open(),
                        child: Text('vm..open()')),
                  ],
                ),
              ],
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
