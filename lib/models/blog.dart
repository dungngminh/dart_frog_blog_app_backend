import 'package:stormberry/stormberry.dart';
import 'package:very_good_blog_app_backend/models/blog_category.dart';
import 'package:very_good_blog_app_backend/models/user.dart';

part 'blog.schema.dart';

@Model()
abstract class Blog {
  @PrimaryKey()
  String get id;

  String get title;

  String get description;

  @UseConverter(EnumTypeConverter<BlogCategory>(BlogCategory.values))
  BlogCategory get category;

  DateTime get createdAt;

  DateTime get updatedAt;
  @BindTo(#blogs)
  User get creator;
}
