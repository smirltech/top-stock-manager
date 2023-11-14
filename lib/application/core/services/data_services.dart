import 'package:drift/drift.dart' as d;
import 'package:get/get.dart';
import 'package:top_stock_manager/application/database/offline/app_database.dart';
import 'package:top_stock_manager/application/database/offline/models/product_model.dart';
import 'package:top_stock_manager/main.dart';

import '../../../system/configs/theming.dart';

class DataServices extends GetxService {
  // ------- static methods ------- //
  static DataServices get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<DataServices>(() async => DataServices());
  }

// ------- ./static methods ------- //
  int user_id = 1;
  var product = Rxn<Product>();
  var products = <ProductModel>[].obs;

  saveProduct(Map<String, dynamic> data) async {
    if (product.value == null) {
      await DB.productsDao.insertProduct(data);
      Get.back();
      Get.snackbar('Product'.tr, 'Product added successfully'.tr);
    } else {
      ProductsCompanion c = product.value!
          .copyWith(
            name: data['name'],
            description: d.Value(data['description']),
            min: d.Value(data['min']),
            max: d.Value(data['max']),
            unit: d.Value(data['unit']),
            updatedAt: d.Value(DateTime.now()),
          )
          .toCompanion(true);

      await DB.productsDao.updateProduct(c);
      Get.back();
      Get.snackbar('Product'.tr, 'Product updated successfully'.tr);
    }
    product.value = null;
  }

  deleteProduct(Product prodct) {
    Get.defaultDialog(
      title: "Delete Product".tr,
      middleText:
          "${"Are you sure you want to delete product".tr} : \"${prodct.name}\"",
      textConfirm: "Delete".tr,
      buttonColor: kDanger,
      onConfirm: () {
        DB.productsDao.deleteProduct(prodct);
        product.value = null;
        Get.back();
        Get.snackbar('Product'.tr, 'Product deleted successfully'.tr);
      },
    );
  }

  @override
  void onReady() {
    DB.productsDao.watchAllProducts().listen((event) {
      products.value = event;
      // log(event.toString());
    });

    super.onReady();
  }
}
