import 'package:drift/drift.dart';
import 'package:top_stock_manager/application/database/offline/tables/purchases.dart';

import '../../app_database.dart';
import '../../models/client_model.dart';
import '../../tables/clients.dart';

part 'purchases_dao.g.dart';

@DriftAccessor(tables: [Purchases])
class PurchasesDao extends DatabaseAccessor<AppDatabase> with _$PurchasesDaoMixin {
  final AppDatabase db;

  PurchasesDao(this.db) : super(db);

}
