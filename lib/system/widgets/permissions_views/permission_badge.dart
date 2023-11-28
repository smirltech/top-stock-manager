import 'package:flutter/material.dart';
import 'package:top_stock_manager/application/database/offline/app_database.dart';
import 'package:top_stock_manager/system/configs/theming.dart';

class PermissionBadge extends StatelessWidget {
  const PermissionBadge({super.key, required this.permission});

  final Permission permission;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: const BoxDecoration(
        color: kSuccess,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Text("${permission.description}"),
    );
  }
}
