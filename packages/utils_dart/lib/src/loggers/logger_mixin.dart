import 'package:logger/logger.dart';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:platform_info/platform_info.dart';

part 'simple_log_printer.dart';

mixin LoggerMixin {
  Logger get logger => getLogger('$runtimeType');
}

final loggerGlobal = getLogger('GLOBAL');

var _kLoggerShouldLog = false;

void setLoggerShouldLog(bool loggerShouldLog) {
  _kLoggerShouldLog = loggerShouldLog;
}

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
