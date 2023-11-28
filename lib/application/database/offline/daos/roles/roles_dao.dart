import 'package:drift/drift.dart';
import 'package:rxdart/rxdart.dart';
import 'package:top_stock_manager/application/database/offline/models/role_model.dart';
import 'package:top_stock_manager/application/database/offline/models/role_permission_model.dart';

import '../../app_database.dart';
import '../../tables/roles.dart';

part 'roles_dao.g.dart';

@DriftAccessor(tables: [Roles])
class RolesDao extends DatabaseAccessor<AppDatabase> with _$RolesDaoMixin {
  final AppDatabase db;

  RolesDao(this.db) : super(db);

  Stream<List<RoleModel>> watchAllRoles() =>
      select(roles).map((role) => RoleModel(role: role)).watch();

  Stream<List<RoleModel>> watchAllRolesWithPermissions() {
    final rolies = watchAllRoles();

    final rp = db.roleHasPermissionsDao.watchAllRolePermissions();

    return Rx.combineLatest2(rolies, rp,
        (List<RoleModel> p, List<RolePermissionModel> ins) {
      return p.map((role) {
        role.rolePermissions =
            ins.where((rper) => rper.roleId == role.id).toList();
        return role;
      }).toList();
    });
  }

  Future<Role> getRole(int id) =>
      (select(roles)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<int> insertRole(Map<String, dynamic> role) => into(roles).insert(
        RolesCompanion(
          name: Value(role['name']),
          description: Value(role['description']),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future updateRole(RolesCompanion role) => update(roles).replace(role);

  Future deleteRole(Role role) => delete(roles).delete(role);

  Future<int> insertOrAbortRole(Map<String, dynamic> role) =>
      into(roles).insert(
        RolesCompanion(
          name: Value(role['name']),
          description: Value(role['description']),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
        onConflict: DoNothing(
          target: <Column>[roles.name],
        ),
        mode: InsertMode.insertOrAbort,
      );
}
