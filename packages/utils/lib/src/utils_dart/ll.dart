import 'package:l/l.dart';

final ll = l;

extension LExtension on L {
  /// Error [message] with verbose level 1
  void ee(Object? message, [StackTrace? stackTrace, LogMessageContext? context]) {
    e(message.toString(), stackTrace, context);
  }
}
