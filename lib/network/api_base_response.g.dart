// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiBaseResponse _$ApiBaseResponseFromJson(Map<String, dynamic> json) =>
    ApiBaseResponse(
      json['data'] as Map<String, dynamic>?,
      json['resultCode'] as int,
      json['resultMsg'] as String,
    );

Map<String, dynamic> _$ApiBaseResponseToJson(ApiBaseResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'resultCode': instance.resultCode,
      'resultMsg': instance.resultMsg,
    };
