import 'package:json_annotation/json_annotation.dart';

part 'repay_extension_model.g.dart';

@JsonSerializable()
class RepayExtensionModel extends Object {
  @JsonKey(name: 'llkoawsnOrderNo')
  String? loanOrderNo;

  @JsonKey(name: 'plkrowsductName')
  String? productName;

  @JsonKey(name: 'plkrowsductLogo')
  String? productLogo;

  @JsonKey(name: 'llkoawsnRepayDate')
  String? loanRepayDate;

  @JsonKey(name: 'elkxtwsendFee')
  double? extendFee;

  @JsonKey(name: 'elkxtwsendDays')
  int? extendDays;

  @JsonKey(name: 'elkxtwsendRepayDate')
  String? extendRepayDate;

  @JsonKey(name: 'llkoawsnRepayAmount')
  double? loanRepayAmount;

  RepayExtensionModel(
    this.loanOrderNo,
    this.productName,
    this.productLogo,
    this.loanRepayDate,
    this.extendFee,
    this.extendDays,
    this.extendRepayDate,
    this.loanRepayAmount,
  );

  factory RepayExtensionModel.fromJson(Map<String, dynamic> srcJson) => _$RepayExtensionModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RepayExtensionModelToJson(this);
}
