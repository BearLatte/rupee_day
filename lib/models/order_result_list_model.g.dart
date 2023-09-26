// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_result_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResultListModel _$OrderResultListModelFromJson(
        Map<String, dynamic> json) =>
    OrderResultListModel(
      (json['olkrdwserList'] as List<dynamic>)
          .map((e) => OrderListItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['flkeewsdBackTypes'] as List<dynamic>)
          .map((e) => FeedbackTypeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderResultListModelToJson(
        OrderResultListModel instance) =>
    <String, dynamic>{
      'olkrdwserList': instance.orderList,
      'flkeewsdBackTypes': instance.feedBackTypes,
    };
