// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draggable_scrollable_controller_wrapper.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DraggableScrollableControllerWrapper
    on _DraggableScrollableControllerWrapperBase, Store {
  late final _$minChildSizeAtom = Atom(
      name: '_DraggableScrollableControllerWrapperBase.minChildSize',
      context: context);

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

  late final _$minChildSizeRefAtom = Atom(
      name: '_DraggableScrollableControllerWrapperBase.minChildSizeRef',
      context: context);

  @override
  double get minChildSizeRef {
    _$minChildSizeRefAtom.reportRead();
    return super.minChildSizeRef;
  }

  @override
  set minChildSizeRef(double value) {
    _$minChildSizeRefAtom.reportWrite(value, super.minChildSizeRef, () {
      super.minChildSizeRef = value;
    });
  }

  late final _$maxChildSizeAtom = Atom(
      name: '_DraggableScrollableControllerWrapperBase.maxChildSize',
      context: context);

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

  late final _$maxChildSizeRefAtom = Atom(
      name: '_DraggableScrollableControllerWrapperBase.maxChildSizeRef',
      context: context);

  @override
  double get maxChildSizeRef {
    _$maxChildSizeRefAtom.reportRead();
    return super.maxChildSizeRef;
  }

  @override
  set maxChildSizeRef(double value) {
    _$maxChildSizeRefAtom.reportWrite(value, super.maxChildSizeRef, () {
      super.maxChildSizeRef = value;
    });
  }

  late final _$initialChildSizeRefAtom = Atom(
      name: '_DraggableScrollableControllerWrapperBase.initialChildSizeRef',
      context: context);

  @override
  double get initialChildSizeRef {
    _$initialChildSizeRefAtom.reportRead();
    return super.initialChildSizeRef;
  }

  @override
  set initialChildSizeRef(double value) {
    _$initialChildSizeRefAtom.reportWrite(value, super.initialChildSizeRef, () {
      super.initialChildSizeRef = value;
    });
  }

  late final _$closeAsyncAction = AsyncAction(
      '_DraggableScrollableControllerWrapperBase.close',
      context: context);

  @override
  Future<void> close({Duration? duration, Curve? curve}) {
    return _$closeAsyncAction
        .run(() => super.close(duration: duration, curve: curve));
  }

  late final _$openAsyncAction = AsyncAction(
      '_DraggableScrollableControllerWrapperBase.open',
      context: context);

  @override
  Future<void> open({double? value, Duration? duration, Curve? curve}) {
    return _$openAsyncAction
        .run(() => super.open(value: value, duration: duration, curve: curve));
  }

  late final _$animateToAsyncAction = AsyncAction(
      '_DraggableScrollableControllerWrapperBase.animateTo',
      context: context);

  @override
  Future<void> animateTo(double value, {Duration? duration, Curve? curve}) {
    return _$animateToAsyncAction
        .run(() => super.animateTo(value, duration: duration, curve: curve));
  }

  @override
  String toString() {
    return '''
minChildSize: ${minChildSize},
minChildSizeRef: ${minChildSizeRef},
maxChildSize: ${maxChildSize},
maxChildSizeRef: ${maxChildSizeRef},
initialChildSizeRef: ${initialChildSizeRef}
    ''';
  }
}
