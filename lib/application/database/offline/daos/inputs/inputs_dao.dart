import 'package:drift/drift.dart';
import 'package:top_stock_manager/application/database/offline/tables/inputs.dart';

import '../../app_database.dart';

part 'inputs_dao.g.dart';

@DriftAccessor(tables: [Inputs])
class InputsDao extends DatabaseAccessor<AppDatabase> with _$InputsDaoMixin {
  final AppDatabase db;

  InputsDao(this.db) : super(db);

/*
  Stream<List<SaleModel>> watchAllSales() => select(sales)
      .join(
        [
          leftOuterJoin(
            db.clients,
            db.clients.id.equalsExp(sales.clientId),
          ),
        ],
      )
      .map(
        (row) => SaleModel(
          sale: row.readTable(sales),
          client: row.readTableOrNull(db.clients),
        ),
      )
      .watch();
*/

  Future<List<Input>> getInputsByPurchase(int id) =>
      (select(inputs)..where((t) => t.purchaseId.equals(id))).get();

  Future<int> insertInput(Map<String, dynamic> input) => into(inputs).insert(
        InputsCompanion(
          productId: Value(input['productId']),
          purchaseId: Value(input['purchaseId']),
          quantity: Value(input['quantity']),
          price: Value(input['price']),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future updateInput(InputsCompanion input) => update(inputs).replace(input);

  Future deleteInput(Input input) => delete(inputs).delete(input);
}
