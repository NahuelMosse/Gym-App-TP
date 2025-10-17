import '../../../../core/entities/user.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final DateTime updatedAt;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.updatedAt,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final email = json['email'];
    final name = json['name'];
    final updatedAt = json['updated_at'];
    final createdAt = json['created_at'];

    if (id == null) {
      throw Exception('User id is required but was null. JSON: $json');
    }
    if (email == null) {
      throw Exception('User email is required but was null. JSON: $json');
    }
    if (name == null) {
      throw Exception('User name is required but was null. JSON: $json');
    }
    if (updatedAt == null) {
      throw Exception('User updated_at is required but was null. JSON: $json');
    }
    if (createdAt == null) {
      throw Exception('User created_at is required but was null. JSON: $json');
    }

    return UserModel(
      id: id as String,
      email: email as String,
      name: name as String,
      updatedAt: DateTime.parse(updatedAt as String),
      createdAt: DateTime.parse(createdAt as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  User toEntity() {
    return User(
      id: id,
      email: email,
      name: name,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      updatedAt: user.updatedAt,
      createdAt: user.createdAt,
    );
  }
}