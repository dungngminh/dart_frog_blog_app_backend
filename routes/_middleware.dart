import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<Handler> middleware(Handler handler) async {
  final db = Db('mongodb://127.0.0.1:27017/blog_app');
  await db.open();
  return handler
    ..use(requestLogger())
    ..use(provider<Db>((_) => db));
}
