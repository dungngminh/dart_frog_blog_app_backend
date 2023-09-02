import 'package:json_annotation/json_annotation.dart';

part 'edit_user_profile_request.g.dart';

@JsonSerializable(createToJson: false)
class EditUserProfileRequest {
  EditUserProfileRequest(
    this.fullName,
    this.avatarUrl,
  );

  factory EditUserProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$EditUserProfileRequestFromJson(json);

  final String? fullName;
  final String? avatarUrl;
}
