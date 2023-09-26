import 'package:json_annotation/json_annotation.dart';

part 'image_upload_params.g.dart';

@JsonSerializable()
class ImageUploadParams extends Object {
  @JsonKey(name: 'alkwswsBucket')
  String awsBucket;

  @JsonKey(name: 'alkwswsFolder')
  String awsFolder;

  @JsonKey(name: 'clkrewsdentials')
  Credentials credentials;

  @JsonKey(name: 'alkwswsRegion')
  String awsRegion;

  @JsonKey(name: 'alkwswsImgHttp')
  String awsImgHttp;

  ImageUploadParams(
    this.awsBucket,
    this.awsFolder,
    this.credentials,
    this.awsRegion,
    this.awsImgHttp,
  );

  factory ImageUploadParams.fromJson(Map<String, dynamic> srcJson) =>
      _$ImageUploadParamsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ImageUploadParamsToJson(this);
}

@JsonSerializable()
class Credentials extends Object {
  @JsonKey(name: 'accessKeyId')
  String accessKeyId;

  @JsonKey(name: 'secretAccessKey')
  String secretAccessKey;

  @JsonKey(name: 'sessionToken')
  String sessionToken;

  @JsonKey(name: 'expiration')
  int expiration;

  Credentials(
    this.accessKeyId,
    this.secretAccessKey,
    this.sessionToken,
    this.expiration,
  );

  factory Credentials.fromJson(Map<String, dynamic> srcJson) =>
      _$CredentialsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CredentialsToJson(this);
}
