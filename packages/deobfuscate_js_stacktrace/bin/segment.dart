import 'package:source_maps/source_maps.dart';

import 'deobfuscator.dart';

abstract class Segment {
  static final _v8TraceLine = RegExp(r'    ?at ');

  final Deobfuscator? deobfuscator;

  Segment([this.deobfuscator]);

  factory Segment.fromLine(String line) {
    if (_v8TraceLine.hasMatch(line)) {
      return TraceSegment([line], TraceDeobfuscator());
    } else {
      return PlainSegment([line]);
    }
  }

  List<String> get lines;

  PlainSegment deobfuscate(Mapping mapping) {
    return PlainSegment(deobfuscator?.deobfuscate(this, mapping) ?? lines);
  }

  bool isMatch(String line);
}

class PlainSegment extends Segment {
  @override
  final List<String> lines;

  PlainSegment(this.lines);

  @override
  bool isMatch(String line) {
    return !Segment._v8TraceLine.hasMatch(line);
  }
}

class TraceSegment extends Segment {
  @override
  final List<String> lines;

  TraceSegment(this.lines, super.deobfuscator);

  @override
  bool isMatch(String line) {
    return Segment._v8TraceLine.hasMatch(line);
  }
}
