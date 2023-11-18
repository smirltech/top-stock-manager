import 'package:drift/drift.dart';
import 'package:top_stock_manager/application/database/offline/tables/products.dart';
import 'package:top_stock_manager/application/database/offline/tables/purchases.dart';

class Inputs extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get productId => integer().references(Products, #id).nullable()();

  IntColumn get purchaseId => integer().references(Purchases, #id).nullable()();

  RealColumn get quantity => real().nullable()();

  RealColumn get price => real().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().nullable().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt =>
      dateTime().nullable().withDefault(currentDateAndTime)();
}
