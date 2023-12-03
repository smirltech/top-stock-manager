import 'package:top_stock_manager/application/database/offline/app_database.dart';

class UserRoleModel {
  final UserHasRole userHasRole;
  late User? user;
  late Role? role;

  UserRoleModel({
    required this.userHasRole,
    this.user,
    this.role,
  });

  get id => userHasRole.id;

  get roleId => role?.id;

  get roleName => role?.name;

  get roleDescription => role?.description;

  get userId => user?.id;

  get userName => user?.name;

  @override
  String toString() {
    return 'UserRoleModel{userHasRole: $userHasRole, user: $user, role: $role}';
  }
}
