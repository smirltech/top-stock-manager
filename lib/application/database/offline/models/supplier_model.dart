import 'package:top_stock_manager/application/database/offline/app_database.dart';

class SupplierModel {
  final Supplier supplier;

  SupplierModel({required this.supplier});

  get id => supplier.id;

  get name => supplier.name;

  get sex => supplier.sex;

  get contact => supplier.contact;

  get description => supplier.description;

  @override
  String toString() {
    return "name: $name, sex: $sex, contact: $contact, description: $description";
  }
}
