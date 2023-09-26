import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_day/util/hex_corlor.dart';

part 'order_list_item_model.g.dart';

@JsonSerializable()
class OrderListItemModel extends Object {
  @JsonKey(name: 'llkoawsnOrderNo')
  String loanOrderNo;

  @JsonKey(name: 'plkrowsductLogo')
  String productLogo;

  @JsonKey(name: 'plkrowsductName')
  String productName;

  @JsonKey(name: 'llkoawsnAmount')
  int loanAmount;

  @JsonKey(name: 'llkoawsnApplyDate')
  String loanApplyDate;

  @JsonKey(name: 'llkoawsnStatus')
  int loanStatus;

  @JsonKey(name: 'ilksPwsayFail')
  int? isPayFail;

  String get typeText {
    switch (loanStatus) {
      case 1:
        return 'Pending';
      case 2:
        return 'Disbursing';
      case 3:
        return 'To be Repaid';
      case 4:
        return 'Repaid';
      case 5:
        return 'Disbursing Fail';
      case 6:
        return 'Overdue';
      default:
        return '';
    }
  }

  Color get typeColor {
    switch (loanStatus) {
      case 1:
        return HexColor('#1589EE');
      case 2:
        return HexColor('#6BC377');
      case 3:
        return HexColor('#F19705');
      case 4:
        return HexColor('#999999');
      case 5:
        return HexColor('#F052E1');
      case 6:
        return HexColor('#EA4949');
      default:
        return Colors.orange;
    }
  }

  OrderListItemModel(
    this.loanOrderNo,
    this.productLogo,
    this.productName,
    this.loanAmount,
    this.loanApplyDate,
    this.loanStatus,
    this.isPayFail,
  );

  factory OrderListItemModel.fromJson(Map<String, dynamic> srcJson) => _$OrderListItemModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OrderListItemModelToJson(this);
}
