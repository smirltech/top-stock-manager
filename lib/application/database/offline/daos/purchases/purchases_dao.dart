import 'package:drift/drift.dart';
import 'package:rxdart/rxdart.dart';
import 'package:top_stock_manager/application/database/offline/models/Input_product_model.dart';
import 'package:top_stock_manager/application/database/offline/tables/purchases.dart';

import '../../app_database.dart';
import '../../models/purchase_model.dart';

part 'purchases_dao.g.dart';

@DriftAccessor(tables: [Purchases])
class PurchasesDao extends DatabaseAccessor<AppDatabase>
    with _$PurchasesDaoMixin {
  final AppDatabase db;

  PurchasesDao(this.db) : super(db);

  Future<PurchaseModel> getPurchase(int id) async {
    final purch =
        await (select(purchases)..where((tbl) => tbl.id.equals(id))).join(
      [
        leftOuterJoin(
          db.suppliers,
          db.suppliers.id.equalsExp(purchases.supplierId),
        ),
      ],
    ).map(
      (row) {
        return PurchaseModel(
          purchase: row.readTable(purchases),
          supplier: row.readTableOrNull(db.suppliers),
        );
      },
    ).getSingle();

    purch.inputs = await db.inputsDao.getInputsWithProductByPurchase(purch.id);

    return purch;
  }

  Stream<List<PurchaseModel>> watchAllPurchases() {
    final purchs = select(purchases).join(
      [
        leftOuterJoin(
          db.suppliers,
          db.suppliers.id.equalsExp(purchases.supplierId),
        ),
      ],
    ).map(
      (row) {
        return PurchaseModel(
          purchase: row.readTable(purchases),
          supplier: row.readTableOrNull(db.suppliers),
        );
      },
    ).watch();

    final inps = db.inputsDao.watchAllInputProducts();

    return Rx.combineLatest2(purchs, inps,
        (List<PurchaseModel> p, List<InputProductModel> ins) {
      return p.map((purchase) {
        purchase.inputs =
            ins.where((element) => element.purchaseId == purchase.id).toList();
        return purchase;
      }).toList();
    });
  }

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
