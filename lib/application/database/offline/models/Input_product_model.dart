import 'package:intl/intl.dart';
import 'package:top_stock_manager/application/database/offline/app_database.dart';

class InputProductModel {
  final Input input;
  final Product? product;

  InputProductModel({required this.input, this.product});

  get id => input.id;

  get productName => product?.name ?? '';

  get price => input.price;

  get quantity => input.quantity;

  get total => input.price! * input.quantity!;

  get priceStringed =>
      NumberFormat.currency(symbol: "Fc", locale: 'fr_CD', decimalDigits: 0)
          .format(price);

  get totalStringed =>
      NumberFormat.currency(symbol: "Fc", locale: 'fr_CD', decimalDigits: 0)
          .format(total);

  get quantityStringed => "$quantity ${product?.unit}";
}
