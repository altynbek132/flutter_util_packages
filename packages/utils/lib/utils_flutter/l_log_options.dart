import 'package:l/l.dart';

var logOptions = LogOptions(
  handlePrint: true,
  printColors: true,
  outputInRelease: false,
  output: LogOutput.developer,
  messageFormatting: (event) {
    if (event is LogMessageError) {
      return '${event.timestamp.hour}:${event.timestamp.minute.toString().padLeft(2, '0')}:${event.timestamp.second.toString().padLeft(2, '0')} ${event.message}\n${event.stackTrace}';
    }
    return '${event.timestamp.hour}:${event.timestamp.minute.toString().padLeft(2, '0')}:${event.timestamp.second.toString().padLeft(2, '0')} ${event.message}';
  },
);
