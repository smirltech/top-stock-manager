import 'package:drift/drift.dart';

import '../../app_database.dart';
import '../../tables/roles.dart';

part 'roles_dao.g.dart';

@DriftAccessor(tables: [Roles])
class RolesDao extends DatabaseAccessor<AppDatabase> with _$RolesDaoMixin {
  final AppDatabase db;

  RolesDao(this.db) : super(db);
}
