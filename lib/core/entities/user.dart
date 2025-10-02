import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final DateTime updatedAt;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.updatedAt,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, updatedAt: $updatedAt, createdAt: $createdAt)';
  }

  // Equatable
  @override
  List<Object> get props => [id, email, name, updatedAt, createdAt];

  // Equatable
  @override
  bool get stringify => true;
}