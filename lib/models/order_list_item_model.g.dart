// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderListItemModel _$OrderListItemModelFromJson(Map<String, dynamic> json) =>
    OrderListItemModel(
      json['llkoawsnOrderNo'] as String,
      json['plkrowsductLogo'] as String,
      json['plkrowsductName'] as String,
      json['llkoawsnAmount'] as int,
      json['llkoawsnApplyDate'] as String,
      json['llkoawsnStatus'] as int,
      json['ilksPwsayFail'] as int?,
    );

Map<String, dynamic> _$OrderListItemModelToJson(OrderListItemModel instance) =>
    <String, dynamic>{
      'llkoawsnOrderNo': instance.loanOrderNo,
      'plkrowsductLogo': instance.productLogo,
      'plkrowsductName': instance.productName,
      'llkoawsnAmount': instance.loanAmount,
      'llkoawsnApplyDate': instance.loanApplyDate,
      'llkoawsnStatus': instance.loanStatus,
      'ilksPwsayFail': instance.isPayFail,
    };
