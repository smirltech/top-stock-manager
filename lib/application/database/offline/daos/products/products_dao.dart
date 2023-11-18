import 'package:drift/drift.dart';
import 'package:top_stock_manager/application/database/offline/models/product_model.dart';
import 'package:top_stock_manager/application/database/offline/tables/products.dart';

import '../../app_database.dart';

part 'products_dao.g.dart';

@DriftAccessor(tables: [Products])
class ProductsDao extends DatabaseAccessor<AppDatabase>
    with _$ProductsDaoMixin {
  final AppDatabase db;

  ProductsDao(this.db) : super(db);

  // stream all users
  Stream<List<ProductModel>> watchAllProducts() =>
      select(products).map((product) => ProductModel(product: product)).watch();

  Future<int> insertProduct(Map<String, dynamic> product) =>
      into(products).insert(
        ProductsCompanion(
          name: Value(product['name']),
          description: Value(product['description']),
          minimum: Value(product['minimum']),
          maximum: Value(product['maximum']),
          unit: Value(product['unit']),
          productId: Value(product['product_id']),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future updateProduct(ProductsCompanion product) =>
      update(products).replace(product);

  Future deleteProduct(Product product) => delete(products).delete(product);
}
