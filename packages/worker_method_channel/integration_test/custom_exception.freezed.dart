// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomExceptionFreezed _$CustomExceptionFreezedFromJson(
    Map<String, dynamic> json) {
  return CustomException.fromJson(json);
}

/// @nodoc
mixin _$CustomExceptionFreezed {
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomExceptionFreezedCopyWith<CustomExceptionFreezed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomExceptionFreezedCopyWith<$Res> {
  factory $CustomExceptionFreezedCopyWith(CustomExceptionFreezed value,
          $Res Function(CustomExceptionFreezed) then) =
      _$CustomExceptionFreezedCopyWithImpl<$Res, CustomExceptionFreezed>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$CustomExceptionFreezedCopyWithImpl<$Res,
        $Val extends CustomExceptionFreezed>
    implements $CustomExceptionFreezedCopyWith<$Res> {
  _$CustomExceptionFreezedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomExceptionImplCopyWith<$Res>
    implements $CustomExceptionFreezedCopyWith<$Res> {
  factory _$$CustomExceptionImplCopyWith(_$CustomExceptionImpl value,
          $Res Function(_$CustomExceptionImpl) then) =
      __$$CustomExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CustomExceptionImplCopyWithImpl<$Res>
    extends _$CustomExceptionFreezedCopyWithImpl<$Res, _$CustomExceptionImpl>
    implements _$$CustomExceptionImplCopyWith<$Res> {
  __$$CustomExceptionImplCopyWithImpl(
      _$CustomExceptionImpl _value, $Res Function(_$CustomExceptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$CustomExceptionImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomExceptionImpl implements CustomException {
  _$CustomExceptionImpl({required this.message});

  factory _$CustomExceptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomExceptionImplFromJson(json);

  @override
  final String message;

  @override
  String toString() {
    return 'CustomExceptionFreezed(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomExceptionImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomExceptionImplCopyWith<_$CustomExceptionImpl> get copyWith =>
      __$$CustomExceptionImplCopyWithImpl<_$CustomExceptionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomExceptionImplToJson(
      this,
    );
  }
}

abstract class CustomException implements CustomExceptionFreezed, Exception {
  factory CustomException({required final String message}) =
      _$CustomExceptionImpl;

  factory CustomException.fromJson(Map<String, dynamic> json) =
      _$CustomExceptionImpl.fromJson;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$CustomExceptionImplCopyWith<_$CustomExceptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
