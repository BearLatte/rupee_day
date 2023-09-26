// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
      json['ulksewsrStatus'] as int,
      json['alkudwsitPhone'] as int,
      json['plkhowstoContent'] as String,
      json['glkpswsContent'] as String,
      json['plkhowsneContent'] as String,
      json['clkonwstactNum'] as int,
      json['ulksewsrLiveness'] as int,
      json['tlkhiwsrdLiveness'] as String,
      json['ulksewsrPayFail'] as int,
      json['plkaywsFailLogo'] as String,
      json['plkaywsFailContent'] as String,
      json['plkaywsFailLoanName'] as String,
      json['plkaywsFailLoanNo'] as String,
      (json['plkrowsductList'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['llkoawsnProduct'] == null
          ? null
          : ProductDetailModel.fromJson(
              json['llkoawsnProduct'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'ulksewsrStatus': instance.userStatus,
      'alkudwsitPhone': instance.auditPhone,
      'plkhowstoContent': instance.photoContent,
      'glkpswsContent': instance.gpsContent,
      'plkhowsneContent': instance.phoneContent,
      'clkonwstactNum': instance.contactNum,
      'ulksewsrLiveness': instance.userLiveness,
      'tlkhiwsrdLiveness': instance.thirdLiveness,
      'ulksewsrPayFail': instance.userPayFail,
      'plkaywsFailLogo': instance.payFailLogo,
      'plkaywsFailContent': instance.payFailContent,
      'plkaywsFailLoanName': instance.payFailLoanName,
      'plkaywsFailLoanNo': instance.payFailLoanNo,
      'plkrowsductList': instance.productList,
      'llkoawsnProduct': instance.loanProduct,
    };
