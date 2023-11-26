import 'package:drift/drift.dart';

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
