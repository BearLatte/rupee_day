// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailModel _$ProductDetailModelFromJson(Map<String, dynamic> json) =>
    ProductDetailModel(
      json['plkrowsductId'] as int,
      json['plkrowsductLogo'] as String,
      json['plkrowsductName'] as String,
      json['llkoawsnAmount'] as int,
      json['llkoawsnOfDays'] as int,
      json['llkoawsnPayAmount'] as int,
      json['llkoawsnFeeVerify'] as int,
      json['llkoawsnFeeGst'] as int,
      json['llkoawsnInterest'] as int,
      json['llkoawsnOverdue'] as String,
      json['llkoawsnRepayAmount'] as int,
    );

Map<String, dynamic> _$ProductDetailModelToJson(ProductDetailModel instance) =>
    <String, dynamic>{
      'plkrowsductId': instance.productId,
      'plkrowsductLogo': instance.productLogo,
      'plkrowsductName': instance.productName,
      'llkoawsnAmount': instance.loanAmount,
      'llkoawsnOfDays': instance.loanOfDays,
      'llkoawsnPayAmount': instance.loanPayAmount,
      'llkoawsnFeeVerify': instance.loanFeeVerify,
      'llkoawsnFeeGst': instance.loanFeeGst,
      'llkoawsnInterest': instance.loanInterest,
      'llkoawsnOverdue': instance.loanOverdue,
      'llkoawsnRepayAmount': instance.loanRepayAmount,
    };
