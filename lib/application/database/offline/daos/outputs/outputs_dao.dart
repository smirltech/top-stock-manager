import 'package:drift/drift.dart';

import '../../app_database.dart';
import '../../tables/outputs.dart';

part 'outputs_dao.g.dart';

@DriftAccessor(tables: [Outputs])
class OutputsDao extends DatabaseAccessor<AppDatabase> with _$OutputsDaoMixin {
  final AppDatabase db;

  OutputsDao(this.db) : super(db);

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

  Future<int> insertOutput(Map<String, dynamic> output) => into(outputs).insert(
        OutputsCompanion(
          productId: Value(output['productId']),
          saleId: Value(output['saleId']),
          quantity: Value(output['quantity']),
          price: Value(output['price']),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future updateOutput(OutputsCompanion output) =>
      update(outputs).replace(output);

  Future deleteOutput(Output output) => delete(outputs).delete(output);
}
