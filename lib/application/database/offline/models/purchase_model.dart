import 'package:intl/intl.dart';
import 'package:top_stock_manager/application/database/offline/app_database.dart';
import 'package:top_stock_manager/system/configs/constants.dart';

class PurchaseModel {
  final Purchase purchase;
  final User? user;
  final Supplier? supplier;

  PurchaseModel({required this.purchase, this.user, this.supplier});

  get id => purchase.id;

  get date => purchase.date;

  get supplierId => purchase.supplierId;

  get price => RANDOM_DOUBLE * 10000;

  get priceStringed =>
      NumberFormat.currency(symbol: "Fc", locale: 'fr_CD', decimalDigits: 0)
          .format(price);

  get dateStringed => DateFormat('d-M-y').format(date);

  get description => purchase.description;
}