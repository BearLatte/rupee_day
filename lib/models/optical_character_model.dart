import 'package:json_annotation/json_annotation.dart';

part 'optical_character_model.g.dart';

@JsonSerializable()
class OpticalCharacterModel extends Object {
  @JsonKey(name: 'plkanwsNumber')
  String? panNumber;

  @JsonKey(name: 'ulksewsrNames')
  String? userNames;

  @JsonKey(name: 'alkadwshaarNumber')
  String? aadhaarNumber;

  @JsonKey(name: 'ulksewsrGender')
  String? userGender;

  @JsonKey(name: 'dlkatwseOfBirth')
  String? dateOfBirth;

  @JsonKey(name: 'ilkmawsgeHttp')
  String imageHttp;

  @JsonKey(name: 'ilkmawsgePath')
  String imagePath;

  @JsonKey(name: 'alkddwsressDetail')
  String? addressDetail;

  OpticalCharacterModel(
    this.panNumber,
    this.userNames,
    this.aadhaarNumber,
    this.userGender,
    this.dateOfBirth,
    this.imageHttp,
    this.imagePath,
    this.addressDetail,
  );

  factory OpticalCharacterModel.fromJson(Map<String, dynamic> srcJson) =>
      _$OpticalCharacterModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OpticalCharacterModelToJson(this);
}
