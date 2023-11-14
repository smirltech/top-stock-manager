import 'package:drift/drift.dart';
import 'package:top_stock_manager/application/database/offline/tables/suppliers.dart';
import 'package:top_stock_manager/application/database/offline/tables/users.dart';

class Purchases extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get userId => integer().references(Users, #id).nullable()();

  IntColumn get supplierId => integer().references(Suppliers, #id).nullable()();

  DateTimeColumn get date => dateTime().nullable().withDefault(currentDate)();

  TextColumn get description => text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().nullable().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().nullable().withDefault(currentDateAndTime)();
}
