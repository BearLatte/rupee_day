import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_day/models/feedback_type_model.dart';
import 'package:rupee_day/models/order_list_item_model.dart';

part 'order_result_list_model.g.dart';

@JsonSerializable()
class OrderResultListModel extends Object {
  @JsonKey(name: 'olkrdwserList')
  List<OrderListItemModel> orderList;

  @JsonKey(name: 'flkeewsdBackTypes')
  List<FeedbackTypeModel> feedBackTypes;

  OrderResultListModel(
    this.orderList,
    this.feedBackTypes,
  );

  factory OrderResultListModel.fromJson(Map<String, dynamic> srcJson) => _$OrderResultListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OrderResultListModelToJson(this);
}
