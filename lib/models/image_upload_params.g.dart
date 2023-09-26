// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_upload_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageUploadParams _$ImageUploadParamsFromJson(Map<String, dynamic> json) =>
    ImageUploadParams(
      json['alkwswsBucket'] as String,
      json['alkwswsFolder'] as String,
      Credentials.fromJson(json['clkrewsdentials'] as Map<String, dynamic>),
      json['alkwswsRegion'] as String,
      json['alkwswsImgHttp'] as String,
    );

Map<String, dynamic> _$ImageUploadParamsToJson(ImageUploadParams instance) =>
    <String, dynamic>{
      'alkwswsBucket': instance.awsBucket,
      'alkwswsFolder': instance.awsFolder,
      'clkrewsdentials': instance.credentials,
      'alkwswsRegion': instance.awsRegion,
      'alkwswsImgHttp': instance.awsImgHttp,
    };

Credentials _$CredentialsFromJson(Map<String, dynamic> json) => Credentials(
      json['accessKeyId'] as String,
      json['secretAccessKey'] as String,
      json['sessionToken'] as String,
      json['expiration'] as int,
    );

Map<String, dynamic> _$CredentialsToJson(Credentials instance) =>
    <String, dynamic>{
      'accessKeyId': instance.accessKeyId,
      'secretAccessKey': instance.secretAccessKey,
      'sessionToken': instance.sessionToken,
      'expiration': instance.expiration,
    };
