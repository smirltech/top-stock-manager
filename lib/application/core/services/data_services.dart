import 'dart:developer';

import 'package:get/get.dart';
import 'package:top_stock_manager/application/database/offline/app_database.dart';
import 'package:top_stock_manager/application/ui/products/products_screen.dart';
import 'package:top_stock_manager/main.dart';

class DataServices extends GetxService {
  // ------- static methods ------- //
  static DataServices get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<DataServices>(() async => DataServices());
  }

// ------- ./static methods ------- //
  var product = Rxn<Product>();
  var products = <Product>[].obs;

  saveProduct(Map<String, dynamic> data) async {
    if (product.value == null) {
      await DB.productsDao.insertProduct(data);
      Get.snackbar('Product', 'Product added successfully');
    } else {
      ProductsCompanion c = product.value!
          .copyWith(
            description: data['description'],
          )
          .toCompanion(true);

      await DB.productsDao.updateProduct(c);
      Get.snackbar('Product', 'Product updated successfully');
    }
    product.value = null;
    Get.toNamed(ProductsScreen.route);
  }

  @override
  void onReady() {
    DB.productsDao.watchAllProducts().listen((event) {
      products.value = event;
      log(event.toString());
    });

    super.onReady();
  }
}
