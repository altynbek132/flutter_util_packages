import 'dart:async';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:disposing/disposing.dart';
import 'package:disposing_flutter/disposing_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:utils/utils.dart';

part 'bottom_sheet_drag_scroll.g.dart';

class BottomSheetDragScroll = _BottomSheetDragScrollBase with _$BottomSheetDragScroll;

abstract class _BottomSheetDragScrollBase extends MobxWM with Store, LoggerMixin {
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

  /// COMPUTED -----------------------------------------------------------------

  /// STREAM REACTION ----------------------------------------------------------

  /// ACTIONS ------------------------------------------------------------------

  DraggableScrollableController? c;

  void close() {
    Navigator.pop(sheetContext!);
  }

  BuildContext? sheetContext;

  void showBottomSheet1() {
    showFlexibleBottomSheet(
      isModal: false,
      isDismissible: false,
      isCollapsible: false,
      minHeight: .3,
      initHeight: .3,
      maxHeight: .8,
      anchors: [0.5, .8],
      isSafeArea: true,
      context: bContext,
      builder: (context, scrollController, bottomSheetOffset) {
        sheetContext = context;
        return Container(
          color: Colors.blue[100],
          child: ListView.builder(
            controller: scrollController,
            itemCount: 25,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return TextButton(
                  onPressed: () => close(),
                  child: Text('close'),
                );
              }
              return ListTile(title: Text('Item $index'));
            },
          ),
        );
      },
    );
  }

  /// UI -----------------------------------------------------------------------

  /// UTIL METHODS -------------------------------------------------------------

  void _setupLoggers() {
    setupObservableLoggers([
      () => 'initialization: ${initialization.status.name}',
    ], logger);
  }

  /// CONSTRUCTOR --------------------------------------------------------------

  BuildContext Function()? getContext;

  BuildContext get bContext => getContext!();

  _BottomSheetDragScrollBase() {
    _init();
    _asyncInit().then((_) => notifyInitSuccess()).onErrorNullable(cb: notifyInitError);
  }
}

Future<void> dispose(BottomSheetDragScroll instance) async => instance.disposeAsync();

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with DisposableBagStateMixin {
  late final vm = BottomSheetDragScroll();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SafeArea(
        child: Stack(
          children: [
            Scaffold(
              body: Builder(builder: (context) {
                vm.getContext = () => context;
                return Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.red,
                  ),
                );
              }),
            ),
            Column(
              children: [
                TextButton(
                  onPressed: () => vm.showBottomSheet1(),
                  child: Text('showBottomSheet1'),
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
