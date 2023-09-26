import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_day/models/product_model.dart'; 
  
part 'purchase_result_model.g.dart';


@JsonSerializable()
  class PurchaseResultModel extends Object {

  @JsonKey(name: 'ilksFwsirstApply')
  int isFirstApply;

  @JsonKey(name: 'plkrowsductList')
  List<ProductModel> productList;

  PurchaseResultModel(this.isFirstApply,this.productList,);

  factory PurchaseResultModel.fromJson(Map<String, dynamic> srcJson) => _$PurchaseResultModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PurchaseResultModelToJson(this);

}