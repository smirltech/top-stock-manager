import 'package:top_stock_manager/application/database/offline/app_database.dart';

class PurchaseModel {
  final Purchase purchase;
  final User? user;
  final Supplier? supplier;

  PurchaseModel({required this.purchase, this.user, this.supplier});

  get id => purchase.id;

  get date => purchase.date;

  get supplierId => purchase.supplierId;

  get description => purchase.description;
}
