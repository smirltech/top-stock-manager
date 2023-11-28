import 'package:flutter/material.dart';
import 'package:top_stock_manager/system/widgets/permissions_views/permission_badge.dart';

import '../../../application/database/offline/app_database.dart';

class PermissionsView extends StatelessWidget {
  const PermissionsView({super.key, required this.permissions});

  final List<Permission> permissions;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: permissions
          .map((permission) => PermissionBadge(permission: permission))
          .toList(),
    );
  }
}
