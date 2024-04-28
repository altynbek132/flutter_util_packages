import 'package:test/test.dart';
import 'package:worker_method_channel/src/exception_serializing/error_serializer_registry.dart';
import 'package:worker_method_channel/src/exception_serializing/error_serializer_registry_imp.dart';

import '../integration_test/custom_exception.dart';
import '../integration_test/custom_exception_serializer.dart';

void main() {
  group('CustomExceptionSerializer', () {
    late CustomExceptionSerializer serializer;
    late ErrorSerializerRegistry registry;

    setUp(() {
      serializer = CustomExceptionSerializer();
      registry = ErrorSerializerRegistryImp()..registerSerializer(serializer);
    });

    group('ErrorSerializerRegistry', () {
      test('getSerializer should return the registered serializer', () {
        final registered = registry.getSerializer(serializer.serializedExceptionType);
        expect(registered, serializer);
      });

      test('getSerializerByType should return the registered serializer by runtime type', () {
        final registered = registry.getSerializerByType(CustomException(message: '').runtimeType);
        expect(registered, serializer);
      });
    });

    test('serializeError should return the serialized JSON of CustomException', () {
      final exception = CustomException(message: 'Test Exception');
      final serialized = serializer.serializeError(exception);
      expect(serialized, exception.toJson());
    });

    test('deserializeError should return a CustomException instance from JSON', () {
      final json = {'message': 'Test Exception'};
      final exception = serializer.deserializeError(json);
      expect(exception, isA<CustomException>());
      expect((exception as CustomException).message, json['message']);
    });
  });
}
