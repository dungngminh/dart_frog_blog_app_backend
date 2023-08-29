import 'package:mongo_dart/mongo_dart.dart';
import 'package:very_good_blog_app_backend/common/hash_extension.dart';
import 'package:very_good_blog_app_backend/dtos/request/login_request.dart';
import 'package:very_good_blog_app_backend/models/user.dart';

abstract class AuthRepository {
  Future<String> login(LoginRequest request);

  Future<void> register();
}

final authDB = <String, User>{};

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required Db db}) : _db = db;

  final Db _db;

  @override
  Future<User?> login(LoginRequest request) {
    final hashedPassword = request.password.hashValue;
    
  }

  @override
  Future<void> register() {}
}
