import 'package:dart_frog/dart_frog.dart';
import 'package:stormberry/stormberry.dart';
import 'package:very_good_blog_app_backend/dtos/response/base_response_data.dart';
import 'package:very_good_blog_app_backend/dtos/response/users/get_user_response.dart';
import 'package:very_good_blog_app_backend/models/user.dart';

/// @Allow(GET)
Future<Response> onRequest(
  RequestContext context,
  String id,
) {
  return switch (context.request.method) {
    HttpMethod.get => _onUserByIdGetRequest(context, id),
    _ => Future.value(MethodNotAllowedResponse()),
  };
}

Future<Response> _onUserByIdGetRequest(
  RequestContext context,
  String id,
) async {
  final db = context.read<Database>();
  try {
    final user = await db.users.queryUser(id);
    if (user == null) return NotFoundResponse('User not found');
    return OkResponse(GetUserResponse.fromView(user).toJson());
  } catch (e) {
    return ServerErrorResponse(e.toString());
  }
}
