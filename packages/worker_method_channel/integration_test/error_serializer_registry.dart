import 'package:worker_method_channel/src/exception_serializing/error_serializer_registry.dart';
import 'package:worker_method_channel/src/exception_serializing/error_serializer_registry_imp.dart';

import 'custom_exception_serializer.dart';

final ErrorSerializerRegistry serializerRegistry = ErrorSerializerRegistryImp()
  ..registerSerializer(CustomExceptionSerializer());
