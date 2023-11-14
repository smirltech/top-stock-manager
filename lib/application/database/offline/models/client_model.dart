import 'package:top_stock_manager/application/database/offline/app_database.dart';

class ClientModel {
  final Client client;

  ClientModel({required this.client});

  get id => client.id;

  get name => client.name;

  get sex => client.sex;

  get contact => client.contact;

  get description => client.description;

  @override
  String toString() {
    return "name: $name, sex: $sex, contact: $contact, description: $description";
  }
}
