import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:very_good_blog_app_backend/dtos/response/base_response_data.dart';

/// @Allow(GET, POST)
Response onRequest(RequestContext context) {
  return switch (context.request.method) {
    HttpMethod.get => NotFoundResponse('Error'),
    _ => Response(statusCode: HttpStatus.methodNotAllowed),
  };
}
