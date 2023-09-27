import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_day/models/product_model.dart';

import 'order_model.dart';

part 'order_detail_result_model.g.dart';

@JsonSerializable()
class OrderDetailResultModel extends Object {
  @JsonKey(name: 'plkrowsductList')
  List<ProductModel>? productList;

  @JsonKey(name: 'olkrdwserInfo')
  OrderModel orderInfo;

  OrderDetailResultModel(
    this.productList,
    this.orderInfo,
  );

  factory OrderDetailResultModel.fromJson(Map<String, dynamic> srcJson) => _$OrderDetailResultModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OrderDetailResultModelToJson(this);
}
