import 'package:equatable/equatable.dart';
import 'package:very_good_blog_app_backend/models/blog_category.dart';
import 'package:very_good_blog_app_backend/models/user.dart';

class Blog extends Equatable {
  const Blog({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.creator,
  });

  final String id;
  final String title;
  final String description;
  final BlogCategory category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User creator;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      category,
      createdAt,
      updatedAt,
    ];
  }
}
