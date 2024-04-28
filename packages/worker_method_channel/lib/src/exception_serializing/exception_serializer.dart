import 'package:worker_method_channel/src/exception_serializing/error_serializer.dart';

/// A class that serializes and deserializes exceptions.
class ExceptionSerializer extends ErrorSerializer {
  @override
  Object serializeError(Object error) {
    final str = (error as Exception).toString();

    if (str.startsWith('Exception: ')) {
      return str.substring('Exception: '.length);
    }
    return str;
  }

  @override
  Object deserializeError(Object error) {
    return Exception(error.toString());
  }

  @override
  String get serializedExceptionType => 'Exception';

  @override
  Type get exceptionType => Exception().runtimeType;
}
