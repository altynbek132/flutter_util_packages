// ignore_for_file: avoid_print

import 'package:example/error_serializer_registry.dart';
import 'package:flutter/material.dart';
import 'package:worker_method_channel/worker_method_channel.dart';

Future<void> main() async {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final WebWorkerMethodChannel channel;

  @override
  void initState() {
    super.initState();
    () async {
      channel = WebWorkerMethodChannel(
        scriptURL: './web/worker_js.dart.js',
        serializerRegistry: serializerRegistry,
      );
      channel.setMethodCallHandler('echo', (request) {
        print("🚀~main.dart:29~_MainAppState~");
        return request;
      });
    }();
  }

  Future<void> test() async {
    final res = await channel.invokeMethod('echo', 'hi');
    print("🚀~main.dart:33~_MainAppState~Future<void>test~res: ${res}");
  }

  @override
  void dispose() {
    channel.disposeAsync();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Hello World!'),
              TextButton(
                onPressed: () {
                  test();
                },
                child: const Text('test()'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
