import 'package:intl/intl.dart';
import 'package:top_stock_manager/application/database/offline/app_database.dart';
import 'package:top_stock_manager/application/database/offline/models/Input_product_model.dart';

class PurchaseModel {
  final Purchase purchase;
  final User? user;
  final Supplier? supplier;
  late List<InputProductModel>? inputs = <InputProductModel>[];

  PurchaseModel(
      {required this.purchase, this.user, this.supplier, this.inputs});

  get id => purchase.id;

  get date => purchase.date;

  get supplierId => purchase.supplierId;

  get supplierName => supplier?.name ?? '';

  get inputsCount => inputs!.length.toString();

  get price {
    double amount = 0;
    for (var element in inputs!) {
      amount += element.total;
    }
    return amount;
  }

  get priceStringed =>
      NumberFormat.currency(symbol: "Fc", locale: 'fr_CD', decimalDigits: 0)
          .format(price);

  get dateStringed => DateFormat('d-M-y').format(date);

  get description => purchase.description;
}
