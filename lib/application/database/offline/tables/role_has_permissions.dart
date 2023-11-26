import 'package:drift/drift.dart';
import 'package:top_stock_manager/application/database/offline/tables/roles.dart';
import 'package:top_stock_manager/application/database/offline/tables/permissions.dart';

class RoleHasPermissions extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get roleId => integer().references(Roles, #id).nullable()();

  IntColumn get permissionId =>
      integer().references(Permissions, #id).nullable()();

  DateTimeColumn get createdAt =>
      dateTime().nullable().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().nullable().withDefault(currentDateAndTime)();
}
