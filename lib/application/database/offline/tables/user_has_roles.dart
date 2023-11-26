import 'package:drift/drift.dart';
import 'package:top_stock_manager/application/database/offline/tables/roles.dart';
import 'package:top_stock_manager/application/database/offline/tables/users.dart';

class UserHasRoles extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get userId => integer().references(Users, #id).nullable()();

  IntColumn get roleId => integer().references(Roles, #id).nullable()();

  DateTimeColumn get createdAt =>
      dateTime().nullable().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().nullable().withDefault(currentDateAndTime)();
}
