import 'dart:async';
import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:stormberry/stormberry.dart';
import 'package:string_validator/string_validator.dart';
import 'package:very_good_blog_app_backend/common/hash_extension.dart';
import 'package:very_good_blog_app_backend/common/jwt_extension.dart';
import 'package:very_good_blog_app_backend/dtos/request/auth/login_request.dart';
import 'package:very_good_blog_app_backend/dtos/response/auth/login_response.dart';
import 'package:very_good_blog_app_backend/dtos/response/base_response_data.dart';


/// @Allow(POST)
FutureOr<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.post => _onLoginRequest(context),
    _ => Future.value(MethodNotAllowedResponse()),
  };
}

Future<Response> _onLoginRequest(RequestContext context) async {
  final db = context.read<Database>();

  final body = await context.request.body();

  if (body.isEmpty) return BadRequestResponse();
  final request =
      LoginRequest.fromJson(jsonDecode(body) as Map<String, dynamic>);

  if (!isEmail(request.email)) {
    return BadRequestResponse('Email format is wrong, please check again');
  }
  try {
    final results = await db.query(
      'SELECT * FROM users WHERE email=@email AND password=@password',
      {'email': request.email, 'password': request.password.hashValue},
    );
    final result = results.firstOrNull;
    if (result == null) return NotFoundResponse('User is not registered');
    final response = LoginResponse.fromJson(result.toColumnMap());
    return OkResponse(
      {...response.toJson(), 'token': createToken(response.id)},
    );
  } catch (e) {
    return ServerErrorResponse();
  }
}
