import 'package:drift/drift.dart';

class ExerciseMuscle extends Table {
  TextColumn get id => text()();
  TextColumn get muscleId => text()();
  TextColumn get exerciseId => text()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
