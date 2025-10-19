import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_helper.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/interfaces/base_interfaces.dart';
import '../models/user_model.dart';

abstract class DatabaseAuthDataSource extends BaseDataSource {
  Future<void> createUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<UserModel?> getUserById(String id);
  Future<void> deleteUserById(String id);
}

class DatabaseAuthDataSourceImpl implements DatabaseAuthDataSource {
  final AppDatabase database;

  DatabaseAuthDataSourceImpl({AppDatabase? database})
    : database = database ?? DatabaseHelper.database;

  @override
  Future<void> createUser(UserModel user) async {
    try {
      await database.into(database.users).insert(
        UsersCompanion(
          id: Value(user.id),
          email: Value(user.email),
          name: Value(user.name),
          updatedAt: Value(user.updatedAt),
          createdAt: Value(user.createdAt),
        ),
      );
    } catch (e) {
      throw DatabaseQueryException(
        message: 'Failed to create user in database: $e',
      );
    }
  }

  @override
  Future<void> updateUser(UserModel user) async {
    try {
      await (database.update(database.users)
        ..where((tbl) => tbl.id.equals(user.id))
      ).write(
        UsersCompanion(
          email: Value(user.email),
          name: Value(user.name),
          updatedAt: Value(user.updatedAt),
        ),
      );
    } catch (e) {
      throw DatabaseQueryException(
        message: 'Failed to update user in database: $e',
      );
    }
  }

  @override
  Future<UserModel?> getUserById(String id) async {
    try {
      final user = await (database.select(database.users)
        ..where((tbl) => tbl.id.equals(id))
      ).getSingleOrNull();
      
      if (user == null) {
        return null;
      }
      
      return UserModel(
        id: user.id,
        email: user.email,
        name: user.name,
        updatedAt: user.updatedAt,
        createdAt: user.createdAt,
      );
    } catch (e) {
      throw DatabaseQueryException(
        message: 'Failed to get user from database: $e',
      );
    }
  }

  @override
  Future<void> deleteUserById(String id) async {
    try {
      await (database.delete(database.users)
        ..where((tbl) => tbl.id.equals(id))
      ).go();
    } catch (e) {
      throw DatabaseQueryException(
        message: 'Failed to delete user from database: $e',
      );
    }
  }

  @override
  void dispose() {}
}
