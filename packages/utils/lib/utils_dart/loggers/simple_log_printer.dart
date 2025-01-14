part of 'logger_mixin.dart';

var kUseAlwaysPrint = false;

/// A simple log printer that implements the [LogPrinter] interface.
class SimpleLogPrinter extends LogPrinter {
  final String className;
  final bool printCallingFunctionName;
  final bool printCallStack;
  final List<String> exludeLogsFromClasses;
  final String? showOnlyClass;

  /// Creates a new instance of [SimpleLogPrinter].
  ///
  /// The [className] parameter specifies the name of the class that is using the logger.
  /// The [printCallingFunctionName] parameter determines whether to print the calling function name in the log.
  /// The [printCallStack] parameter determines whether to print the call stack in the log.
  /// The [exludeLogsFromClasses] parameter is a list of class names to exclude from logging.
  /// The [showOnlyClass] parameter specifies a class name to show logs only for that class.
  SimpleLogPrinter(
    this.className, {
    this.printCallingFunctionName = true,
    this.printCallStack = false,
    this.exludeLogsFromClasses = const [],
    this.showOnlyClass,
  });

  String _labelFor(Level level) {
    final prefix = SimplePrinter.levelPrefixes[level];
    final color = SimplePrinter.levelColors[level];

    if (prefix == null) {
      return '';
    }
    if (color == null) {
      return prefix;
    }
    return color(prefix);
  }

  /// Returns a list of log messages based on the provided [event].
  ///
  /// The [event] parameter represents a log event containing information such as the log level, message, error, and stack trace.
  /// This method formats the log message with a timestamp, class name, and optional stack trace.
  /// It also filters out logs based on exclusion and inclusion criteria.
  ///
  /// If the log message belongs to an excluded class or does not match the specified class for inclusion, an empty list is returned.
  ///
  /// The returned list contains each line of the formatted log message, followed by the error and stack trace (if available).
  ///
  /// Example usage:
  /// ```dart
  /// final logger = SimpleLogPrinter();
  /// final logEvent = LogEvent(
  ///   level: LogLevel.info,
  ///   message: 'This is an info message',
  ///   error: null,
  ///   stackTrace: null,
  /// );
  /// final logMessages = logger.log(logEvent);
  /// print(logMessages);
  /// ```
  @override
  List<String> log(LogEvent event) {
    final now = DateTime.now();
    final prefix =
        '${_labelFor(event.level)} [${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}]';

    final methodNameSection = printCallingFunctionName;
    final stackLog = event.stackTrace.toString();
    final output =
        '$prefix ${methodNameSection ? className : ''} - ${event.message}${printCallStack ? '\nSTACKTRACE:\n$stackLog' : ''}';

    if (exludeLogsFromClasses.any((excludeClass) => className == excludeClass) ||
        (showOnlyClass != null && className != showOnlyClass)) return [];

    final List<String> result = [];

    for (var line in output.split('\n')) {
      result.add(line);
    }

    final err = event.error;
    result.addAll([
      if (event.error != null) ...[
        'error:',
        if (err is DioException) err.requestOptions.uri.toString(),
        err.toString(),
      ],
      if (event.stackTrace != null) ...[
        'stackTrace:',
        event.stackTrace.toString(),
      ],
    ]);

    return result;
  }
}

class MultipleLoggerOutput extends LogOutput {
  final List<LogOutput> logOutputs;

  MultipleLoggerOutput(this.logOutputs);

  @override
  void output(OutputEvent event) {
    for (var logOutput in logOutputs) {
      try {
        logOutput.output(event);
      } catch (e) {
        log('Log output failed');
      }
    }
  }
}

class LogAllTheTimeFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}

class DevLogOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    if (!_kLoggerShouldLog) {
      return;
    }
    if (kUseAlwaysPrint) {
      // ignore: avoid_print
      event.lines.forEach(print);
      return;
    }
    // ignore: avoid_print
    var logFunction = (String message) => print(message);
    if (_isIO) {
      logFunction = (String message) => log(message);
    }
    event.lines.forEach(logFunction);
  }

  // ! workaround for dart compile js imported with [Worker] class
  bool get _isIO {
    try {
      return Platform.I.vm;
    } catch (e) {
      return false;
    }
  }
}
