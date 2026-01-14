import 'package:l/l.dart';

import 'package:utils/utils_dart.dart';

/// A mixin that provides a logger instance.
///
/// This mixin adds a `logger` getter that returns a logger instance based on the runtime type.
/// It uses the `getLogger` function from the `logger` package to create the logger.
mixin LoggerMixin {
  static var useRuntimeType = true;
  LNullable get logger => PrefixedL(useRuntimeType ? runtimeType.toString() : 'LoggerMixin');
}

final class PrefixedL extends LNullable {
  final String prefix;

  factory PrefixedL(String prefix) {
    return PrefixedL.internal(prefix);
  }

  PrefixedL.internal(this.prefix) : super.internal();

  /// A shout [message] is always displayed
  @override
  void s(Object? message, [LogMessageContext? context]) => super.s('$prefix $message', context);

  /// Regular [message] with verbose level 1
  @override
  void v(Object? message, [LogMessageContext? context]) => super.v('$prefix $message', context);

  /// Regular [message] with verbose level 1
  @override
  void v1(Object? message, [LogMessageContext? context]) => super.v1('$prefix $message', context);

  /// Regular [message] with verbose level 2
  @override
  void vv(Object? message, [LogMessageContext? context]) => super.vv('$prefix $message', context);

  /// Regular [message] with verbose level 2
  @override
  void v2(Object? message, [LogMessageContext? context]) => super.v2('$prefix $message', context);

  /// Regular [message] with verbose level 3
  @override
  void vvv(Object? message, [LogMessageContext? context]) => super.vvv('$prefix $message', context);

  /// Regular [message] with verbose level 3
  @override
  void v3(Object? message, [LogMessageContext? context]) => super.v3('$prefix $message', context);

  /// Regular [message] with verbose level 4
  @override
  void vvvv(Object? message, [LogMessageContext? context]) => super.vvvv('$prefix $message', context);

  /// Regular [message] with verbose level 4
  @override
  void v4(Object? message, [LogMessageContext? context]) => super.v4('$prefix $message', context);

  /// Regular [message] with verbose level 5
  @override
  void vvvvv(Object? message, [LogMessageContext? context]) => super.vvvvv('$prefix $message', context);

  /// Regular [message] with verbose level 5
  @override
  void v5(Object? message, [LogMessageContext? context]) => super.v5('$prefix $message', context);

  /// Regular [message] with verbose level 6
  @override
  void vvvvvv(Object? message, [LogMessageContext? context]) => super.vvvvvv('$prefix $message', context);

  /// Regular [message] with verbose level 6
  @override
  void v6(Object? message, [LogMessageContext? context]) => super.v6('$prefix $message', context);

  /// Inform [message] with verbose level 3
  @override
  void i(Object? message, [LogMessageContext? context]) => super.i('$prefix $message', context);

  /// Warning [message] with verbose level 2
  @override
  void w(Object? message, [StackTrace? stackTrace, LogMessageContext? context]) =>
      super.w('$prefix $message', stackTrace, context);

  /// Error [message] with verbose level 1
  @override
  void e(Object? message, [StackTrace? stackTrace, LogMessageContext? context]) =>
      super.e('$prefix $message', stackTrace, context);

  /// Warning [message] with verbose level 2
  @override
  void ww(Object? message, [Object? exception, StackTrace? stackTrace, LogMessageContext? context]) =>
      super.ww('$prefix $message', exception, stackTrace, context);

  /// Error [message] with verbose level 1
  @override
  void ee(Object? message, [Object? exception, StackTrace? stackTrace, LogMessageContext? context]) =>
      super.ee('$prefix $message', exception, stackTrace, context);

  /// Debug [message] with verbose level 4
  @override
  void d(Object? message, [LogMessageContext? context]) => super.d('$prefix $message', context);
}
