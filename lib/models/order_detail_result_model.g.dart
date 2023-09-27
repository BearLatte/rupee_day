// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailResultModel _$OrderDetailResultModelFromJson(
        Map<String, dynamic> json) =>
    OrderDetailResultModel(
      (json['plkrowsductList'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      OrderModel.fromJson(json['olkrdwserInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderDetailResultModelToJson(
        OrderDetailResultModel instance) =>
    <String, dynamic>{
      'plkrowsductList': instance.productList,
      'olkrdwserInfo': instance.orderInfo,
    };
