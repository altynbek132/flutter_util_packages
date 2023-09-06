import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_api_repo.g.dart';

@LazySingleton()
class Api extends __Api {
  Api(Dio super.dio);

  Future<Something> getSomethingBad({
    @CancelRequest() CancelToken? cancelToken,
  }) {
    return _getSomethingBad(cancelToken: cancelToken);
  }
}

@RestApi(parser: Parser.DartJsonMapper)
abstract class _Api {
  factory _Api(Dio dio) = __Api;

  @GET('/something')
  Future<Something> getSomething({
    @CancelRequest() CancelToken? cancelToken,
  });

  @GET('/something')
  Future<Something> _getSomethingBad({
    @CancelRequest() CancelToken? cancelToken,
  });
}

@jsonSerializable
class Something {
  static Something fromJson(Map<String, dynamic> json) => JsonMapper.deserialize<Something>(json)!;

  Map<String, dynamic> toJson() => JsonMapper.toMap(this)!;

  @override
  String toString() => JsonMapper.serialize(this);
}

// ---------

Future<void> main() async {
  final dio = Dio();
  final api = Api(dio);

  // api.getSomething();
  api.getSomethingBad();
}
