import 'package:drift/drift.dart';

import '../../app_database.dart';
import '../../models/supplier_model.dart';
import '../../tables/suppliers.dart';

part 'suppliers_dao.g.dart';

@DriftAccessor(tables: [Suppliers])
class SuppliersDao extends DatabaseAccessor<AppDatabase>
    with _$SuppliersDaoMixin {
  final AppDatabase db;

  SuppliersDao(this.db) : super(db);

  Stream<List<SupplierModel>> watchAllSuppliers() => select(suppliers)
      .map((supplier) => SupplierModel(supplier: supplier))
      .watch();

  Future<int> insertSupplier(Map<String, dynamic> supplier) =>
      into(suppliers).insert(
        SuppliersCompanion(
          name: Value(supplier['name']),
          sex: Value(supplier['sex']),
          contact: Value(supplier['contact']),
          description: Value(supplier['description']),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future updateSupplier(SuppliersCompanion supplier) =>
      update(suppliers).replace(supplier);

  Future deleteSupplier(Supplier supplier) =>
      delete(suppliers).delete(supplier);
}
