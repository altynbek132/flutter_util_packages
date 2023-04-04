// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dart_json_mapper.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MobxSerModel on _MobxSerModelBase, Store {
  late final _$idAtom =
      Atom(name: '_MobxSerModelBase.id', context: reactiveContext);

  @override
  int? get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(int? value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  late final _$listAtom =
      Atom(name: '_MobxSerModelBase.list', context: reactiveContext);

  @override
  ObservableList<String>? get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(ObservableList<String>? value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  @override
  String toString() {
    return '''
id: ${id},
list: ${list}
    ''';
  }
}
