import 'segment.dart';

/// Splits the input string into a list of [Segment] objects.
///
/// The [input] parameter is the string to be split.
///
/// Returns a list of [Segment] objects representing the split traces.
List<Segment> splitTraces(String input) {
  final List<Segment> segments = [];
  final List<String> lines = input.split('\n');

  Segment? currentSegment;
  for (String line in lines) {
    if (currentSegment != null && currentSegment.isMatch(line)) {
      currentSegment.lines.add(line);
      continue;
    }
    if (currentSegment != null) {
      segments.add(currentSegment);
    }
    currentSegment = Segment.fromLine(line);
  }

  if (currentSegment != null) {
    segments.add(currentSegment);
  }

  return segments;
}
