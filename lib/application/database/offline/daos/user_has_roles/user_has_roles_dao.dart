import 'package:drift/drift.dart';

import '../../app_database.dart';
import '../../tables/user_has_roles.dart';

part 'user_has_roles_dao.g.dart';

@DriftAccessor(tables: [UserHasRoles])
class UserHasRolesDao extends DatabaseAccessor<AppDatabase>
    with _$UserHasRolesDaoMixin {
  final AppDatabase db;

  UserHasRolesDao(this.db) : super(db);

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
