import 'package:dart_frog/dart_frog.dart';

/// @Allow(GET)
Response onRequest(
  RequestContext context,
  String id,
) {
  return Response(body: 'This is a new route!');
}
