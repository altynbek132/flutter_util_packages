// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      requestId: json['requestId'] as int,
      method: json['method'] as String,
      body: json['body'],
      exception: json['exception'] == null
          ? null
          : WebPlatformException.fromJson(
              json['exception'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'method': instance.method,
      'body': instance.body,
      'exception': instance.exception?.toJson(),
    };
