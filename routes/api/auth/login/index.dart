import 'package:dart_frog/dart_frog.dart';
import 'package:very_good_blog_app_backend/dtos/response/base_response_data.dart';

/// @Allow(POST)
Future<Response> onRequest(RequestContext context) {
  return switch (context.request.method) {
    HttpMethod.post => _onLoginRequest(context),
    _ => Future.value(MethodNotAllowedResponse())
  };
}

Future<Response> _onLoginRequest(RequestContext context) async {
  return OkResponse();
}
