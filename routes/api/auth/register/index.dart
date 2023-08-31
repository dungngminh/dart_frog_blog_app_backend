import 'dart:async';
import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:stormberry/stormberry.dart';
import 'package:string_validator/string_validator.dart';
import 'package:uuid/uuid.dart';
import 'package:very_good_blog_app_backend/common/hash_extension.dart';
import 'package:very_good_blog_app_backend/dtos/request/auth/register_request.dart';
import 'package:very_good_blog_app_backend/dtos/response/base_response_data.dart';
import 'package:very_good_blog_app_backend/models/user.dart';



/// @Allow(POST)
FutureOr<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.post => _onRegisterRequest(context),
    _ => Future.value(MethodNotAllowedResponse()),
  };
}

Future<Response> _onRegisterRequest(RequestContext context) async {
  final db = context.read<Database>();

  final body = await context.request.body();

  if (body.isEmpty) return BadRequestResponse();

  final request =
      RegisterRequest.fromJson(jsonDecode(body) as Map<String, dynamic>);

  if (request.password != request.confirmationPassword) {
    return BadRequestResponse('Confirmation password not match');
  }

  if (!isEmail(request.email)) {
    return BadRequestResponse('Email format is wrong, please check again');
  }

  final result = await db.query(
    'SELECT * FROM users WHERE email=@email',
    {
      'email': request.email,
    },
  );
  if (result.affectedRowCount > 0) {
    return ConflictResponse('This email was registered');
  }

  try {
    return db.users
        .insertOne(
          UserInsertRequest(
            email: request.email,
            follower: 0,
            following: 0,
            fullName: request.fullName,
            id: const Uuid().v4(),
            password: request.password.hashValue,
          ),
        )
        .then((_) => CreatedResponse());
  } catch (e) {
    return ServerErrorResponse();
  }
}
