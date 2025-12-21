import 'package:l/l.dart';

abstract class LConfig {
  static const defaultDevLogOptions = LogOptions(
    handlePrint: true,
    printColors: true,
    outputInRelease: false,
    output: LogOutput.developer,
    messageFormatting: messageFormatting,
  );

  static const defaultPrintLogOptions = LogOptions(
    handlePrint: true,
    printColors: true,
    outputInRelease: false,
    output: LogOutput.print,
    messageFormatting: messageFormatting,
  );

  static String messageFormatting(LogMessage event) {
    if (event is LogMessageError) {
      return '${event.timestamp.hour}:${event.timestamp.minute.toString().padLeft(2, '0')}:${event.timestamp.second.toString().padLeft(2, '0')} ${event.message}\n${event.stackTrace}';
    }
    return '${event.timestamp.hour}:${event.timestamp.minute.toString().padLeft(2, '0')}:${event.timestamp.second.toString().padLeft(2, '0')} ${event.message}';
  }
}
