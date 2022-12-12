import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dart_json_mapper_mobx/dart_json_mapper_mobx.dart';
import 'package:mobx/mobx.dart';

import 'dart_json_mapper.mapper.g.dart' show initializeJsonMapper;

part 'dart_json_mapper.g.dart';

Future<void> main() async {
  initializeJsonMapper(adapters: [mobXAdapter]);

  // _checkSer(
  //   Imp()
  //     ..inner = (Imp2()..message = 'inner')
  //     ..message = 'wrap',
  // );
  _checkSer(
    MobxSerModel()
      ..id = 228
      ..list = ['asdf'].asObservable(),
  );
}

void _checkSer<T>(T v) {
  final json = JsonMapper.serialize(v);
  print('json: ${json}');
  final instance = JsonMapper.deserialize<T>(json);
  print('instance: ${instance}');
}

@jsonSerializable
class Imp extends Base {
  String? message;

  static Imp fromJson(Map<String, dynamic> json) =>
      JsonMapper.deserialize<Imp>(json)!;

  Map<String, dynamic> toJson() => JsonMapper.toMap(this)!;

  @override
  String toString() => JsonMapper.serialize(this);
}

@jsonSerializable
class Base {
  Base({this.inner});

  @JsonProperty(ignore: true)
  Base? inner;
}

class Imp2 extends Base {
  String? message;
}

@jsonSerializable
abstract class _MobxSerModelBase with Store {
  @observable
  int? id;

  @observable
  ObservableList<Typedefed>? list;
}

typedef Typedefed = String;

@jsonSerializable
class MobxSerModel extends _MobxSerModelBase with _$MobxSerModel {
  // dart_json_mapper_mobx compatibility
  @override
  @JsonProperty(ignore: true)
  ReactiveContext get context => super.context;

  static MobxSerModel fromJson(Map<String, dynamic> json) =>
      JsonMapper.deserialize<MobxSerModel>(json)!;

  Map<String, dynamic> toJson() => JsonMapper.toMap(this)!;

  @override
  String toString() => JsonMapper.serialize(this);
}
