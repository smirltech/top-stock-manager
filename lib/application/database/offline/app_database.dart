import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:top_stock_manager/application/database/offline/daos/products/products_dao.dart';
import 'package:top_stock_manager/application/database/offline/daos/users/users_dao.dart';
import 'package:top_stock_manager/application/database/offline/tables/products.dart';
import 'package:top_stock_manager/application/database/offline/tables/users.dart';

import '../../../system/configs/constants.dart';

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
    Products,
  ],
  daos: [
    UsersDao,
    ProductsDao,
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
        onUpgrade: (Migrator m, int from, int to) async {});
  }
}
