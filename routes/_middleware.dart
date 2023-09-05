import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:stormberry/stormberry.dart';

final db = Database(
  host: Platform.environment['PGHOST'],
  port: int.tryParse(Platform.environment['PGPORT'] ?? '5432'),
  database: Platform.environment['PGDATABASE'],
  user: Platform.environment['PGUSER'],
  password: Platform.environment['PGPASSWORD'],
  useSSL: false,
);

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      // .use(fromShelfMiddleware(enforceSSL()))
      .use(provider<Database>((_) => db));
}
