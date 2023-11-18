import 'package:drift/drift.dart';

import '../../app_database.dart';
import '../../models/sale_model.dart';
import '../../tables/sales.dart';

part 'sales_dao.g.dart';

@DriftAccessor(tables: [Sales])
class SalesDao extends DatabaseAccessor<AppDatabase> with _$SalesDaoMixin {
  final AppDatabase db;

  SalesDao(this.db) : super(db);

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

  Future<int> insertSale(Map<String, dynamic> sale) => into(sales).insert(
        SalesCompanion(
          date: Value(sale['date']),
          clientId: Value(sale['clientId']),
          description: Value(sale['description']),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future updateSale(SalesCompanion sale) => update(sales).replace(sale);

  Future deleteSale(Sale sale) => delete(sales).delete(sale);
}
