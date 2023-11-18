import 'package:top_stock_manager/application/database/offline/app_database.dart';

class ProductModel {
  final Product product;

  ProductModel({required this.product});

  get id => product.id;

  get name => product.name;

  get description => product.description;

  get min => product.minimum;

  get max => product.maximum;

  get unit => product.unit;

  get minStringed => '$min $unit';

  get maxStringed => '$max $unit';

  get quantity => 0;

  get quantityStringed => '$quantity $unit';

  get price => 0;

  get priceStringed => '$price Fc';
}
