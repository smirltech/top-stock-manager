import 'package:drift/drift.dart';

import '../../app_database.dart';
import '../../tables/permissions.dart';

part 'permissions_dao.g.dart';

@DriftAccessor(tables: [Permissions])
class PermissionsDao extends DatabaseAccessor<AppDatabase>
    with _$PermissionsDaoMixin {
  final AppDatabase db;

  PermissionsDao(this.db) : super(db);

  Stream<List<Permission>> watchAllPermissions() => select(permissions).watch();

  Future<int> insertPermission(Map<String, dynamic> permission) =>
      into(permissions).insert(
        PermissionsCompanion(
          name: Value(permission['name']),
          description: Value(permission['description']),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future<int> insertOrUpdatePermission(Map<String, dynamic> permission) =>
      into(permissions).insert(
        PermissionsCompanion(
          name: Value(permission['name']),
          description: Value(permission['description']),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
        mode: InsertMode.insertOrReplace,
        onConflict: DoUpdate(
          (old) => PermissionsCompanion.custom(
            description: Constant(permission['description']),
            createdAt: Constant(DateTime.now()),
            updatedAt: Constant(DateTime.now()),
          ),
          target: <Column>[permissions.name],
        ),
      );

  Future<int> insertOrAbortPermission(Map<String, dynamic> permission) =>
      into(permissions).insert(
        PermissionsCompanion(
          name: Value(permission['name']),
          description: Value(permission['description']),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
        onConflict: DoNothing(
          target: <Column>[permissions.name],
        ),
        mode: InsertMode.insertOrAbort,
      );
}
