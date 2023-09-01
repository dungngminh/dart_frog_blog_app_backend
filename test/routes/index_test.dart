import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:very_good_blog_app_backend/common/constants.dart';

import '../../routes/index.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('GET /', () {
    test('responds with a 400 and returns BaseResponseData.failed().', () {
      final context = _MockRequestContext();
      final response = route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.notFound));
      expect(
        response.json(),
        completion(
          equals(
            {'success': false, 'message': kFailedResponseMessage},
          ),
        ),
      );
    });
  });
}
