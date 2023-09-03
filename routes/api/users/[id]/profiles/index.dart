import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stormberry/stormberry.dart';
import 'package:very_good_blog_app_backend/dtos/request/users/edit_user_profile_request.dart';
import 'package:very_good_blog_app_backend/dtos/response/base_response_data.dart';
import 'package:very_good_blog_app_backend/dtos/response/users/profiles/get_user_profile_response.dart';
import 'package:very_good_blog_app_backend/models/user.dart';

/// @Allow(GET, PATCH)
Future<Response> onRequest(
  RequestContext context,
  String id,
) {
  return switch (context.request.method) {
    HttpMethod.get => _onUserByIdGetRequest(context, id),
    HttpMethod.patch => _onUserByIdPatchRequest(context, id),
    _ => Future.value(MethodNotAllowedResponse()),
  };
}

Future<Response> _onUserByIdGetRequest(RequestContext context, String id) {
  return context
      .read<Database>()
      .users
      .queryUser(id)
      .then<Response>(
        (user) => user == null
            ? NotFoundResponse('User not found')
            : OkResponse(GetUserProfileResponse.fromView(user).toJson()),
      )
      .catchError((_) => ServerErrorResponse());
}

Future<Response> _onUserByIdPatchRequest(
  RequestContext context,
  String id,
) async {
  final userView = context.read<UserView>();
  if (userView.id != id) {
    return ForbiddenResponse();
  }
  final body = await context.request.body();
  if (body.isEmpty) {
    return BadRequestResponse();
  }
  try {
    final request =
      EditUserProfileRequest.fromJson(jsonDecode(body) as Map<String, dynamic>);
  return context
      .read<Database>()
      .users
      .updateOne(
        UserUpdateRequest(
          id: userView.id,
          fullName: request.fullName,
          avatarUrl: request.avatarUrl,
        ),
      )
      .then<Response>((_) => OkResponse())
      .onError((e, s) => ServerErrorResponse(e.toString()));
  } on CheckedFromJsonException catch (e) {
    return BadRequestResponse(e.message);
  }
  
}
