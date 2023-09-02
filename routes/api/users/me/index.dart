import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stormberry/stormberry.dart';
import 'package:very_good_blog_app_backend/dtos/request/users/edit_user_profile_request.dart';
import 'package:very_good_blog_app_backend/dtos/response/base_response_data.dart';
import 'package:very_good_blog_app_backend/dtos/response/blogs/get_user_blog_response.dart';
import 'package:very_good_blog_app_backend/dtos/response/users/get_user_response.dart';
import 'package:very_good_blog_app_backend/models/blog.dart';
import 'package:very_good_blog_app_backend/models/user.dart';

/// @Allow(GET, PATCH)
Future<Response> onRequest(RequestContext context) {
  return switch (context.request.method) {
    HttpMethod.get => _onUsersMeGetRequest(context),
    HttpMethod.patch => _onUsersMePatchRequest(context),
    _ => Future.value(MethodNotAllowedResponse())
  };
}

Future<Response> _onUsersMeGetRequest(RequestContext context) async {
  final db = context.read<Database>();
  final userView = context.read<UserView>();
  try {
    final blogs = await db.blogs.queryBlogs(
      QueryParams(
        where: 'creator_id = @id',
        values: {'id': userView.id},
      ),
    );
    final getUserBlogResponse = blogs.map(GetUserBlogResponse.fromView);
    return OkResponse({
      'user': GetUserResponse.fromView(userView).toJson(),
      'blogs': getUserBlogResponse.map((e) => e.toJson()).toList(),
    });
  } catch (e) {
    return ServerErrorResponse(e.toString());
  }
}

Future<Response> _onUsersMePatchRequest(RequestContext context) async {
  final userView = context.read<UserView>();
  final db = context.read<Database>();
  final body = await context.request.body();
  if (body.isEmpty) {
    return BadRequestResponse();
  }
  try {
    final request = EditUserProfileRequest.fromJson(
      jsonDecode(body) as Map<String, dynamic>,
    );

    await db.users.updateOne(
      UserUpdateRequest(
        id: userView.id,
        fullName: request.fullName,
        avatarUrl: request.avatarUrl,
      ),
    );
    return OkResponse();
  } on CheckedFromJsonException catch (e) {
    return BadRequestResponse(e.message);
  } catch (e) {
    return ServerErrorResponse(e.toString());
  }
}
