// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repay_extension_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepayExtensionModel _$RepayExtensionModelFromJson(Map<String, dynamic> json) =>
    RepayExtensionModel(
      json['llkoawsnOrderNo'] as String?,
      json['plkrowsductName'] as String?,
      json['plkrowsductLogo'] as String?,
      json['llkoawsnRepayDate'] as String?,
      (json['elkxtwsendFee'] as num?)?.toDouble(),
      json['elkxtwsendDays'] as int?,
      json['elkxtwsendRepayDate'] as String?,
      (json['llkoawsnRepayAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RepayExtensionModelToJson(
        RepayExtensionModel instance) =>
    <String, dynamic>{
      'llkoawsnOrderNo': instance.loanOrderNo,
      'plkrowsductName': instance.productName,
      'plkrowsductLogo': instance.productLogo,
      'llkoawsnRepayDate': instance.loanRepayDate,
      'elkxtwsendFee': instance.extendFee,
      'elkxtwsendDays': instance.extendDays,
      'elkxtwsendRepayDate': instance.extendRepayDate,
      'llkoawsnRepayAmount': instance.loanRepayAmount,
    };
