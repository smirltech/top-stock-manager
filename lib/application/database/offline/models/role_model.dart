import 'package:top_stock_manager/application/database/offline/app_database.dart';

class RoleModel {
  final Role role;

  RoleModel({required this.role});

  get id => role.id;

  get name => role.name;

  get description => role.description;

  get permissions => "no permission yet";

  @override
  String toString() {
    return "name: $name, description: $description, permissions: $permissions";
  }
}
