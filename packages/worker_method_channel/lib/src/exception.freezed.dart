// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WebPlatformExceptionFreezed _$WebPlatformExceptionFreezedFromJson(
    Map<String, dynamic> json) {
  return WebPlatformException.fromJson(json);
}

/// @nodoc
mixin _$WebPlatformExceptionFreezed {
  /// An error code.
  String? get code => throw _privateConstructorUsedError;

  /// A human-readable error message
  String? get message => throw _privateConstructorUsedError;

  /// Inner exception
  ExceptionWithType? get innerExceptionWithType =>
      throw _privateConstructorUsedError;

  /// Error stacktrace
// ignore: invalid_annotation_target
  @JsonKey(fromJson: _stackFromJson, toJson: _stackToJson)
  StackTrace? get stacktrace => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WebPlatformExceptionFreezedCopyWith<WebPlatformExceptionFreezed>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebPlatformExceptionFreezedCopyWith<$Res> {
  factory $WebPlatformExceptionFreezedCopyWith(
          WebPlatformExceptionFreezed value,
          $Res Function(WebPlatformExceptionFreezed) then) =
      _$WebPlatformExceptionFreezedCopyWithImpl<$Res,
          WebPlatformExceptionFreezed>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      ExceptionWithType? innerExceptionWithType,
      @JsonKey(fromJson: _stackFromJson, toJson: _stackToJson)
      StackTrace? stacktrace});

  $ExceptionWithTypeCopyWith<$Res>? get innerExceptionWithType;
}

/// @nodoc
class _$WebPlatformExceptionFreezedCopyWithImpl<$Res,
        $Val extends WebPlatformExceptionFreezed>
    implements $WebPlatformExceptionFreezedCopyWith<$Res> {
  _$WebPlatformExceptionFreezedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? innerExceptionWithType = freezed,
    Object? stacktrace = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      innerExceptionWithType: freezed == innerExceptionWithType
          ? _value.innerExceptionWithType
          : innerExceptionWithType // ignore: cast_nullable_to_non_nullable
              as ExceptionWithType?,
      stacktrace: freezed == stacktrace
          ? _value.stacktrace
          : stacktrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ExceptionWithTypeCopyWith<$Res>? get innerExceptionWithType {
    if (_value.innerExceptionWithType == null) {
      return null;
    }

    return $ExceptionWithTypeCopyWith<$Res>(_value.innerExceptionWithType!,
        (value) {
      return _then(_value.copyWith(innerExceptionWithType: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WebPlatformExceptionImplCopyWith<$Res>
    implements $WebPlatformExceptionFreezedCopyWith<$Res> {
  factory _$$WebPlatformExceptionImplCopyWith(_$WebPlatformExceptionImpl value,
          $Res Function(_$WebPlatformExceptionImpl) then) =
      __$$WebPlatformExceptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      ExceptionWithType? innerExceptionWithType,
      @JsonKey(fromJson: _stackFromJson, toJson: _stackToJson)
      StackTrace? stacktrace});

  @override
  $ExceptionWithTypeCopyWith<$Res>? get innerExceptionWithType;
}

/// @nodoc
class __$$WebPlatformExceptionImplCopyWithImpl<$Res>
    extends _$WebPlatformExceptionFreezedCopyWithImpl<$Res,
        _$WebPlatformExceptionImpl>
    implements _$$WebPlatformExceptionImplCopyWith<$Res> {
  __$$WebPlatformExceptionImplCopyWithImpl(_$WebPlatformExceptionImpl _value,
      $Res Function(_$WebPlatformExceptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? innerExceptionWithType = freezed,
    Object? stacktrace = freezed,
  }) {
    return _then(_$WebPlatformExceptionImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      innerExceptionWithType: freezed == innerExceptionWithType
          ? _value.innerExceptionWithType
          : innerExceptionWithType // ignore: cast_nullable_to_non_nullable
              as ExceptionWithType?,
      stacktrace: freezed == stacktrace
          ? _value.stacktrace
          : stacktrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebPlatformExceptionImpl implements WebPlatformException {
  _$WebPlatformExceptionImpl(
      {this.code,
      this.message,
      this.innerExceptionWithType,
      @JsonKey(fromJson: _stackFromJson, toJson: _stackToJson)
      this.stacktrace});

  factory _$WebPlatformExceptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebPlatformExceptionImplFromJson(json);

  /// An error code.
  @override
  final String? code;

  /// A human-readable error message
  @override
  final String? message;

  /// Inner exception
  @override
  final ExceptionWithType? innerExceptionWithType;

  /// Error stacktrace
// ignore: invalid_annotation_target
  @override
  @JsonKey(fromJson: _stackFromJson, toJson: _stackToJson)
  final StackTrace? stacktrace;

  @override
  String toString() {
    return 'WebPlatformExceptionFreezed(code: $code, message: $message, innerExceptionWithType: $innerExceptionWithType, stacktrace: $stacktrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebPlatformExceptionImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.innerExceptionWithType, innerExceptionWithType) ||
                other.innerExceptionWithType == innerExceptionWithType) &&
            (identical(other.stacktrace, stacktrace) ||
                other.stacktrace == stacktrace));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, code, message, innerExceptionWithType, stacktrace);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebPlatformExceptionImplCopyWith<_$WebPlatformExceptionImpl>
      get copyWith =>
          __$$WebPlatformExceptionImplCopyWithImpl<_$WebPlatformExceptionImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebPlatformExceptionImplToJson(
      this,
    );
  }
}

abstract class WebPlatformException
    implements WebPlatformExceptionFreezed, Exception {
  factory WebPlatformException(
      {final String? code,
      final String? message,
      final ExceptionWithType? innerExceptionWithType,
      @JsonKey(fromJson: _stackFromJson, toJson: _stackToJson)
      final StackTrace? stacktrace}) = _$WebPlatformExceptionImpl;

  factory WebPlatformException.fromJson(Map<String, dynamic> json) =
      _$WebPlatformExceptionImpl.fromJson;

  @override

  /// An error code.
  String? get code;
  @override

  /// A human-readable error message
  String? get message;
  @override

  /// Inner exception
  ExceptionWithType? get innerExceptionWithType;
  @override

  /// Error stacktrace
// ignore: invalid_annotation_target
  @JsonKey(fromJson: _stackFromJson, toJson: _stackToJson)
  StackTrace? get stacktrace;
  @override
  @JsonKey(ignore: true)
  _$$WebPlatformExceptionImplCopyWith<_$WebPlatformExceptionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
