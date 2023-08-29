import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:very_good_blog_app_backend/repository/auth_repository.dart';

Handler middleware(Handler handler) {
  return handler
    ..use(requestLogger())
    ..use(
      provider<AuthRepository>(
        (context) => AuthRepositoryImpl(db: context.read<Db>()),
      ),
    );
}
