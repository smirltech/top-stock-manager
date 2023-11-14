import 'package:drift/drift.dart';

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().unique()();

  TextColumn get description => text().nullable()();

  IntColumn get min => integer().nullable().withDefault(const Constant(0))();

  IntColumn get max => integer().nullable().withDefault(const Constant(0))();

  TextColumn get unit => text().nullable()();

  IntColumn get productId => integer().references(Products, #id).nullable()();

  DateTimeColumn get createdAt =>
      dateTime().nullable().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().nullable().withDefault(currentDateAndTime)();
}
