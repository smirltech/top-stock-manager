import 'package:drift/drift.dart';
import 'package:top_stock_manager/application/database/offline/models/role_model.dart';

import '../../app_database.dart';
import '../../tables/roles.dart';

part 'roles_dao.g.dart';

@DriftAccessor(tables: [Roles])
class RolesDao extends DatabaseAccessor<AppDatabase> with _$RolesDaoMixin {
  final AppDatabase db;

  RolesDao(this.db) : super(db);

  Stream<List<RoleModel>> watchAllRoles() =>
      select(roles).map((role) => RoleModel(role: role)).watch();

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
}