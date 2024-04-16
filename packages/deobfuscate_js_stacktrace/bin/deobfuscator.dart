import 'package:source_maps/source_maps.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:source_map_stack_trace/source_map_stack_trace.dart';
import 'segment.dart';

abstract class Deobfuscator {
  List<String> deobfuscate(Segment segment, Mapping mapping);
}

class TraceDeobfuscator extends Deobfuscator {
  @override
  List<String> deobfuscate(Segment segment, Mapping mapping) {
    final traceSegment = segment;
    final trace = Trace.parseV8(traceSegment.lines.join('\n'));
    final deobfuscatedTrace = mapStackTrace(mapping, trace, minified: true);
    return deobfuscatedTrace.toString().split('\n');
  }
}

class StubDeobfuscator extends Deobfuscator {
  @override
  List<String> deobfuscate(Segment segment, Mapping mapping) {
    return segment.lines;
  }
}
