import 'package:top_stock_manager/application/database/offline/app_database.dart';
import 'package:top_stock_manager/application/database/offline/models/role_model.dart';
import 'package:top_stock_manager/application/database/offline/models/user_role_model.dart';
import 'package:top_stock_manager/main.dart';

class UserModel {
  final User user;
  late List<UserRoleModel>? userRoleModels = <UserRoleModel>[];

  UserModel({
    required this.user,
    this.userRoleModels,
  });

  get id => user.id;

  get name => user.name;

  get username => user.username;

  get password => user.password;

  Role? get role => userRoleModels!.isEmpty ? null : userRoleModels!.first.role;

  Future<RoleModel?> get roleModel async =>
      role == null ? null : await DB.rolesDao.getRoleModel(roleId);

  get roleId => role!.id;

  @override
  String toString() {
    return "name: $name, username: $username, password: $password, role: $role";
  }
}
