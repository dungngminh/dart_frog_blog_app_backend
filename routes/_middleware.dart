import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:stormberry/stormberry.dart';

final db = Database(
  host: '127.0.0.1',
  port: 5432,
  database: Platform.environment['DB_NAME'],
  user: Platform.environment['DB_USER'],
  password: Platform.environment['DB_PASSWORD'],
  useSSL: false,
);
    
Handler middleware(Handler handler) {
  return handler
      .use(requestLogger()).use(provider<Database>((_) => db));
}
