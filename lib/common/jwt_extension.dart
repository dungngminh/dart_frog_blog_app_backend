import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

String createToken(dynamic payload) {
  final jwt = JWT(payload);
  return jwt.sign(SecretKey('secret passphrase'));
}
