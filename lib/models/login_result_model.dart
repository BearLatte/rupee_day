import 'package:json_annotation/json_annotation.dart';

part 'login_result_model.g.dart';

@JsonSerializable()
class LoginResultModel extends Object {
  @JsonKey(name: 'llkogwsinToken')
  String loginToken;

  @JsonKey(name: 'ilksRwsegistered')
  int isRegistered;

  LoginResultModel(
    this.loginToken,
    this.isRegistered,
  );

  factory LoginResultModel.fromJson(Map<String, dynamic> srcJson) =>
      _$LoginResultModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LoginResultModelToJson(this);
}
