// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MessageFreezed _$MessageFreezedFromJson(Map<String, dynamic> json) {
  return Message.fromJson(json);
}

/// @nodoc
mixin _$MessageFreezed {
  /// The unique identifier for the request.
  int get requestId => throw _privateConstructorUsedError;

  /// The method associated with the message.
  String get method => throw _privateConstructorUsedError;

  /// The body of the message, which can be a primitive type, List, or Map.
  Object? get body => throw _privateConstructorUsedError;

  /// An exception that occurred while processing the message, if any.
  WebPlatformException? get exception => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageFreezedCopyWith<MessageFreezed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageFreezedCopyWith<$Res> {
  factory $MessageFreezedCopyWith(
          MessageFreezed value, $Res Function(MessageFreezed) then) =
      _$MessageFreezedCopyWithImpl<$Res, MessageFreezed>;
  @useResult
  $Res call(
      {int requestId,
      String method,
      Object? body,
      WebPlatformException? exception});
}

/// @nodoc
class _$MessageFreezedCopyWithImpl<$Res, $Val extends MessageFreezed>
    implements $MessageFreezedCopyWith<$Res> {
  _$MessageFreezedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestId = null,
    Object? method = null,
    Object? body = freezed,
    Object? exception = freezed,
  }) {
    return _then(_value.copyWith(
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as int,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      body: freezed == body ? _value.body : body,
      exception: freezed == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as WebPlatformException?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res>
    implements $MessageFreezedCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int requestId,
      String method,
      Object? body,
      WebPlatformException? exception});
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageFreezedCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
      _$MessageImpl _value, $Res Function(_$MessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestId = null,
    Object? method = null,
    Object? body = freezed,
    Object? exception = freezed,
  }) {
    return _then(_$MessageImpl(
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as int,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      body: freezed == body ? _value.body : body,
      exception: freezed == exception
          ? _value.exception
          : exception // ignore: cast_nullable_to_non_nullable
              as WebPlatformException?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl implements Message {
  _$MessageImpl(
      {required this.requestId,
      required this.method,
      this.body,
      this.exception});

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  /// The unique identifier for the request.
  @override
  final int requestId;

  /// The method associated with the message.
  @override
  final String method;

  /// The body of the message, which can be a primitive type, List, or Map.
  @override
  final Object? body;

  /// An exception that occurred while processing the message, if any.
  @override
  final WebPlatformException? exception;

  @override
  String toString() {
    return 'MessageFreezed(requestId: $requestId, method: $method, body: $body, exception: $exception)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.method, method) || other.method == method) &&
            const DeepCollectionEquality().equals(other.body, body) &&
            const DeepCollectionEquality().equals(other.exception, exception));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      requestId,
      method,
      const DeepCollectionEquality().hash(body),
      const DeepCollectionEquality().hash(exception));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(
      this,
    );
  }
}

abstract class Message implements MessageFreezed {
  factory Message(
      {required final int requestId,
      required final String method,
      final Object? body,
      final WebPlatformException? exception}) = _$MessageImpl;

  factory Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override

  /// The unique identifier for the request.
  int get requestId;
  @override

  /// The method associated with the message.
  String get method;
  @override

  /// The body of the message, which can be a primitive type, List, or Map.
  Object? get body;
  @override

  /// An exception that occurred while processing the message, if any.
  WebPlatformException? get exception;
  @override
  @JsonKey(ignore: true)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
