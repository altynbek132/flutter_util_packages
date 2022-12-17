// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dragscrollsheet.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DragscrollsheetVm on _DragscrollsheetVmBase, Store {
  Computed<double>? _$blurComputed;

  @override
  double get blur => (_$blurComputed ??= Computed<double>(() => super.blur,
          name: '_DragscrollsheetVmBase.blur'))
      .value;

  late final _$minChildSizeAtom =
      Atom(name: '_DragscrollsheetVmBase.minChildSize', context: context);

  @override
  double get minChildSize {
    _$minChildSizeAtom.reportRead();
    return super.minChildSize;
  }

  @override
  set minChildSize(double value) {
    _$minChildSizeAtom.reportWrite(value, super.minChildSize, () {
      super.minChildSize = value;
    });
  }

  late final _$maxChildSizeAtom =
      Atom(name: '_DragscrollsheetVmBase.maxChildSize', context: context);

  @override
  double get maxChildSize {
    _$maxChildSizeAtom.reportRead();
    return super.maxChildSize;
  }

  @override
  set maxChildSize(double value) {
    _$maxChildSizeAtom.reportWrite(value, super.maxChildSize, () {
      super.maxChildSize = value;
    });
  }

  late final _$snapAtom =
      Atom(name: '_DragscrollsheetVmBase.snap', context: context);

  @override
  bool get snap {
    _$snapAtom.reportRead();
    return super.snap;
  }

  @override
  set snap(bool value) {
    _$snapAtom.reportWrite(value, super.snap, () {
      super.snap = value;
    });
  }

  late final _$jumpToAsyncAction =
      AsyncAction('_DragscrollsheetVmBase.jumpTo', context: context);

  @override
  Future<void> jumpTo(double value) {
    return _$jumpToAsyncAction.run(() => super.jumpTo(value));
  }

  late final _$closeAsyncAction =
      AsyncAction('_DragscrollsheetVmBase.close', context: context);

  @override
  Future<void> close() {
    return _$closeAsyncAction.run(() => super.close());
  }

  late final _$openAsyncAction =
      AsyncAction('_DragscrollsheetVmBase.open', context: context);

  @override
  Future<void> open() {
    return _$openAsyncAction.run(() => super.open());
  }

  late final _$_DragscrollsheetVmBaseActionController =
      ActionController(name: '_DragscrollsheetVmBase', context: context);

  @override
  Future<void> animateTo(double value) {
    final _$actionInfo = _$_DragscrollsheetVmBaseActionController.startAction(
        name: '_DragscrollsheetVmBase.animateTo');
    try {
      return super.animateTo(value);
    } finally {
      _$_DragscrollsheetVmBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
minChildSize: ${minChildSize},
maxChildSize: ${maxChildSize},
snap: ${snap},
blur: ${blur}
    ''';
  }
}
