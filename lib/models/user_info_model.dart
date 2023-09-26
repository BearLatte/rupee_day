import 'package:json_annotation/json_annotation.dart';
import 'package:rupee_day/models/product_model.dart';
import 'product_detail_model.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfoModel extends Object {
  @JsonKey(name: 'ulksewsrStatus')
  int userStatus;

  @JsonKey(name: 'alkudwsitPhone')
  int auditPhone;

  @JsonKey(name: 'plkhowstoContent')
  String photoContent;

  @JsonKey(name: 'glkpswsContent')
  String gpsContent;

  @JsonKey(name: 'plkhowsneContent')
  String phoneContent;

  @JsonKey(name: 'clkonwstactNum')
  int contactNum;

  @JsonKey(name: 'ulksewsrLiveness')
  int userLiveness;

  @JsonKey(name: 'tlkhiwsrdLiveness')
  String thirdLiveness;

  @JsonKey(name: 'ulksewsrPayFail')
  int userPayFail;

  @JsonKey(name: 'plkaywsFailLogo')
  String payFailLogo;

  @JsonKey(name: 'plkaywsFailContent')
  String payFailContent;

  @JsonKey(name: 'plkaywsFailLoanName')
  String payFailLoanName;

  @JsonKey(name: 'plkaywsFailLoanNo')
  String payFailLoanNo;

  @JsonKey(name: 'plkrowsductList')
  List<ProductModel> productList;

  @JsonKey(name: 'llkoawsnProduct')
  ProductDetailModel? loanProduct;

  UserInfoModel(
    this.userStatus,
    this.auditPhone,
    this.photoContent,
    this.gpsContent,
    this.phoneContent,
    this.contactNum,
    this.userLiveness,
    this.thirdLiveness,
    this.userPayFail,
    this.payFailLogo,
    this.payFailContent,
    this.payFailLoanName,
    this.payFailLoanNo,
    this.productList,
    this.loanProduct,
  );

  factory UserInfoModel.fromJson(Map<String, dynamic> srcJson) =>
      _$UserInfoModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}
