import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:very_good_blog_app_backend/models/user.dart';
import 'package:very_good_blog_app_backend/util/jwt_handler.dart';

Handler middleware(Handler handler) {
  return handler.use(
    bearerAuthentication<UserView>(
      authenticator: (context, token) async {
        return context.read<JwtHandler>().userFromToken(token);
      },
      applies: (context) async => context.request.method != HttpMethod.get,
    ),
  );
}
