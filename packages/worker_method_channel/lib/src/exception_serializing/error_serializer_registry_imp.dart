import 'package:worker_method_channel/src/exception_serializing/error_serializer.dart';
import 'package:worker_method_channel/src/exception_serializing/error_serializer_registry.dart';

class ErrorSerializerRegistryImp implements ErrorSerializerRegistry {
  final Map<String, ErrorSerializer> _serializedExceptionType_serializer = {};
  final Map<Type, String> _exceptionType_serializedExceptionType = {};

  @override
  void registerSerializer(ErrorSerializer serializer) {
    if (_serializedExceptionType_serializer.containsKey(serializer.serializedExceptionType)) {
      throw Exception('Error serializer with key ${serializer.serializedExceptionType} already exists.');
    }
    if (_exceptionType_serializedExceptionType.containsKey(serializer.exceptionType)) {
      throw Exception('Error serializer with type ${serializer.exceptionType} already exists.');
    }
    _serializedExceptionType_serializer[serializer.serializedExceptionType] = serializer;
    _exceptionType_serializedExceptionType[serializer.exceptionType] = serializer.serializedExceptionType;
  }

  @override
  void unRegisterSerializer(ErrorSerializer serializer) {
    _serializedExceptionType_serializer.remove(serializer.serializedExceptionType);
    _exceptionType_serializedExceptionType.remove(serializer.exceptionType);
  }

  @override
  ErrorSerializer? getSerializer(String key) {
    return _serializedExceptionType_serializer[key];
  }

  @override
  ErrorSerializer? getSerializerByType(Type type) {
    final serializedExceptionType = _exceptionType_serializedExceptionType[type];
    if (serializedExceptionType == null) {
      return null;
    }
    return _serializedExceptionType_serializer[serializedExceptionType];
  }
}
