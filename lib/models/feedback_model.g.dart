// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackModel _$FeedbackModelFromJson(Map<String, dynamic> json) =>
    FeedbackModel(
      json['llkoawsnOrderNo'] as String,
      json['plkrowsductLogo'] as String,
      json['plkrowsductName'] as String,
      json['flkeewsdBackType'] as String,
      json['flkeewsdBackContent'] as String,
      json['flkeewsdBackImg'] as String,
      json['rlkepwslyContent'] as String,
      json['rlkepwslyTime'] as String,
      json['flkeewsdBackState'] as int,
      json['flkeewsdBackTime'] as String,
    );

Map<String, dynamic> _$FeedbackModelToJson(FeedbackModel instance) =>
    <String, dynamic>{
      'llkoawsnOrderNo': instance.loanOrderNo,
      'plkrowsductLogo': instance.productLogo,
      'plkrowsductName': instance.productName,
      'flkeewsdBackType': instance.feedBackType,
      'flkeewsdBackContent': instance.feedBackContent,
      'flkeewsdBackImg': instance.feedBackImg,
      'rlkepwslyContent': instance.replyContent,
      'rlkepwslyTime': instance.replyTime,
      'flkeewsdBackState': instance.feedBackState,
      'flkeewsdBackTime': instance.feedBackTime,
    };
