import 'package:drift/drift.dart';

class Roles extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().unique()();

  TextColumn get description => text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().nullable().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().nullable().withDefault(currentDateAndTime)();
}
