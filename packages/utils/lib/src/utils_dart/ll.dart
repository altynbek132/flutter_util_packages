// ignore_for_file: implementation_imports, invalid_use_of_internal_member

import 'package:l/l.dart';

import 'package:l/src/inner_logger_log_mixin.dart';
import 'package:l/src/inner_logger_methods_mixin.dart';
import 'package:l/src/inner_logger_operators_mixin.dart';
import 'package:l/src/inner_logger_shortcuts_mixin.dart';
import 'package:l/src/inner_logger_subscription_mixin.dart';
import 'package:l/src/inner_zoned_mixin.dart';
import 'package:l/src/logger.dart';
import 'package:l/src/inner_logger.dart';

final ll = LNullable.instance;

base class LNullable extends InnerLogger
    with
        InnerLoggerSubscriptionMixin,
        InnerLoggerLogMixin,
        InnerLoggerMethodsMixin,
        InnerLoggerOperatorsMixin,
        InnerLoggerShortcutsMixin,
        InnerZonedMixin {
  factory LNullable() {
    return instance;
  }

  LNullable.internal();
  static final LNullable instance = LNullable.internal();

  /// A shout [message] is always displayed
  @override
  void s(Object? message, [LogMessageContext? context]) => super.s(message ?? '', context);

  /// Regular [message] with verbose level 1
  @override
  void v(Object? message, [LogMessageContext? context]) => super.v(message ?? '', context);

  /// Regular [message] with verbose level 1
  @override
  void v1(Object? message, [LogMessageContext? context]) => super.v1(message ?? '', context);

  /// Regular [message] with verbose level 2
  @override
  void vv(Object? message, [LogMessageContext? context]) => super.vv(message ?? '', context);

  /// Regular [message] with verbose level 2
  @override
  void v2(Object? message, [LogMessageContext? context]) => super.v2(message ?? '', context);

  /// Regular [message] with verbose level 3
  @override
  void vvv(Object? message, [LogMessageContext? context]) => super.vvv(message ?? '', context);

  /// Regular [message] with verbose level 3
  @override
  void v3(Object? message, [LogMessageContext? context]) => super.v3(message ?? '', context);

  /// Regular [message] with verbose level 4
  @override
  void vvvv(Object? message, [LogMessageContext? context]) => super.vvvv(message ?? '', context);

  /// Regular [message] with verbose level 4
  @override
  void v4(Object? message, [LogMessageContext? context]) => super.v4(message ?? '', context);

  /// Regular [message] with verbose level 5
  @override
  void vvvvv(Object? message, [LogMessageContext? context]) => super.vvvvv(message ?? '', context);

  /// Regular [message] with verbose level 5
  @override
  void v5(Object? message, [LogMessageContext? context]) => super.v5(message ?? '', context);

  /// Regular [message] with verbose level 6
  @override
  void vvvvvv(Object? message, [LogMessageContext? context]) => super.vvvvvv(message ?? '', context);

  /// Regular [message] with verbose level 6
  @override
  void v6(Object? message, [LogMessageContext? context]) => super.v6(message ?? '', context);

  /// Inform [message] with verbose level 3
  @override
  void i(Object? message, [LogMessageContext? context]) => super.i(message ?? '', context);

  /// Warning [message] with verbose level 2
  @override
  void w(Object? message, [StackTrace? stackTrace, LogMessageContext? context]) =>
      super.w(message ?? '', stackTrace, context);

  /// Error [message] with verbose level 1
  @override
  void e(Object? message, [StackTrace? stackTrace, LogMessageContext? context]) =>
      super.e(message ?? '', stackTrace, context);

  /// Debug [message] with verbose level 4
  @override
  void d(Object? message, [LogMessageContext? context]) => super.d(message ?? '', context);
}
