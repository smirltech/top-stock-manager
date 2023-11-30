import 'package:drift/drift.dart';

import '../../app_database.dart';
import '../../models/user_role_model.dart';
import '../../tables/user_has_roles.dart';

part 'user_has_roles_dao.g.dart';

@DriftAccessor(tables: [UserHasRoles])
class UserHasRolesDao extends DatabaseAccessor<AppDatabase>
    with _$UserHasRolesDaoMixin {
  final AppDatabase db;

  UserHasRolesDao(this.db) : super(db);

//

  Stream<List<UserRoleModel>> watchAllUserRoles() => select(userHasRoles)
      .join(
        [
          leftOuterJoin(
            db.users,
            db.users.id.equalsExp(userHasRoles.userId),
          ),
          leftOuterJoin(
            db.roles,
            db.roles.id.equalsExp(userHasRoles.roleId),
          ),
        ],
      )
      .map(
        (row) => UserRoleModel(
          userHasRole: row.readTable(userHasRoles),
          user: row.readTable(db.users),
          role: row.readTable(db.roles),
        ),
      )
      .watch();

  Future<List<UserHasRole>> rolesOfUser(int userId) {
    return (select(userHasRoles)..where((tbl) => tbl.userId.equals(userId)))
        .get();
  }

  Future<List<UserRoleModel>> userRolesOfUser(int userId) =>
      (select(userHasRoles)..where((tbl) => tbl.userId.equals(userId)))
          .join(
            [
              leftOuterJoin(
                db.permissions,
                db.users.id.equalsExp(userHasRoles.userId),
              ),
              leftOuterJoin(
                db.roles,
                db.roles.id.equalsExp(userHasRoles.roleId),
              ),
            ],
          )
          .map(
            (row) => UserRoleModel(
              userHasRole: row.readTable(userHasRoles),
              user: row.readTable(db.users),
              role: row.readTable(db.roles),
            ),
          )
          .get();

  //
  Future<int> insertData(Map<String, dynamic> data) =>
      into(userHasRoles).insert(
        UserHasRolesCompanion(
          userId: Value(data['userId']),
          roleId: Value(data['roleId']),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future updateData(UserHasRolesCompanion data) =>
      update(userHasRoles).replace(data);

  Future deleteData(UserHasRole data) => delete(userHasRoles).delete(data);
}
