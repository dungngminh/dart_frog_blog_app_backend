import 'package:json_annotation/json_annotation.dart';
import 'package:very_good_blog_app_backend/models/blog.dart';
import 'package:very_good_blog_app_backend/models/blog_category.dart';
import 'package:very_good_blog_app_backend/models/user.dart';

part 'get_blog_response.g.dart';

@JsonSerializable(createFactory: false)
class GetBlogResponse {
  GetBlogResponse({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.creator,
    this.isFavoriteByUser,
  });

  factory GetBlogResponse.fromView(BlogView view, {bool? isFavoriteByUser}) {
    return GetBlogResponse(
      id: view.id,
      title: view.title,
      content: view.content,
      imageUrl: view.imageUrl,
      category: view.category,
      isFavoriteByUser: isFavoriteByUser,
      createdAt: view.createdAt,
      updatedAt: view.updatedAt,
      creator: UserOfGetBlogResponse.fromView(view.creator),
    );
  }

  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final BlogCategory category;
  final bool? isFavoriteByUser;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserOfGetBlogResponse creator;

  Map<String, dynamic> toJson() => _$GetBlogResponseToJson(this);
}

@JsonSerializable(createFactory: false)
class UserOfGetBlogResponse {
  UserOfGetBlogResponse({
    required this.id,
    required this.fullName,
    required this.email,
    required this.following,
    required this.follower,
    this.avatarUrl,
  });

  factory UserOfGetBlogResponse.fromView(UserView view) {
    return UserOfGetBlogResponse(
      id: view.id,
      email: view.email,
      follower: view.follower,
      following: view.following,
      fullName: view.fullName,
      avatarUrl: view.avatarUrl,
    );
  }

  final String id;
  final String fullName;
  final String email;
  final String? avatarUrl;
  final int following;
  final int follower;

  Map<String, dynamic> toJson() => _$UserOfGetBlogResponseToJson(this);
}