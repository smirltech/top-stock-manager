import 'package:drift/drift.dart';
import 'package:top_stock_manager/application/database/offline/models/role_permission_model.dart';

import '../../app_database.dart';
import '../../tables/role_has_permissions.dart';

part 'role_has_permissions_dao.g.dart';

@DriftAccessor(tables: [RoleHasPermissions])
class RoleHasPermissionsDao extends DatabaseAccessor<AppDatabase>
    with _$RoleHasPermissionsDaoMixin {
  final AppDatabase db;

  RoleHasPermissionsDao(this.db) : super(db);

/*  Stream<List<RoleModel>> watchAllRoles() =>
      select(roles).map((role) => RoleModel(role: role)).watch();*/

  Stream<List<RolePermissionModel>> watchAllRolePermissions() =>
      select(roleHasPermissions)
          .join(
            [
              leftOuterJoin(
                db.roles,
                db.roles.id.equalsExp(roleHasPermissions.roleId),
              ),
              leftOuterJoin(
                db.permissions,
                db.permissions.id.equalsExp(roleHasPermissions.permissionId),
              ),
            ],
          )
          .map(
            (row) => RolePermissionModel(
              roleHasPermission: row.readTable(roleHasPermissions),
              role: row.readTable(db.roles),
              permission: row.readTable(db.permissions),
            ),
          )
          .watch();

  Future<List<RoleHasPermission>> permissionsOfRole(int roleId) {
    return (select(roleHasPermissions)
          ..where((tbl) => tbl.roleId.equals(roleId)))
        .get();
  }

  Future<List<RolePermissionModel>> rolePermissionsOfRole(int roleId) =>
      (select(roleHasPermissions)..where((tbl) => tbl.roleId.equals(roleId)))
          .join(
            [
              leftOuterJoin(
                db.roles,
                db.roles.id.equalsExp(roleHasPermissions.roleId),
              ),
              leftOuterJoin(
                db.permissions,
                db.permissions.id.equalsExp(roleHasPermissions.permissionId),
              ),
            ],
          )
          .map(
            (row) => RolePermissionModel(
              roleHasPermission: row.readTable(roleHasPermissions),
              role: row.readTable(db.roles),
              permission: row.readTable(db.permissions),
            ),
          )
          .get();

  Future<int> insertData(Map<String, dynamic> data) =>
      into(roleHasPermissions).insert(
        RoleHasPermissionsCompanion(
          roleId: Value(data['roleId']),
          permissionId: Value(data['permissionId']),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future updateData(RoleHasPermissionsCompanion data) =>
      update(roleHasPermissions).replace(data);

  Future deleteData(RoleHasPermission data) =>
      delete(roleHasPermissions).delete(data);
}
