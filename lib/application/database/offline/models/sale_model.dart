import 'package:top_stock_manager/application/database/offline/app_database.dart';

class SaleModel {
  final Sale sale;
  final User? user;
  final Client? client;

  SaleModel({required this.sale, this.user, this.client});

  get id => sale.id;

  get date => sale.date;

  get description => sale.description;
}
