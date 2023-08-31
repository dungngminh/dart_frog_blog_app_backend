import 'package:stormberry/stormberry.dart';
import 'package:very_good_blog_app_backend/models/blog.dart';

part 'user.schema.dart';

@Model()
abstract class User {
  @PrimaryKey()
  String get id;

  String get fullName;

  String get email;

  String get password;

  String? get avatarUrl;

  int get following;

  int get follower;
  @BindTo(#creator)
  List<Blog> get blogs;
}
