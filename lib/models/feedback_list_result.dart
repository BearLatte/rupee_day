import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_day/models/feedback_model.dart';

part 'feedback_list_result.g.dart';

@JsonSerializable()
class FeedbackListResult extends Object {
  @JsonKey(name: 'flkeewsdBackList')
  List<FeedbackModel> feedBackList;

  FeedbackListResult(
    this.feedBackList,
  );

  factory FeedbackListResult.fromJson(Map<String, dynamic> srcJson) => _$FeedbackListResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FeedbackListResultToJson(this);
}
