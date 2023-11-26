import 'dart:developer';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:top_stock_manager/application/database/offline/daos/clients/clients_dao.dart';
import 'package:top_stock_manager/application/database/offline/daos/inputs/inputs_dao.dart';
import 'package:top_stock_manager/application/database/offline/daos/outputs/outputs_dao.dart';
import 'package:top_stock_manager/application/database/offline/daos/permissions/permissions_dao.dart';
import 'package:top_stock_manager/application/database/offline/daos/products/products_dao.dart';
import 'package:top_stock_manager/application/database/offline/daos/purchases/purchases_dao.dart';
import 'package:top_stock_manager/application/database/offline/daos/roles/roles_dao.dart';
import 'package:top_stock_manager/application/database/offline/daos/sales/sales_dao.dart';
import 'package:top_stock_manager/application/database/offline/daos/suppliers/suppliers_dao.dart';
import 'package:top_stock_manager/application/database/offline/daos/users/users_dao.dart';
import 'package:top_stock_manager/application/database/offline/tables/clients.dart';
import 'package:top_stock_manager/application/database/offline/tables/inputs.dart';
import 'package:top_stock_manager/application/database/offline/tables/outputs.dart';
import 'package:top_stock_manager/application/database/offline/tables/permissions.dart';
import 'package:top_stock_manager/application/database/offline/tables/products.dart';
import 'package:top_stock_manager/application/database/offline/tables/purchases.dart';
import 'package:top_stock_manager/application/database/offline/tables/role_has_permissions.dart';
import 'package:top_stock_manager/application/database/offline/tables/roles.dart';
import 'package:top_stock_manager/application/database/offline/tables/sales.dart';
import 'package:top_stock_manager/application/database/offline/tables/suppliers.dart';
import 'package:top_stock_manager/application/database/offline/tables/user_has_permissions.dart';
import 'package:top_stock_manager/application/database/offline/tables/user_has_roles.dart';
import 'package:top_stock_manager/application/database/offline/tables/users.dart';
import 'package:top_stock_manager/main.dart';
import 'package:top_stock_manager/system/enums/permissions.dart'
    as PermissionsEnum;

import '../../../system/configs/constants.dart';
import 'daos/role_has_permissions/role_has_permissions_dao.dart';
import 'daos/user_has_permissions/user_has_permissions_dao.dart';
import 'daos/user_has_roles/user_has_roles_dao.dart';

part 'app_database.g.dart';

LazyDatabase _lazyDatabase() {
  return LazyDatabase(() async {
    final dbFolder = kProductionMode
        ? await getApplicationSupportDirectory()
        : await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, '.tsmanager.db'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(
  tables: [
    Users,
    Roles,
    Permissions,
    RoleHasPermissions,
    UserHasPermissions,
    UserHasRoles,
    Products,
    Suppliers,
    Clients,
    Purchases,
    Sales,
    Inputs,
    Outputs,
  ],
  daos: [
    UsersDao,
    RolesDao,
    PermissionsDao,
    RoleHasPermissionsDao,
    UserHasPermissionsDao,
    UserHasRolesDao,
    ProductsDao,
    SuppliersDao,
    ClientsDao,
    PurchasesDao,
    SalesDao,
    InputsDao,
    OutputsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_lazyDatabase());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {},
        beforeOpen: (OpeningDetails details) async {
          _seedPermissions();
          _seedRoles();
          _seedUsers();
          return Future.value();
        });
  }
}

_seedUsers() {
  DB.usersDao.insertOrAbortUser(
    {'name': "Francis", 'username': "fnn", 'password': '1234'},
  ).catchError((onError) async {
    return Future.value(1);
  });

  DB.usersDao.insertOrAbortUser(
    {'name': "Numbi", 'username': "numbi", 'password': '1234'},
  ).catchError((onError) async {
    return Future.value(1);
  });
}

_seedRoles() {
  DB.rolesDao.insertOrAbortRole(
    {'name': "Admin", 'description': "for administrators"},
  ).catchError((onError) async {
    return Future.value(1);
  });
}

_seedPermissions() {
  log("seed permissions");
  PermissionsEnum.permissions.forEach((key, value) async {
    // log(value.label);
    await DB.permissionsDao.insertOrAbortPermission(
      {'name': value.value, 'description': value.label},
    ).catchError((onError) async {
      return Future.value(0);
    });
  });
}
