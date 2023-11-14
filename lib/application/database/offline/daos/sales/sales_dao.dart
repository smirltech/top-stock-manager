import 'package:drift/drift.dart';

import '../../app_database.dart';
import '../../tables/sales.dart';

part 'sales_dao.g.dart';

@DriftAccessor(tables: [Sales])
class SalesDao extends DatabaseAccessor<AppDatabase> with _$SalesDaoMixin {
  final AppDatabase db;

  SalesDao(this.db) : super(db);
}
