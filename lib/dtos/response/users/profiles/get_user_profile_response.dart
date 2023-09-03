import 'package:json_annotation/json_annotation.dart';
import 'package:very_good_blog_app_backend/models/user.dart';

part 'get_user_profile_response.g.dart';

@JsonSerializable()
class GetUserProfileResponse {
  GetUserProfileResponse({
    required this.id,
    required this.fullName,
    required this.email,
    required this.following,
    required this.follower,
    this.avatarUrl,
  });

  factory GetUserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserProfileResponseFromJson(json);

  factory GetUserProfileResponse.fromView(UserView view) {
    return GetUserProfileResponse(
      id: view.id,
      fullName: view.fullName,
      email: view.email,
      following: view.following,
      follower: view.follower,
      avatarUrl: view.avatarUrl,
    );
  }

  final String id;
  final String fullName;
  final String email;
  final String? avatarUrl;
  final int following;
  final int follower;

  Map<String, dynamic> toJson() => _$GetUserProfileResponseToJson(this);
}
