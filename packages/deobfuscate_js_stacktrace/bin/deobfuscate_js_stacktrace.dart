import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:source_maps/source_maps.dart';

import 'split_traces.dart';

/// A command-line tool to deobfuscate JavaScript stack traces using source maps.
///
/// This tool takes a stack trace file as input and uses the corresponding source map
/// to deobfuscate the stack trace, providing a more readable and meaningful output.
///
/// Usage: deobfuscate.dart <stack-trace-file>
///
/// The <stack-trace-file> should be a text file containing the JavaScript stack trace.
/// It will then load the source map file based on the input file's path and extension.
/// Finally, it will parse the stack trace using the V8 format and apply the source map
/// to generate a deobfuscated Dart stack trace, which will be printed to the console.
///
/// Note: The stack trace file and the corresponding source map file should be in the same directory.
/// The source map file should have the same name as the stack trace file, but with a '.dart.js.map' extension.
///
/// Example usage:
/// ```
/// $ dart deobfuscate_js_stacktrace.dart stack_trace.txt
/// ```
Future<void> main(List<String> args) async {
  if (args.length != 1) {
    print('usage: deobfuscate.dart <stack-trace-file>');
    exit(1);
  }
  final path = p.normalize(args[0]);
  final log = (await File(path).readAsString()).replaceAll('\r\n', '\n');
  final sourceMap = p.joinAll([
    p.dirname(path),
    '${p.basenameWithoutExtension(path)}.dart.js.map',
  ]);

  final mapContents = await File(sourceMap).readAsString();
  final mapping = SingleMapping.fromJson(jsonDecode(mapContents));

  final segments = splitTraces(log);

  final deobfuscated = segments.map((e) => e.deobfuscate(mapping));

  print(deobfuscated.map((e) => e.lines.join('\n')).join('\n'));
}
