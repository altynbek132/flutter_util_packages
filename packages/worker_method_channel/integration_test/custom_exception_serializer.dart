import 'package:worker_method_channel/src/exception_serializing/error_serializer.dart';

import 'custom_exception.dart';

class CustomExceptionSerializer extends ErrorSerializer {
  @override
  Object serializeError(Object error) {
    return (error as CustomException).toJson();
  }

  @override
  Object deserializeError(Object error) {
    return CustomException.fromJson(error as Map<String, dynamic>);
  }

  @override
  String get serializedExceptionType => 'CustomException';

  @override
  Type get exceptionType => CustomException(message: '').runtimeType;
}
