import 'package:json_annotation/json_annotation.dart';

part 'product_detail_model.g.dart';

@JsonSerializable()
class ProductDetailModel extends Object {
  @JsonKey(name: 'plkrowsductId')
  int productId;

  @JsonKey(name: 'plkrowsductLogo')
  String productLogo;

  @JsonKey(name: 'plkrowsductName')
  String productName;

  @JsonKey(name: 'llkoawsnAmount')
  int loanAmount;

  @JsonKey(name: 'llkoawsnOfDays')
  int loanOfDays;

  @JsonKey(name: 'llkoawsnPayAmount')
  int loanPayAmount;

  @JsonKey(name: 'llkoawsnFeeVerify')
  int loanFeeVerify;

  @JsonKey(name: 'llkoawsnFeeGst')
  int loanFeeGst;

  @JsonKey(name: 'llkoawsnInterest')
  int loanInterest;

  @JsonKey(name: 'llkoawsnOverdue')
  String loanOverdue;

  @JsonKey(name: 'llkoawsnRepayAmount')
  int loanRepayAmount;

  ProductDetailModel(
    this.productId,
    this.productLogo,
    this.productName,
    this.loanAmount,
    this.loanOfDays,
    this.loanPayAmount,
    this.loanFeeVerify,
    this.loanFeeGst,
    this.loanInterest,
    this.loanOverdue,
    this.loanRepayAmount,
  );

  factory ProductDetailModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductDetailModelToJson(this);
}
