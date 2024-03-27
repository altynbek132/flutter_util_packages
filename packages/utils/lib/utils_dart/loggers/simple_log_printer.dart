part of 'logger_mixin.dart';

class SimpleLogPrinter extends LogPrinter {
  final String className;
  final bool printCallingFunctionName;
  final bool printCallStack;
  final List<String> exludeLogsFromClasses;
  final String? showOnlyClass;

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
    // ignore: avoid_print
    var logFunction = (String message) => print(message);
    if (isIO) {
      logFunction = (String message) => log(message);
    }
    event.lines.forEach(logFunction);
  }

  bool get isIO {
    // ! workaround for dart compile js imported with [Worker] class
    try {
      return Platform.I.isIO;
    } catch (e) {
      return false;
    }
  }
}
