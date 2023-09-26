// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'optical_character_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpticalCharacterModel _$OpticalCharacterModelFromJson(
        Map<String, dynamic> json) =>
    OpticalCharacterModel(
      json['plkanwsNumber'] as String?,
      json['ulksewsrNames'] as String?,
      json['alkadwshaarNumber'] as String?,
      json['ulksewsrGender'] as String?,
      json['dlkatwseOfBirth'] as String?,
      json['ilkmawsgeHttp'] as String,
      json['ilkmawsgePath'] as String,
      json['alkddwsressDetail'] as String?,
    );

Map<String, dynamic> _$OpticalCharacterModelToJson(
        OpticalCharacterModel instance) =>
    <String, dynamic>{
      'plkanwsNumber': instance.panNumber,
      'ulksewsrNames': instance.userNames,
      'alkadwshaarNumber': instance.aadhaarNumber,
      'ulksewsrGender': instance.userGender,
      'dlkatwseOfBirth': instance.dateOfBirth,
      'ilkmawsgeHttp': instance.imageHttp,
      'ilkmawsgePath': instance.imagePath,
      'alkddwsressDetail': instance.addressDetail,
    };
