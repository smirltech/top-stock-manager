import 'package:top_stock_manager/application/database/offline/app_database.dart';

class UserModel {
  final User user;

  UserModel({required this.user});

  get id => user.id;

  get name => user.name;

  get username => user.username;

  get password => user.password;

  get role => "Any Role";

  @override
  String toString() {
    return "name: $name, username: $username, password: $password, role: $role";
  }
}
