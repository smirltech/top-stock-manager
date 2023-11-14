import 'package:drift/drift.dart';

import '../../app_database.dart';
import '../../tables/clients.dart';

part 'clients_dao.g.dart';

@DriftAccessor(tables: [Clients])
class ClientsDao extends DatabaseAccessor<AppDatabase> with _$ClientsDaoMixin {
  final AppDatabase db;

  ClientsDao(this.db) : super(db);
}
