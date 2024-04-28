/// An abstract class that defines the contract for serializing and deserializing errors.
abstract class ErrorSerializer {
  /// Serializes the given [error] object.
  Object serializeError(Object error);

  /// Deserializes the given [error] object.
  Object deserializeError(Object error);

  /// Returns the type of exception that this serializer handles.
  ///
  /// ! This should be the runtime type of the exception.
  Type get exceptionType;

  /// Returns the serialized type of exception that this serializer handles.
  String get serializedExceptionType;
}
