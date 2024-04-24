import 'package:freezed_annotation/freezed_annotation.dart';

/// [unfreezed] but with equal generation
@internal
const freezedMutable = Freezed(
  addImplicitFinal: false,
  makeCollectionsUnmodifiable: false,
);
