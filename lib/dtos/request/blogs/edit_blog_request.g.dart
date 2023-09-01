// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_blog_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditBlogRequest _$EditBlogRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'EditBlogRequest',
      json,
      ($checkedConvert) {
        final val = EditBlogRequest(
          $checkedConvert('title', (v) => v as String?),
          $checkedConvert('content', (v) => v as String?),
          $checkedConvert('image_url', (v) => v as String?),
          $checkedConvert(
              'category', (v) => $enumDecodeNullable(_$BlogCategoryEnumMap, v)),
        );
        return val;
      },
      fieldKeyMap: const {'imageUrl': 'image_url'},
    );

const _$BlogCategoryEnumMap = {
  BlogCategory.business: 'business',
  BlogCategory.technology: 'technology',
  BlogCategory.fashion: 'fashion',
  BlogCategory.travel: 'travel',
  BlogCategory.food: 'food',
  BlogCategory.education: 'education',
};
