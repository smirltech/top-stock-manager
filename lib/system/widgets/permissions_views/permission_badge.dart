import 'package:flutter/material.dart';
import 'package:top_stock_manager/application/database/offline/app_database.dart';

class PermissionBadge extends StatelessWidget {
  const PermissionBadge({super.key, required this.permission});

  final Permission permission;

  @override
  Widget build(BuildContext context) {
    return Badge(
      child: Text("${permission.description}"),
    );
  }
}
