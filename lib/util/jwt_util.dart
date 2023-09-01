import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

String createToken(
  dynamic payload, {
  Duration expiresIn = const Duration(days: 2),
}) {
  final jwt = JWT(payload);
  return jwt.sign(SecretKey('secret passphrase'), expiresIn: expiresIn);
}
