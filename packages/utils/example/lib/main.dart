import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:utils/utils_flutter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CounterScreenWidget());
  }
}

class DemoController extends MobxMVController {
  final counter = Observable(0);

  void increment() {
    runInAction(() {
      counter.value++;
    });
  }

  @override
  Future<void> init() async {
    await super.init();
    // ignore: avoid_print
    print('init');
  }

  @override
  Future<void> disposeAsync() async {
    // ignore: avoid_print
    print('dispose');
    await super.disposeAsync();
  }
}

class CounterScreenWidget extends StatefulWidget {
  const CounterScreenWidget({super.key});

  @override
  State<CounterScreenWidget> createState() => _CounterScreenWidgetState();
}

class _CounterScreenWidgetState extends State<CounterScreenWidget>
    with MobxMVControllerMixin<DemoController, CounterScreenWidget> {
  @override
  DemoController controllerFactory() => DemoController();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('You have pushed the button this many times:'),
                Text('${c.counter.value}', style: Theme.of(context).textTheme.headlineMedium),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: c.increment,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
