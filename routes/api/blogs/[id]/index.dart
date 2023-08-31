
import 'package:dart_frog/dart_frog.dart';
import 'package:very_good_blog_app_backend/dtos/response/base_response_data.dart';

/// @Allow(GET, PATCH, DELETE)
Future<Response> onRequest(RequestContext context, String id) {
  return switch (context.request.method) {
    HttpMethod.get => _onBlogsGetRequest(context),
    HttpMethod.patch => _onBlogsPatchRequest(context),
    HttpMethod.delete => _onBlogsDeleteRequest(context),
    _ => Future.value(MethodNotAllowedResponse()),
  };
}

Future<Response> _onBlogsGetRequest(RequestContext context) async {
  return OkResponse();
}

Future<Response> _onBlogsPatchRequest(RequestContext context) async {
  return OkResponse();
}

Future<Response> _onBlogsDeleteRequest(RequestContext context) async {
  return OkResponse();
}
