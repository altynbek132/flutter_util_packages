// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exception_with_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExceptionWithType _$ExceptionWithTypeFromJson(Map<String, dynamic> json) {
  return _ExceptionWithType.fromJson(json);
}

/// @nodoc
mixin _$ExceptionWithType {
  String get type => throw _privateConstructorUsedError;
  Object get exception => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExceptionWithTypeCopyWith<ExceptionWithType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExceptionWithTypeCopyWith<$Res> {
  factory $ExceptionWithTypeCopyWith(
          ExceptionWithType value, $Res Function(ExceptionWithType) then) =
      _$ExceptionWithTypeCopyWithImpl<$Res, ExceptionWithType>;
  @useResult
  $Res call({String type, Object exception});
}

/// @nodoc
class _$ExceptionWithTypeCopyWithImpl<$Res, $Val extends ExceptionWithType>
    implements $ExceptionWithTypeCopyWith<$Res> {
  _$ExceptionWithTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? exception = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      exception: null == exception ? _value.exception : exception,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExceptionWithTypeImplCopyWith<$Res>
    implements $ExceptionWithTypeCopyWith<$Res> {
  factory _$$ExceptionWithTypeImplCopyWith(_$ExceptionWithTypeImpl value,
          $Res Function(_$ExceptionWithTypeImpl) then) =
      __$$ExceptionWithTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, Object exception});
}

/// @nodoc
class __$$ExceptionWithTypeImplCopyWithImpl<$Res>
    extends _$ExceptionWithTypeCopyWithImpl<$Res, _$ExceptionWithTypeImpl>
    implements _$$ExceptionWithTypeImplCopyWith<$Res> {
  __$$ExceptionWithTypeImplCopyWithImpl(_$ExceptionWithTypeImpl _value,
      $Res Function(_$ExceptionWithTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? exception = null,
  }) {
    return _then(_$ExceptionWithTypeImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      exception: null == exception ? _value.exception : exception,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExceptionWithTypeImpl implements _ExceptionWithType {
  _$ExceptionWithTypeImpl({required this.type, required this.exception});

  factory _$ExceptionWithTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExceptionWithTypeImplFromJson(json);

  @override
  final String type;
  @override
  final Object exception;

  @override
  String toString() {
    return 'ExceptionWithType(type: $type, exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExceptionWithTypeImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.exception, exception));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(exception));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExceptionWithTypeImplCopyWith<_$ExceptionWithTypeImpl> get copyWith =>
      __$$ExceptionWithTypeImplCopyWithImpl<_$ExceptionWithTypeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExceptionWithTypeImplToJson(
      this,
    );
  }
}

abstract class _ExceptionWithType implements ExceptionWithType {
  factory _ExceptionWithType(
      {required final String type,
      required final Object exception}) = _$ExceptionWithTypeImpl;

  factory _ExceptionWithType.fromJson(Map<String, dynamic> json) =
      _$ExceptionWithTypeImpl.fromJson;

  @override
  String get type;
  @override
  Object get exception;
  @override
  @JsonKey(ignore: true)
  _$$ExceptionWithTypeImplCopyWith<_$ExceptionWithTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
