// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      json['llkoawsnOrderNo'] as String,
      json['plkrowsductName'] as String,
      json['plkrowsductLogo'] as String,
      json['llkoawsnApplyDate'] as String,
      json['llkoawsnAmount'] as int,
      json['llkoawsnStatus'] as int,
      json['blkanwskCardNo'] as String?,
      json['ilksPwsayFail'] as int?,
      json['flkrewsezeDays'] as int?,
      (json['llkoawsnPayAmount'] as num?)?.toDouble(),
      json['llkoawsnPayDate'] as String?,
      (json['llkoawsnRepayAmount'] as num?)?.toDouble(),
      json['llkoawsnRepayDate'] as String?,
      json['elkxtwsendButton'] as int?,
      json['olkvewsrdueDays'] as int?,
      (json['olkvewsrdueAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'llkoawsnOrderNo': instance.loanOrderNo,
      'plkrowsductName': instance.productName,
      'plkrowsductLogo': instance.productLogo,
      'llkoawsnApplyDate': instance.loanApplyDate,
      'llkoawsnAmount': instance.loanAmount,
      'llkoawsnStatus': instance.loanStatus,
      'blkanwskCardNo': instance.bankCardNo,
      'ilksPwsayFail': instance.isPayFail,
      'flkrewsezeDays': instance.freezeDays,
      'llkoawsnPayAmount': instance.loanPayAmount,
      'llkoawsnPayDate': instance.loanPayDate,
      'llkoawsnRepayAmount': instance.loanRepayAmount,
      'llkoawsnRepayDate': instance.loanRepayDate,
      'elkxtwsendButton': instance.extendButton,
      'olkvewsrdueDays': instance.overdueDays,
      'olkvewsrdueAmount': instance.overdueAmount,
    };
