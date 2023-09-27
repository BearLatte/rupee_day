import 'package:json_annotation/json_annotation.dart';

part 'feedback_model.g.dart';

@JsonSerializable()
class FeedbackModel extends Object {
  @JsonKey(name: 'llkoawsnOrderNo')
  String loanOrderNo;

  @JsonKey(name: 'plkrowsductLogo')
  String productLogo;

  @JsonKey(name: 'plkrowsductName')
  String productName;

  @JsonKey(name: 'flkeewsdBackType')
  String feedBackType;

  @JsonKey(name: 'flkeewsdBackContent')
  String feedBackContent;

  @JsonKey(name: 'flkeewsdBackImg')
  String? feedBackImg;

  @JsonKey(name: 'rlkepwslyContent')
  String? replyContent;

  @JsonKey(name: 'rlkepwslyTime')
  String? replyTime;

  @JsonKey(name: 'flkeewsdBackState')
  int feedBackState;

  @JsonKey(name: 'flkeewsdBackTime')
  String feedBackTime;

  FeedbackModel(
    this.loanOrderNo,
    this.productLogo,
    this.productName,
    this.feedBackType,
    this.feedBackContent,
    this.feedBackImg,
    this.replyContent,
    this.replyTime,
    this.feedBackState,
    this.feedBackTime,
  );

  factory FeedbackModel.fromJson(Map<String, dynamic> srcJson) => _$FeedbackModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FeedbackModelToJson(this);
}
