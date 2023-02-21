// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppState on _AppStateBase, Store {
  late final _$selectedBookAtom =
      Atom(name: '_AppStateBase.selectedBook', context: context);

  @override
  Book? get selectedBook {
    _$selectedBookAtom.reportRead();
    return super.selectedBook;
  }

  @override
  set selectedBook(Book? value) {
    _$selectedBookAtom.reportWrite(value, super.selectedBook, () {
      super.selectedBook = value;
    });
  }

  @override
  String toString() {
    return '''
selectedBook: ${selectedBook}
    ''';
  }
}
