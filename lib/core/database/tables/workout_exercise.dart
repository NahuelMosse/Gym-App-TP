import 'package:drift/drift.dart';

class WorkoutExercise extends Table {
  TextColumn get id => text()();
  TextColumn get method => text()();
  IntColumn get order => integer()();
  TextColumn get exerciseId => text()();
  TextColumn get workoutId => text()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
