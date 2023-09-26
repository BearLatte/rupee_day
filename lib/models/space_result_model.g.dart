// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpaceResultModel _$SpaceResultModelFromJson(Map<String, dynamic> json) =>
    SpaceResultModel(
      json['slkpawsceStatus'] as int,
      json['llkoawsnProduct'] == null
          ? null
          : ProductDetailModel.fromJson(
              json['llkoawsnProduct'] as Map<String, dynamic>),
      (json['plkrowsductList'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['olkrdwserInfo'] == null
          ? null
          : OrderModel.fromJson(json['olkrdwserInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SpaceResultModelToJson(SpaceResultModel instance) =>
    <String, dynamic>{
      'slkpawsceStatus': instance.spaceStatus,
      'llkoawsnProduct': instance.loanProduct,
      'plkrowsductList': instance.productList,
      'olkrdwserInfo': instance.orderInfo,
    };
