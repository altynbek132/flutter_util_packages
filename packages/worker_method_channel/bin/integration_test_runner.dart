import 'dart:io';
import 'package:utils/utils_dart.dart';

Future<void> main() async {
  final chromeDriverProcess = await runChromeDriver();

  try {
    final compileProcess = await compile();
    if (await compileProcess.exitCode != 0) {
      throw Exception('!!! Failed compile: ${await compileProcess.exitCode}');
    }
    final testProcess = await startTest();
    if (await testProcess.exitCode != 0) {
      throw Exception('!!! Test Failed: ${await compileProcess.exitCode}');
    }
  } finally {
    chromeDriverProcess.kill();
  }
}

Future<Process> runChromeDriver() async {
  await (await startProcess(
    [
      'pip',
      'install',
      'chromedriver-autoinstaller',
    ],
  ))
      .exitCode;
  final p = await startProcess(
    ['python', './bin/setup_chromedriver.py'],
  );
  await p.exitCode;
  return await startProcess(
    ['chromedriver', '--port=4444'],
    runInShell: false,
  );
}

Future<Process> compile() async {
  return await startProcess([
    'compile_dart2js',
    '--pattern=*_js.dart',
    'integration_test',
  ]);
}

Future<Process> startTest() async {
  return await startProcess([
    'flutter',
    'drive',
    '--driver=test_driver/integration_test.dart',
    '--target=integration_test/web_worker_method_channel_test.dart',
    '-d',
    'chrome',
  ]);
}

Future<Process> startProcess(List<String> arguments, {bool runInShell = true}) async {
  final process = await Process.start(
    arguments.first,
    arguments.sublist(1),
    runInShell: runInShell,
  );
  stdout.addStreamNonBlocking(process.stdout);
  stderr.addStreamNonBlocking(process.stderr);
  return process;
}
