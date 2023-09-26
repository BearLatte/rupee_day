import 'package:json_annotation/json_annotation.dart';

part 'auth_params_model.g.dart';

@JsonSerializable()
class AuthParamsModel extends Object {
  @JsonKey(name: 'authStep')
  String authStep;

  @JsonKey(name: 'frontImage')
  String? frontImage;

  @JsonKey(name: 'backImage')
  String? backImage;

  @JsonKey(name: 'userNames')
  String? userNames;

  @JsonKey(name: 'aadhaarNumber')
  String? aadhaarNumber;

  @JsonKey(name: 'dateOfBirth')
  String? dateOfBirth;

  @JsonKey(name: 'userGender')
  String? userGender;

  @JsonKey(name: 'marriageStatus')
  String? marriageStatus;

  @JsonKey(name: 'education')
  String? education;

  @JsonKey(name: 'addressDetail')
  String? addressDetail;

  @JsonKey(name: 'userIndustry')
  String? userIndustry;

  @JsonKey(name: 'workTitle')
  String? workTitle;

  @JsonKey(name: 'monthlySalary')
  String? monthlySalary;

  @JsonKey(name: 'userEmail')
  String? userEmail;

  @JsonKey(name: 'whatsAppAccount')
  String? whatsAppAccount;

  @JsonKey(name: 'facebookId')
  String? facebookId;

  @JsonKey(name: 'panCardImg')
  String? panCardImg;

  @JsonKey(name: 'panNumber')
  String? panNumber;

  @JsonKey(name: 'applyAmount')
  String? applyAmount;

  @JsonKey(name: 'contactList')
  String? contactList;

  @JsonKey(name: 'bankCardName')
  String? bankCardName;

  @JsonKey(name: 'bankCardNo')
  String? bankCardNo;

  @JsonKey(name: 'bankIfscCode')
  String? bankIfscCode;

  AuthParamsModel({
    required this.authStep,
    this.frontImage,
    this.backImage,
    this.userNames,
    this.aadhaarNumber,
    this.dateOfBirth,
    this.userGender,
    this.marriageStatus,
    this.education,
    this.addressDetail,
    this.userIndustry,
    this.workTitle,
    this.monthlySalary,
    this.userEmail,
    this.whatsAppAccount,
    this.facebookId,
    this.panCardImg,
    this.panNumber,
    this.applyAmount,
    this.contactList,
    this.bankCardName,
    this.bankCardNo,
    this.bankIfscCode,
  });

  factory AuthParamsModel.fromJson(Map<String, dynamic> srcJson) => _$AuthParamsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AuthParamsModelToJson(this);
}
