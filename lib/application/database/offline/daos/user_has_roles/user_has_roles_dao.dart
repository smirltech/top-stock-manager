import 'package:drift/drift.dart';

import '../../app_database.dart';
import '../../tables/user_has_roles.dart';

part 'user_has_roles_dao.g.dart';

@DriftAccessor(tables: [UserHasRoles])
class UserHasRolesDao extends DatabaseAccessor<AppDatabase>
    with _$UserHasRolesDaoMixin {
  final AppDatabase db;

  UserHasRolesDao(this.db) : super(db);

/*  Stream<List<RoleModel>> watchAllRoles() =>
      select(roles).map((role) => RoleModel(role: role)).watch();*/

/*  Future<int> insertRole(Map<String, dynamic> role) =>
      into(roles).insert(
        RolesCompanion(
          name: Value(role['name']),
          description: Value(role['description']),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );*/

/*  Future updateRole(RolesCompanion role) => update(roles).replace(role);*/

/* Future deleteRole(Role role) => delete(roles).delete(role);*/

/*  Future<int> insertOrAbortRole(Map<String, dynamic> role) =>
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
      );*/
}
