import 'package:drift/drift.dart' as d;
import 'package:get/get.dart';
import 'package:top_stock_manager/application/database/offline/app_database.dart';
import 'package:top_stock_manager/application/database/offline/models/client_model.dart';
import 'package:top_stock_manager/application/database/offline/models/sale_model.dart';
import 'package:top_stock_manager/main.dart';

import '../../../system/configs/theming.dart';

class SalesController extends GetxController {
  // ------- static methods ------- //
  static SalesController get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<SalesController>(() async => SalesController());
  }

// ------- ./static methods ------- //

  var client = Rxn<ClientModel>();
  var sale = Rxn<Sale>();
  var sales = <SaleModel>[].obs;

  saveSale(Map<String, dynamic> data) async {
    if (sale.value == null) {
      await DB.salesDao.insertSale(data);
      Get.back();
      Get.snackbar('Sale'.tr, 'Sale added successfully'.tr);
    } else {
      SalesCompanion c = sale.value!
          .copyWith(
            date: d.Value(data['date']),
            clientId: d.Value(data['clientId']),
            description: d.Value(data['description']),
            updatedAt: d.Value(DateTime.now()),
          )
          .toCompanion(true);

      await DB.salesDao.updateSale(c);
      Get.back();
      Get.snackbar('Sale'.tr, 'Sale updated successfully'.tr);
    }
    //
    sale.value = null;
    client.value = null;
    //  purchase = Rxn<Purchase>();
  }

  deleteSale(Sale sal) {
    Get.defaultDialog(
      title: "Delete Sale".tr,
      middleText:
          "${"Are you sure you want to delete sale".tr} : \"${sal.date}\"",
      textConfirm: "Delete".tr,
      buttonColor: kDanger,
      onConfirm: () {
        DB.salesDao.deleteSale(sal);
        sale.value = null;
        client.value = null;
        Get.back();
        Get.snackbar('Sale'.tr, 'Sale deleted successfully'.tr);
      },
    );
  }

  @override
  void onReady() {
    DB.salesDao.watchAllSales().listen((event) {
      sales.value = event;
      // log(event.toString());
    });

    super.onReady();
  }
}
