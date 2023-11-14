import 'package:drift/drift.dart';

import '../../app_database.dart';
import '../../tables/suppliers.dart';

part 'suppliers_dao.g.dart';

@DriftAccessor(tables: [Suppliers])
class SuppliersDao extends DatabaseAccessor<AppDatabase>
    with _$SuppliersDaoMixin {
  final AppDatabase db;

  SuppliersDao(this.db) : super(db);
}
