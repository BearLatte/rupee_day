import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel extends Object {
  @JsonKey(name: 'llkoawsnOrderNo')
  String loanOrderNo;

  @JsonKey(name: 'plkrowsductName')
  String productName;

  @JsonKey(name: 'plkrowsductLogo')
  String productLogo;

  @JsonKey(name: 'llkoawsnApplyDate')
  String loanApplyDate;

  @JsonKey(name: 'llkoawsnAmount')
  int loanAmount;

  @JsonKey(name: 'llkoawsnStatus')
  int loanStatus;

  @JsonKey(name: 'blkanwskCardNo')
  String? bankCardNo;

  @JsonKey(name: 'ilksPwsayFail')
  int? isPayFail;

  @JsonKey(name: 'flkrewsezeDays')
  int? freezeDays;

  @JsonKey(name: 'llkoawsnPayAmount')
  double? loanPayAmount;

  @JsonKey(name: 'llkoawsnPayDate')
  String? loanPayDate;

  @JsonKey(name: 'llkoawsnRepayAmount')
  double? loanRepayAmount;

  @JsonKey(name: 'llkoawsnRepayDate')
  String? loanRepayDate;

  @JsonKey(name: 'elkxtwsendButton')
  int? extendButton;

  @JsonKey(name: 'olkvewsrdueDays')
  int? overdueDays;

  @JsonKey(name: 'olkvewsrdueAmount')
  double? overdueAmount;

  OrderModel(
    this.loanOrderNo,
    this.productName,
    this.productLogo,
    this.loanApplyDate,
    this.loanAmount,
    this.loanStatus,
    this.bankCardNo,
    this.isPayFail,
    this.freezeDays,
    this.loanPayAmount,
    this.loanPayDate,
    this.loanRepayAmount,
    this.loanRepayDate,
    this.extendButton,
    this.overdueDays,
    this.overdueAmount,
  );

  factory OrderModel.fromJson(Map<String, dynamic> srcJson) =>
      _$OrderModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
