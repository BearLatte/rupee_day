// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthInfoModel _$AuthInfoModelFromJson(Map<String, dynamic> json) =>
    AuthInfoModel(
      json['alkudwsitPhone'] as int,
      json['ilkmawsgeHttp'] as String,
      json['alkmowsuntMin'] as int,
      json['alkmowsuntMax'] as int,
      json['clkonwstactNum'] as int,
      json['flkrowsntImage'] as String,
      json['blkacwskImage'] as String,
      json['ulksewsrNames'] as String,
      json['alkadwshaarNumber'] as String,
      json['dlkatwseOfBirth'] as String,
      json['ulksewsrGender'] as String,
      json['mlkarwsriageStatus'] as String,
      json['elkduwscation'] as String,
      json['alkddwsressDetail'] as String,
      json['ulksewsrIndustry'] as String,
      json['wlkorwskTitle'] as String,
      json['mlkonwsthlySalary'] as String,
      json['ulksewsrEmail'] as String,
      json['wlkhawstsAppAccount'] as String,
      json['flkacwsebookId'] as String,
      json['plkanwsCardImg'] as String,
      json['plkanwsNumber'] as String,
      json['alkppwslyAmount'] as String,
      json['clkonwstactList'] as String,
      json['blkanwskCardName'] as String,
      json['blkanwskCardNo'] as String,
      json['blkanwskIfscCode'] as String,
      (json['ulksewsrGenderList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['elkduwscationList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['mlkarwsriageStatusList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['wlkorwskTitleList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['ilkndwsustryList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['mlkonwsthlySalaryList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['rlkelwsationList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AuthInfoModelToJson(AuthInfoModel instance) =>
    <String, dynamic>{
      'alkudwsitPhone': instance.auditPhone,
      'ilkmawsgeHttp': instance.imageHttp,
      'alkmowsuntMin': instance.amountMin,
      'alkmowsuntMax': instance.amountMax,
      'clkonwstactNum': instance.contactNum,
      'flkrowsntImage': instance.frontImage,
      'blkacwskImage': instance.backImage,
      'ulksewsrNames': instance.userNames,
      'alkadwshaarNumber': instance.aadhaarNumber,
      'dlkatwseOfBirth': instance.dateOfBirth,
      'ulksewsrGender': instance.userGender,
      'mlkarwsriageStatus': instance.marriageStatus,
      'elkduwscation': instance.education,
      'alkddwsressDetail': instance.addressDetail,
      'ulksewsrIndustry': instance.userIndustry,
      'wlkorwskTitle': instance.workTitle,
      'mlkonwsthlySalary': instance.monthlySalary,
      'ulksewsrEmail': instance.userEmail,
      'wlkhawstsAppAccount': instance.whatsAppAccount,
      'flkacwsebookId': instance.facebookId,
      'plkanwsCardImg': instance.panCardImg,
      'plkanwsNumber': instance.panNumber,
      'alkppwslyAmount': instance.applyAmount,
      'clkonwstactList': instance.contactList,
      'blkanwskCardName': instance.bankCardName,
      'blkanwskCardNo': instance.bankCardNo,
      'blkanwskIfscCode': instance.bankIfscCode,
      'ulksewsrGenderList': instance.userGenderList,
      'elkduwscationList': instance.educationList,
      'mlkarwsriageStatusList': instance.marriageStatusList,
      'wlkorwskTitleList': instance.workTitleList,
      'ilkndwsustryList': instance.industryList,
      'mlkonwsthlySalaryList': instance.monthlySalaryList,
      'rlkelwsationList': instance.relationList,
    };
