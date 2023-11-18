import 'package:drift/drift.dart';
import 'package:top_stock_manager/application/database/offline/tables/products.dart';
import 'package:top_stock_manager/application/database/offline/tables/sales.dart';

class Outputs extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get productId => integer().references(Products, #id).nullable()();

  IntColumn get saleId => integer().references(Sales, #id).nullable()();

  RealColumn get quantity => real().nullable()();

  RealColumn get price => real().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().nullable().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().nullable().withDefault(currentDateAndTime)();
}
