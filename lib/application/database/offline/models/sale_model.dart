import 'package:intl/intl.dart';
import 'package:top_stock_manager/application/database/offline/app_database.dart';

import '../../../../system/configs/constants.dart';

class SaleModel {
  final Sale sale;
  final User? user;
  final Client? client;

  SaleModel({required this.sale, this.user, this.client});

  get id => sale.id;

  get date => sale.date;

  get description => sale.description;

  get clientId => sale.clientId;

  get clientName => client?.name ?? '';

  get price => RANDOM_DOUBLE * 10000;

  get priceStringed =>
      NumberFormat.currency(symbol: "Fc", locale: 'fr_CD', decimalDigits: 0)
          .format(price);

  get dateStringed => DateFormat('d-M-y').format(date);
}
