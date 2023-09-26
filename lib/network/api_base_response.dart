import 'package:json_annotation/json_annotation.dart';

part 'api_base_response.g.dart';

@JsonSerializable()
class ApiBaseResponse extends Object {
  @JsonKey(name: 'data')
  Map<String, dynamic>? data;

  @JsonKey(name: 'resultCode')
  int resultCode;

  @JsonKey(name: 'resultMsg')
  String resultMsg;

  ApiBaseResponse(
    this.data,
    this.resultCode,
    this.resultMsg,
  );

  factory ApiBaseResponse.fromJson(Map<String, dynamic> srcJson) =>
      _$ApiBaseResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ApiBaseResponseToJson(this);
}
