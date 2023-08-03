import 'dart:async';

import 'package:disposing/disposing.dart';
import 'package:disposing_flutter/disposing_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:utils/utils.dart';

part 'dragscrollsheet.g.dart';

class DragscrollsheetVm = _DragscrollsheetVmBase with _$DragscrollsheetVm;

abstract class _DragscrollsheetVmBase extends MobxWM with Store, LoggerMixin {
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
    initialChildSizeRef: 0,
    minChildSizeRef: 316 / 812,
    maxChildSizeRef: 707 / 812,
  )..disposeOn(this);

  /// COMPUTED -----------------------------------------------------------------

  /// STREAM REACTION ----------------------------------------------------------

  /// ACTIONS ------------------------------------------------------------------

  /// UTIL METHODS -------------------------------------------------------------

  void _setupLoggers() {
    setupObservableLoggers([
      () => 'initialization: ${initialization.status.name}',
      // () => 'blur: ${blur}',
    ], logger);
  }

  /// CONSTRUCTOR --------------------------------------------------------------
  _DragscrollsheetVmBase() {
    _init();
    _asyncInit().then((_) => notifyInitSuccess()).onErrorNullable(cb: notifyInitError);
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

class _HomePageState extends State<HomePage> with DisposableBagStateMixin {
  final vm = DragscrollsheetVm();

  @override
  void initState() {
    super.initState();
    () async {
      await Future.delayed(const Duration(milliseconds: 100));
      final sub = Stream.periodic(Duration(milliseconds: 100)).listen((event) {
        if (refresh) setState(() {});
      });
      autoDispose(sub.asDisposable());
    }();
  }

  bool refresh = false;

  @override
  Widget build(BuildContext context) {
    return Observer(
        warnWhenNoObservables: false,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Text('DraggableScrollableSheet'),
              ),
              body: Stack(
                children: [
                  SizedBox.expand(
                    child: CustomDraggableScrollableSheet(
                      controller: this.vm.dragScrollController.controllerRaw,
                      initialChildSize: this.vm.dragScrollController.initialChildSize,
                      minChildSize: this.vm.dragScrollController.minChildSize,
                      maxChildSize: this.vm.dragScrollController.maxChildSize,
                      snap: true,
                      builder: (BuildContext context, ScrollController scrollController) {
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
                      TextField(),
                      TextButton(
                          onPressed: () {
                            refresh = !refresh;
                            setState(() {});
                          },
                          child: Text('set refresh: ${!refresh}')),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () => vm.dragScrollController.animateTo(0.5),
                              child: Text('vm.animateTo(0.5)')),
                          TextButton(
                              onPressed: () => vm.dragScrollController.animateTo(0), child: Text('vm.animateTo(0)')),
                          TextButton(
                              onPressed: () => vm.dragScrollController.animateTo(1), child: Text('vm.animateTo(1)')),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(onPressed: () => vm.dragScrollController.close(), child: Text('vm..close()')),
                          TextButton(onPressed: () => vm.dragScrollController.open(), child: Text('vm..open()')),
                          TextButton(
                              onPressed: () => vm.dragScrollController.open(value: 0.6), child: Text('vm..open(0.6)')),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
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
