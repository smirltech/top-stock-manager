import 'package:drift/drift.dart';

import '../../app_database.dart';
import '../../tables/permissions.dart';

part 'permissions_dao.g.dart';

@DriftAccessor(tables: [Permissions])
class PermissionsDao extends DatabaseAccessor<AppDatabase>
    with _$PermissionsDaoMixin {
  final AppDatabase db;

  PermissionsDao(this.db) : super(db);
}
