import 'package:json_annotation/json_annotation.dart';

part 'auth_info_model.g.dart';

@JsonSerializable()
class AuthInfoModel extends Object {
  @JsonKey(name: 'alkudwsitPhone')
  int auditPhone;

  @JsonKey(name: 'ilkmawsgeHttp')
  String imageHttp;

  @JsonKey(name: 'alkmowsuntMin')
  int amountMin;

  @JsonKey(name: 'alkmowsuntMax')
  int amountMax;

  @JsonKey(name: 'clkonwstactNum')
  int contactNum;

  @JsonKey(name: 'flkrowsntImage')
  String frontImage;

  @JsonKey(name: 'blkacwskImage')
  String backImage;

  @JsonKey(name: 'ulksewsrNames')
  String userNames;

  @JsonKey(name: 'alkadwshaarNumber')
  String aadhaarNumber;

  @JsonKey(name: 'dlkatwseOfBirth')
  String dateOfBirth;

  @JsonKey(name: 'ulksewsrGender')
  String userGender;

  @JsonKey(name: 'mlkarwsriageStatus')
  String marriageStatus;

  @JsonKey(name: 'elkduwscation')
  String education;

  @JsonKey(name: 'alkddwsressDetail')
  String addressDetail;

  @JsonKey(name: 'ulksewsrIndustry')
  String userIndustry;

  @JsonKey(name: 'wlkorwskTitle')
  String workTitle;

  @JsonKey(name: 'mlkonwsthlySalary')
  String monthlySalary;

  @JsonKey(name: 'ulksewsrEmail')
  String userEmail;

  @JsonKey(name: 'wlkhawstsAppAccount')
  String whatsAppAccount;

  @JsonKey(name: 'flkacwsebookId')
  String facebookId;

  @JsonKey(name: 'plkanwsCardImg')
  String panCardImg;

  @JsonKey(name: 'plkanwsNumber')
  String panNumber;

  @JsonKey(name: 'alkppwslyAmount')
  String applyAmount;

  @JsonKey(name: 'clkonwstactList')
  String contactList;

  @JsonKey(name: 'blkanwskCardName')
  String bankCardName;

  @JsonKey(name: 'blkanwskCardNo')
  String bankCardNo;

  @JsonKey(name: 'blkanwskIfscCode')
  String bankIfscCode;

  @JsonKey(name: 'ulksewsrGenderList')
  List<String> userGenderList;

  @JsonKey(name: 'elkduwscationList')
  List<String> educationList;

  @JsonKey(name: 'mlkarwsriageStatusList')
  List<String> marriageStatusList;

  @JsonKey(name: 'wlkorwskTitleList')
  List<String> workTitleList;

  @JsonKey(name: 'ilkndwsustryList')
  List<String> industryList;

  @JsonKey(name: 'mlkonwsthlySalaryList')
  List<String> monthlySalaryList;

  @JsonKey(name: 'rlkelwsationList')
  List<String> relationList;

  AuthInfoModel(
    this.auditPhone,
    this.imageHttp,
    this.amountMin,
    this.amountMax,
    this.contactNum,
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
    this.userGenderList,
    this.educationList,
    this.marriageStatusList,
    this.workTitleList,
    this.industryList,
    this.monthlySalaryList,
    this.relationList,
  );

  factory AuthInfoModel.fromJson(Map<String, dynamic> srcJson) =>
      _$AuthInfoModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AuthInfoModelToJson(this);
}
