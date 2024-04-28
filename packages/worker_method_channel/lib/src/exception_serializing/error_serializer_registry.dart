import 'package:worker_method_channel/src/exception_serializing/error_serializer.dart';

/// A registry for error serializers.
///
/// This abstract class defines the methods for registering and unregistering error serializers,
/// as well as retrieving error serializers based on a key or a type.
abstract class ErrorSerializerRegistry {
  /// Registers an error serializer.
  ///
  /// The [serializer] parameter is the error serializer to be registered.
  void registerSerializer(ErrorSerializer serializer);

  /// Unregisters an error serializer.
  ///
  /// The [serializer] parameter is the error serializer to be unregistered.
  void unRegisterSerializer(ErrorSerializer serializer);

  /// Retrieves an error serializer based on a key.
  ///
  /// The [key] parameter is the key associated with the error serializer.
  /// Returns the error serializer associated with the key, or `null` if not found.
  ErrorSerializer? getSerializer(String key);

  /// Retrieves an error serializer based on a type.
  ///
  /// The [type] parameter is the type associated with the error serializer.
  /// Returns the error serializer associated with the type, or `null` if not found.
  ErrorSerializer? getSerializerByType(Type type);
}
