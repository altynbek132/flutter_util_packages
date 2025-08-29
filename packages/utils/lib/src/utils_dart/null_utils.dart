import 'package:utils/utils_dart.dart';

T? nullOnException<T>(T Function() f) {
  try {
    return f();
  } catch (e) {
    _logLineFromStackTrace(getLogger('').e, depth: 2, message: e);
    return null;
  }
}

void _logLineFromStackTrace(
  void Function(Object message) print, {
  Object? message,
  int? depth,
  bool? full,
}) {
  final str = () {
    if (full ?? false) {
      return StackTrace.current.toString();
    }
    return StackTrace.current
        .toString()
        .split('\n')[depth ?? 2]
        .split(' ')
        .map((e) => e.trim())
        .where((element) => element.isNotEmpty)
        .skip(1)
        .join(' ');
  }();
  print('${message ?? ''}: trace: ${str}');
}

extension ObjectExtension on Object? {
  bool get isNull => this == null;
  bool get isNotNull => !isNull;
}
