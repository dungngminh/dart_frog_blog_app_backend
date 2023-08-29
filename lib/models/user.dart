import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.avatarUrl,
    required this.following,
    required this.follower,
  });

  final String id;
  final String fullName;
  final String email;
  final String avatarUrl;
  final int following;
  final int follower;

  @override
  List<Object?> get props {
    return [
      id,
      fullName,
      email,
      avatarUrl,
      following,
      follower,
    ];
  }
}
