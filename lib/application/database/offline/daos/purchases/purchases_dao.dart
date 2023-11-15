import 'package:drift/drift.dart';
import 'package:top_stock_manager/application/database/offline/tables/purchases.dart';

import '../../app_database.dart';
import '../../models/purchase_model.dart';

part 'purchases_dao.g.dart';

@DriftAccessor(tables: [Purchases])
class PurchasesDao extends DatabaseAccessor<AppDatabase>
    with _$PurchasesDaoMixin {
  final AppDatabase db;

  PurchasesDao(this.db) : super(db);

  Stream<List<PurchaseModel>> watchAllPurchases() => select(purchases)
      .map((purchase) => PurchaseModel(purchase: purchase))
      .watch();

  Future<int> insertPurchase(Map<String, dynamic> purchase) =>
      into(purchases).insert(
        PurchasesCompanion(
          date: Value(purchase['date']),
          supplierId: Value(purchase['supplierId']),
          description: Value(purchase['description']),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future updatePurchase(PurchasesCompanion purchase) =>
      update(purchases).replace(purchase);

  Future deletePurchase(Purchase purchase) =>
      delete(purchases).delete(purchase);
}
