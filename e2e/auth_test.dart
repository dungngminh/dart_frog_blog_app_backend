import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:very_good_blog_app_backend/common/constants.dart';
import 'package:very_good_blog_app_backend/dtos/request/auth/login_request.dart';
import 'package:very_good_blog_app_backend/dtos/request/auth/register_request.dart';

Map<String, String> headers = {
  HttpHeaders.contentTypeHeader: ContentType.json.value,
};

void main() {
  group('E2E Authentication', () {
    group('Login', () {
      final loginRequest = LoginRequest(
        email: 'ngminhdung1311@gmail.com',
        password: 'kminhdung123',
      );
      final registerRequest = RegisterRequest(
        fullName: 'Mặt gian vcl (from bé nào đó)',
        email: 'ngminhdung1311@gmail.com',
        password: 'kminhdung123',
        confirmationPassword: 'kminhdung123',
      );
      // late LoginResponse loginResponse;
      test(
          'POST /api/auth/login return BadRequestResponse(User is not registered)',
          () async {
        final response = await http.post(
          Uri.parse('http://localhost:8080/api/auth/login'),
          headers: headers,
          body: jsonEncode(loginRequest.toJson()),
        );

        expect(response.statusCode, HttpStatus.badRequest);
        expect(
          jsonDecode(response.body),
          equals({
            'success': false,
            'message': 'User is not registered',
          }),
        );
      });

      test('POST /api/auth/register return CreatedResponse()', () async {
        final response = await http.post(
          Uri.parse('http://localhost:8080/api/auth/register'),
          headers: headers,
          body: jsonEncode(registerRequest.toJson()),
        );

        expect(response.statusCode, HttpStatus.created);
        expect(
          jsonDecode(response.body),
          equals({
            'success': true,
            'message': kSuccessResponseMessage,
          }),
        );
      });

      test('POST /api/auth/register return BadRequestResponse()', () async {
        final response = await http.post(
          Uri.parse('http://localhost:8080/api/auth/register'),
          headers: headers,
          body: jsonEncode(registerRequest.toJson()),
        );

        expect(response.statusCode, HttpStatus.conflict);
        expect(
          jsonDecode(response.body),
          equals({
            'success': false,
            'message': 'This email was registered',
          }),
        );
      });
    });
  });
}
