import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Object {
  @JsonKey(name: 'plkrowsductId')
  int productId;

  @JsonKey(name: 'plkrowsductLogo')
  String productLogo;

  @JsonKey(name: 'plkrowsductName')
  String productName;

  @JsonKey(name: 'plkrowsductDays')
  String productDays;

  @JsonKey(name: 'plkrowsductAmount')
  String productAmount;

  @JsonKey(name: 'plkrowsductRate')
  String productRate;

  ProductModel(
    this.productId,
    this.productLogo,
    this.productName,
    this.productDays,
    this.productAmount,
    this.productRate,
  );

  factory ProductModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
