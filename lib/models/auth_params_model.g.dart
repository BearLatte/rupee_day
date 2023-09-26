// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthParamsModel _$AuthParamsModelFromJson(Map<String, dynamic> json) =>
    AuthParamsModel(
      authStep: json['authStep'] as String,
      frontImage: json['frontImage'] as String?,
      backImage: json['backImage'] as String?,
      userNames: json['userNames'] as String?,
      aadhaarNumber: json['aadhaarNumber'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      userGender: json['userGender'] as String?,
      marriageStatus: json['marriageStatus'] as String?,
      education: json['education'] as String?,
      addressDetail: json['addressDetail'] as String?,
      userIndustry: json['userIndustry'] as String?,
      workTitle: json['workTitle'] as String?,
      monthlySalary: json['monthlySalary'] as String?,
      userEmail: json['userEmail'] as String?,
      whatsAppAccount: json['whatsAppAccount'] as String?,
      facebookId: json['facebookId'] as String?,
      panCardImg: json['panCardImg'] as String?,
      panNumber: json['panNumber'] as String?,
      applyAmount: json['applyAmount'] as String?,
      contactList: json['contactList'] as String?,
      bankCardName: json['bankCardName'] as String?,
      bankCardNo: json['bankCardNo'] as String?,
      bankIfscCode: json['bankIfscCode'] as String?,
    );

Map<String, dynamic> _$AuthParamsModelToJson(AuthParamsModel instance) =>
    <String, dynamic>{
      'authStep': instance.authStep,
      'frontImage': instance.frontImage,
      'backImage': instance.backImage,
      'userNames': instance.userNames,
      'aadhaarNumber': instance.aadhaarNumber,
      'dateOfBirth': instance.dateOfBirth,
      'userGender': instance.userGender,
      'marriageStatus': instance.marriageStatus,
      'education': instance.education,
      'addressDetail': instance.addressDetail,
      'userIndustry': instance.userIndustry,
      'workTitle': instance.workTitle,
      'monthlySalary': instance.monthlySalary,
      'userEmail': instance.userEmail,
      'whatsAppAccount': instance.whatsAppAccount,
      'facebookId': instance.facebookId,
      'panCardImg': instance.panCardImg,
      'panNumber': instance.panNumber,
      'applyAmount': instance.applyAmount,
      'contactList': instance.contactList,
      'bankCardName': instance.bankCardName,
      'bankCardNo': instance.bankCardNo,
      'bankIfscCode': instance.bankIfscCode,
    };
