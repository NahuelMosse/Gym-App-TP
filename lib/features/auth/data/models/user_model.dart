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
    final id = json['id'] as String?;
    final email = json['email'] as String?;
    final name = json['name'] as String?;
    final updatedAtStr = json['updated_at'] as String?;
    final createdAtStr = json['created_at'] as String?;

    if (id == null || id.isEmpty) {
      throw const InvalidResponseException(
        message: 'User ID is missing in server response',
      );
    }

    if (email == null || email.isEmpty) {
      throw const InvalidResponseException(
        message: 'User email is missing in server response',
      );
    }

    if (name == null || name.isEmpty) {
      throw const InvalidResponseException(
        message: 'User name is missing in server response',
      );
    }

    if (updatedAtStr == null || updatedAtStr.isEmpty) {
      throw const InvalidResponseException(
        message: 'User updated_at is missing in server response',
      );
    }

    if (createdAtStr == null || createdAtStr.isEmpty) {
      throw const InvalidResponseException(
        message: 'User created_at is missing in server response',
      );
    }

    DateTime updatedAt;
    DateTime createdAt;

    try {
      updatedAt = DateTime.parse(updatedAtStr);
    } catch (e) {
      throw const InvalidResponseException(
        message: 'Invalid updated_at format in server response',
      );
    }

    try {
      createdAt = DateTime.parse(createdAtStr);
    } catch (e) {
      throw const InvalidResponseException(
        message: 'Invalid created_at format in server response',
      );
    }

    return UserModel(
      id: id,
      email: email,
      name: name,
      updatedAt: updatedAt,
      createdAt: createdAt,
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