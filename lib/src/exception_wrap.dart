import 'package:dart_json_mapper/dart_json_mapper.dart';

import 'exception_wrap.mapper.g.dart';

@jsonSerializable
class ExceptionBase implements Exception {
  static final adapter = exceptionWrapGeneratedAdapter;

  ExceptionBase({this.innerE, this.baseMessage});

  @JsonProperty(ignore: true)
  dynamic baseMessage;

  @JsonProperty(ignore: true)
  Exception? innerE;

  @override
  String toString() {
    Object? message = baseMessage;
    if (message == null) return "Exception";
    return "Exception: $message, "
        "Inner exception: "
        "${innerE ?? ''}";
  }
}
