// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_blog_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$GetBlogResponseToJson(GetBlogResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'image_url': instance.imageUrl,
      'category': _$BlogCategoryEnumMap[instance.category]!,
      'is_favorite_by_user': instance.isFavoriteByUser,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'creator': instance.creator.toJson(),
    };

const _$BlogCategoryEnumMap = {
  BlogCategory.business: 'business',
  BlogCategory.technology: 'technology',
  BlogCategory.fashion: 'fashion',
  BlogCategory.travel: 'travel',
  BlogCategory.food: 'food',
  BlogCategory.education: 'education',
};

Map<String, dynamic> _$UserOfGetBlogResponseToJson(
        UserOfGetBlogResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'avatar_url': instance.avatarUrl,
      'following': instance.following,
      'follower': instance.follower,
    };
