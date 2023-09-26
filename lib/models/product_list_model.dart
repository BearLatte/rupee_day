import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_day/models/product_model.dart';

part 'product_list_model.g.dart';

@JsonSerializable()
class ProductListModel extends Object {
  @JsonKey(name: 'plkrowsductList')
  List<ProductModel> productList;

  ProductListModel(
    this.productList,
  );

  factory ProductListModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ProductListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductListModelToJson(this);
}
