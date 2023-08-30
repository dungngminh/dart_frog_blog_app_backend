import 'dart:async';

import 'package:dart_frog/dart_frog.dart';
import 'package:very_good_blog_app_backend/dtos/response/base_response_data.dart';

/// @Allow(POST)
FutureOr<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.post => _onLoginRequest(context),
    _ => Future.value(MethodNotAllowedResponse()),
  };
}

Future<Response> _onLoginRequest(RequestContext context) {
  final hehe = context.read<String>();
  return Future.value(OkResponse({hehe: hehe}));
}
