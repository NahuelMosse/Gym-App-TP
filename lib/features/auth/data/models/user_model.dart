import '../../../../core/entities/user.dart';
import '../../../../core/errors/exceptions.dart';

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
      throw const ParseException(message: 'User id is required but was null');
    }
    if (email == null) {
      throw const ParseException(message: 'User email is required but was null');
    }
    if (name == null) {
      throw const ParseException(message: 'User name is required but was null');
    }
    if (updatedAt == null) {
      throw const ParseException(message: 'User updated_at is required but was null');
    }
    if (createdAt == null) {
      throw const ParseException(message: 'User created_at is required but was null');
    }

    try {
      return UserModel(
        id: id as String,
        email: email as String,
        name: name as String,
        updatedAt: DateTime.parse(updatedAt as String),
        createdAt: DateTime.parse(createdAt as String),
      );
    } catch (e) {
      throw ParseException(
        message: 'Failed to parse UserModel: ${e.toString()}',
      );
    }
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