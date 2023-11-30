import 'package:top_stock_manager/application/database/offline/app_database.dart';
import 'package:top_stock_manager/application/database/offline/models/role_permission_model.dart';

class RoleModel {
  final Role role;
  late List<RolePermissionModel>? rolePermissions = [];

  RoleModel({required this.role, this.rolePermissions});

  get id => role.id;

  get name => role.name;

  get description => role.description;

  List<Permission> get permissions =>
      rolePermissions?.map((e) => e.permission).toList() ?? [];

  //  rolePermissions?.forEach((rolePermission) => rolePermission.permission);

  @override
  String toString() {
    return 'RoleModel{role: $role, permissions: $permissions}';
  }
}
