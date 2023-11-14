import 'package:drift/drift.dart';

import '../../app_database.dart';
import '../../models/client_model.dart';
import '../../tables/clients.dart';

part 'clients_dao.g.dart';

@DriftAccessor(tables: [Clients])
class ClientsDao extends DatabaseAccessor<AppDatabase> with _$ClientsDaoMixin {
  final AppDatabase db;

  ClientsDao(this.db) : super(db);

  Stream<List<ClientModel>> watchAllClients() =>
      select(clients).map((client) => ClientModel(client: client)).watch();

  Future<int> insertClient(Map<String, dynamic> client) => into(clients).insert(
        ClientsCompanion(
          name: Value(client['name']),
          sex: Value(client['sex']),
          contact: Value(client['contact']),
          description: Value(client['description']),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future updateClient(ClientsCompanion client) =>
      update(clients).replace(client);

  Future deleteClient(Client client) => delete(clients).delete(client);
}
