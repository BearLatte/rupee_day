// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResultModel _$LoginResultModelFromJson(Map<String, dynamic> json) =>
    LoginResultModel(
      json['llkogwsinToken'] as String,
      json['ilksRwsegistered'] as int,
    );

Map<String, dynamic> _$LoginResultModelToJson(LoginResultModel instance) =>
    <String, dynamic>{
      'llkogwsinToken': instance.loginToken,
      'ilksRwsegistered': instance.isRegistered,
    };
