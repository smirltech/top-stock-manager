import 'package:top_stock_manager/application/database/offline/app_database.dart';

class RolePermissionModel {
  final RoleHasPermission roleHasPermission;
  final Role role;
  final Permission permission;

  RolePermissionModel(
      {required this.roleHasPermission,
      required this.role,
      required this.permission});

  get id => roleHasPermission.id;

  get roleId => role.id;

  get roleName => role.name;

  get roleDescription => role.description;

  get permissionName => permission.name;

  get permissionDescription => permission.description;

  @override
  String toString() {
    return 'RolePermissionModel{roleHasPermission: $roleHasPermission, role: $role, permission: $permission, roleId: $roleId}';
  }
}
