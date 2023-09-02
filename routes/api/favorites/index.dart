import 'package:dart_frog/dart_frog.dart';


/// @Allow(GET, POST)
Response onRequest(RequestContext context) {
  // TODO: implement route handler
  return Response(body: 'This is a new route!');
}
