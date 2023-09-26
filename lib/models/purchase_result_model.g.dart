// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseResultModel _$PurchaseResultModelFromJson(Map<String, dynamic> json) =>
    PurchaseResultModel(
      json['ilksFwsirstApply'] as int,
      (json['plkrowsductList'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PurchaseResultModelToJson(
        PurchaseResultModel instance) =>
    <String, dynamic>{
      'ilksFwsirstApply': instance.isFirstApply,
      'plkrowsductList': instance.productList,
    };
