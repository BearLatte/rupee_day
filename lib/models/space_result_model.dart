import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_day/models/order_model.dart';
import 'package:rupee_day/models/product_detail_model.dart';
import 'package:rupee_day/models/product_model.dart';

part 'space_result_model.g.dart';

@JsonSerializable()
class SpaceResultModel extends Object {
  @JsonKey(name: 'slkpawsceStatus')
  int spaceStatus;

  @JsonKey(name: 'llkoawsnProduct')
  ProductDetailModel? loanProduct;

  @JsonKey(name: 'plkrowsductList')
  List<ProductModel>? productList;

  @JsonKey(name: 'olkrdwserInfo')
  OrderModel? orderInfo;

  SpaceResultModel(
    this.spaceStatus,
    this.loanProduct,
    this.productList,
    this.orderInfo,
  );

  factory SpaceResultModel.fromJson(Map<String, dynamic> srcJson) =>
      _$SpaceResultModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SpaceResultModelToJson(this);
}
