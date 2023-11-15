import 'package:drift/drift.dart' as d;
import 'package:get/get.dart';
import 'package:top_stock_manager/application/database/offline/app_database.dart';
import 'package:top_stock_manager/main.dart';

import '../../../system/configs/theming.dart';
import '../../database/offline/models/purchase_model.dart';

class PurchasesController extends GetxController {
  // ------- static methods ------- //
  static PurchasesController get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<PurchasesController>(() async => PurchasesController());
  }

// ------- ./static methods ------- //

  var purchase = Rxn<Purchase>();
  var purchases = <PurchaseModel>[].obs;

  savePurchase(Map<String, dynamic> data) async {
    if (purchase.value == null) {
      await DB.purchasesDao.insertPurchase(data);
      Get.back();
      Get.snackbar('Purchase'.tr, 'Purchase added successfully'.tr);
    } else {
      PurchasesCompanion c = purchase.value!
          .copyWith(
            date: data['date'],
            supplierId: d.Value(data['supplierId']),
            description: d.Value(data['description']),
            updatedAt: d.Value(DateTime.now()),
          )
          .toCompanion(true);

      await DB.purchasesDao.updatePurchase(c);
      Get.back();
      Get.snackbar('Purchase'.tr, 'Purchase updated successfully'.tr);
    }
    purchase.value = null;
  }

  deletePurchase(Purchase pur) {
    Get.defaultDialog(
      title: "Delete Purchase".tr,
      middleText:
          "${"Are you sure you want to delete purchase".tr} : \"${pur.date}\"",
      textConfirm: "Delete".tr,
      buttonColor: kDanger,
      onConfirm: () {
        DB.purchasesDao.deletePurchase(pur);
        purchase.value = null;
        Get.back();
        Get.snackbar('Purchase'.tr, 'Purchase deleted successfully'.tr);
      },
    );
  }

  @override
  void onReady() {
    DB.purchasesDao.watchAllPurchases().listen((event) {
      purchases.value = event;
      // log(event.toString());
    });

    super.onReady();
  }
}
