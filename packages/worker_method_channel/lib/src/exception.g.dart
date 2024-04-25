// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WebPlatformExceptionImpl _$$WebPlatformExceptionImplFromJson(
        Map<String, dynamic> json) =>
    _$WebPlatformExceptionImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      innerExceptionWithType: json['innerExceptionWithType'] == null
          ? null
          : ExceptionWithType.fromJson(
              json['innerExceptionWithType'] as Map<String, dynamic>),
      stacktrace: _stackFromJson(json['stacktrace']),
    );

Map<String, dynamic> _$$WebPlatformExceptionImplToJson(
        _$WebPlatformExceptionImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'innerExceptionWithType': instance.innerExceptionWithType?.toJson(),
      'stacktrace': _stackToJson(instance.stacktrace),
    };
