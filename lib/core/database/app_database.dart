import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../shared/app_config.dart';
import 'tables/exercise.dart';
import 'tables/exercise_muscle.dart';
import 'tables/users.dart';
import 'tables/muscle.dart';
import 'tables/workout.dart';
import 'tables/workout_exercise.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Users, Exercise, ExerciseMuscle, Muscle, Workout, WorkoutExercise],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      await _runMigrations(m, from, to);
    },
  );

  Future<void> _runMigrations(Migrator m, int from, int to) async {
    if (from <= 1 && to >= 2) {
      // Migrations for V2
    }
  }
}

// LazyDatabase _openConnection() {
//   return LazyDatabase(() async {
//     final dbFolder = await getApplicationDocumentsDirectory();
//     final file = File(join(dbFolder.path, AppConfig.dbName));
//     return NativeDatabase(file);
//   });
// }

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, AppConfig.dbName));
    if (await file.exists()) {
      await file.delete();
    }
    return NativeDatabase(file);
  });
}
