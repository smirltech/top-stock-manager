import 'package:drift/drift.dart';

import '../../app_database.dart';
import '../../tables/user_has_permissions.dart';

part 'user_has_permissions_dao.g.dart';

@DriftAccessor(tables: [UserHasPermissions])
class UserHasPermissionsDao extends DatabaseAccessor<AppDatabase>
    with _$UserHasPermissionsDaoMixin {
  final AppDatabase db;

  UserHasPermissionsDao(this.db) : super(db);

  Future<int> insertData(Map<String, dynamic> data) =>
      into(userHasPermissions).insert(
        UserHasPermissionsCompanion(
          userId: Value(data['userId']),
          permissionId: Value(data['permissionId']),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future updateData(UserHasPermissionsCompanion data) =>
      update(userHasPermissions).replace(data);

  Future deleteData(UserHasPermission data) =>
      delete(userHasPermissions).delete(data);
}
