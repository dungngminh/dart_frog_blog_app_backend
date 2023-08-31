import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:very_good_blog_app_backend/models/user.dart';

Handler middleware(Handler handler) {
  return handler.use(
    bearerAuthentication<User>(
      authenticator: (context, token) async {
        // final db = context.read<Database>();
        return null;
        // return db.users.queryUser()
      },
    ),
  );
}
