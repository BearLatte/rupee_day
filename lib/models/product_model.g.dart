// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      json['plkrowsductId'] as int,
      json['plkrowsductLogo'] as String,
      json['plkrowsductName'] as String,
      json['plkrowsductDays'] as String,
      json['plkrowsductAmount'] as String,
      json['plkrowsductRate'] as String,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'plkrowsductId': instance.productId,
      'plkrowsductLogo': instance.productLogo,
      'plkrowsductName': instance.productName,
      'plkrowsductDays': instance.productDays,
      'plkrowsductAmount': instance.productAmount,
      'plkrowsductRate': instance.productRate,
    };
