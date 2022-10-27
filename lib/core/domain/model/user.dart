import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.username,
    this.password = '',
  });

  const User.anonymous()
      : id = '',
        username = '',
        password = '';

  const User.empty() : this.anonymous();

  final String id;
  final String username;
  final String password;

  @override
  List<Object> get props => [
        id,
        username,
        password,
      ];

  User copyWith({
    String? id,
    String? username,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
