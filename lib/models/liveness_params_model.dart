import 'package:json_annotation/json_annotation.dart'; 
  
part 'liveness_params_model.g.dart';


@JsonSerializable()
  class LivenessParamsModel extends Object {

  @JsonKey(name: 'alkccwsuauthId')
  String accuauthId;

  @JsonKey(name: 'alkccwsuauthSecret')
  String accuauthSecret;

  @JsonKey(name: 'alkccwsuauthHostUrl')
  String accuauthHostUrl;

  LivenessParamsModel(this.accuauthId,this.accuauthSecret,this.accuauthHostUrl,);

  factory LivenessParamsModel.fromJson(Map<String, dynamic> srcJson) => _$LivenessParamsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LivenessParamsModelToJson(this);

}

  
