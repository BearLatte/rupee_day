// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liveness_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LivenessParamsModel _$LivenessParamsModelFromJson(Map<String, dynamic> json) =>
    LivenessParamsModel(
      json['alkccwsuauthId'] as String,
      json['alkccwsuauthSecret'] as String,
      json['alkccwsuauthHostUrl'] as String,
    );

Map<String, dynamic> _$LivenessParamsModelToJson(
        LivenessParamsModel instance) =>
    <String, dynamic>{
      'alkccwsuauthId': instance.accuauthId,
      'alkccwsuauthSecret': instance.accuauthSecret,
      'alkccwsuauthHostUrl': instance.accuauthHostUrl,
    };
