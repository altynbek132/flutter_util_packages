import 'package:logger/logger.dart';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:platform_info/platform_info.dart';

part 'simple_log_printer.dart';

/// A mixin that provides a logger instance.
///
/// This mixin adds a `logger` getter that returns a logger instance based on the runtime type.
/// It uses the `getLogger` function from the `logger` package to create the logger.
mixin LoggerMixin {
  Logger get logger => getLogger('$runtimeType');
}

/// A global logger instance.
final loggerGlobal = getLogger('GLOBAL');

var _kLoggerShouldLog = true;

/// Sets the value of [loggerShouldLog] to control whether the logger should log or not.
///
/// The [loggerShouldLog] parameter determines whether the logger should log or not.
/// If set to `true`, the logger will log messages. If set to `false`, the logger will not log messages.
void setLoggerShouldLog(bool loggerShouldLog) {
  _kLoggerShouldLog = loggerShouldLog;
}

/// Logs function in which this function is called.
///
/// The [print] function is used to output the log message.
/// The [message] parameter is an optional message to be logged.
/// The [depth] parameter specifies the depth of the stack trace to be included in the log.
/// The [full] parameter specifies whether the full stack trace should be included in the log.
void logFunction(
  void Function(Object message) print, {
  Object? message,
  int? depth,
  bool? full,
}) {
  if (!_kLoggerShouldLog) return;
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

/// Returns a logger instance with the specified configuration.
///
/// The [className] parameter specifies the name of the class that will be associated with the logger.
/// The [printCallingFunctionName] parameter determines whether to print the calling function name in log messages.
/// The [printCallstack] parameter determines whether to print the call stack in log messages.
/// The [exludeLogsFromClasses] parameter is a list of class names for which log messages should be excluded.
/// The [showOnlyClass] parameter specifies a class name to filter log messages and only show logs from that class.
///
/// The returned logger instance is configured with a [LogAllTheTimeFilter] filter, a [SimpleLogPrinter] printer,
/// and a [MultipleLoggerOutput] output with a [DevLogOutput].
Logger getLogger(
  String className, {
  bool printCallingFunctionName = true,
  bool printCallstack = false,
  List<String> exludeLogsFromClasses = const [],
  String? showOnlyClass,
}) {
  return Logger(
    filter: LogAllTheTimeFilter(),
    printer: SimpleLogPrinter(
      className,
      printCallingFunctionName: printCallingFunctionName,
      printCallStack: printCallstack,
      showOnlyClass: showOnlyClass,
      exludeLogsFromClasses: exludeLogsFromClasses,
    ),
    output: MultipleLoggerOutput([
      DevLogOutput(),
    ]),
  );
}
