import 'package:drift/drift.dart';

class Suppliers extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().unique()();

  TextColumn get sex => text().nullable()();

  TextColumn get contact => text().nullable()();

  TextColumn get description => text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().nullable().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().nullable().withDefault(currentDateAndTime)();
}
