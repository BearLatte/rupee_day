// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_list_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackListResult _$FeedbackListResultFromJson(Map<String, dynamic> json) =>
    FeedbackListResult(
      (json['flkeewsdBackList'] as List<dynamic>)
          .map((e) => FeedbackModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeedbackListResultToJson(FeedbackListResult instance) =>
    <String, dynamic>{
      'flkeewsdBackList': instance.feedBackList,
    };
