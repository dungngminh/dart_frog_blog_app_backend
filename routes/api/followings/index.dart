import 'package:dart_frog/dart_frog.dart';
import 'package:very_good_blog_app_backend/dtos/response/base_response_data.dart';

Future<Response> onRequest(RequestContext context) {
  return switch (context.request.method) {
    HttpMethod.post => Future.value(MethodNotAllowedResponse()),
    _ => Future.value(MethodNotAllowedResponse()),
  };
}

// Future<Response> _onFollowingsPostRequest(RequestContext context){
//   final userView = context.read<UserView>();
  
// }
