import 'dart:developer';

import 'package:drift/drift.dart' as d;
import 'package:get/get.dart';
import 'package:top_stock_manager/application/database/offline/app_database.dart';
import 'package:top_stock_manager/application/database/offline/models/product_model.dart';
import 'package:top_stock_manager/application/database/offline/models/supplier_model.dart';
import 'package:top_stock_manager/main.dart';

import '../../../system/configs/theming.dart';
import '../../database/offline/models/purchase_model.dart';
import '../../ui/purchases/purchase_add_edit_screen.dart';

class PurchasesController extends GetxController {
  // ------- static methods ------- //
  static PurchasesController get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<PurchasesController>(() async => PurchasesController());
  }

// ------- ./static methods ------- //

  var supplier = Rxn<SupplierModel>();
  var purchase = Rxn<PurchaseModel>();
  var product = Rxn<ProductModel>();
  var purchases = <PurchaseModel>[].obs;
  var inputs = <Input>[].obs;
  var inputsList = <Input>[].obs;

  openPurchase(PurchaseModel pur) async {
    purchase.value = pur;
    inputs.value = await DB.inputsDao.getInputsByPurchase(pur.id);
    Get.toNamed(PurchaseAddEditScreen.route);
  }

  savePurchase(Map<String, dynamic> data) async {
    if (purchase.value == null) {
      await DB.purchasesDao.insertPurchase(data);
      Get.back();
      Get.snackbar('Purchase'.tr, 'Purchase added successfully'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      PurchasesCompanion c = purchase.value!.purchase
          .copyWith(
            date: d.Value(data['date']),
            supplierId: d.Value(data['supplierId']),
            description: d.Value(data['description']),
            updatedAt: d.Value(DateTime.now()),
          )
          .toCompanion(true);

      await DB.purchasesDao.updatePurchase(c);
      Get.back();
      Get.snackbar('Purchase'.tr, 'Purchase updated successfully'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
    //
    purchase.value = null;
    supplier.value = null;
    //  purchase = Rxn<Purchase>();
  }

  appendToInputs(Map<String, dynamic> data) async {
    data['createdAt'] = DateTime.now();
    data['updatedAt'] = DateTime.now();
    data['id'] = DateTime.now().millisecondsSinceEpoch * -1;
    // ic = InputsCompanion.insert({});
    inputs.add(
      Input.fromJson(data),
    );
    log(inputs.string);
    Get.back();
    // Get.snackbar('Input'.tr, 'Input added successfully'.tr,
    //     snackPosition: SnackPosition.BOTTOM);
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
        supplier.value = null;
        Get.back();
        Get.snackbar('Purchase'.tr, 'Purchase deleted successfully'.tr,
            snackPosition: SnackPosition.BOTTOM);
      },
    );
  }

  @override
  void onReady() {
    DB.purchasesDao.watchAllPurchases().listen((event) {
      purchases.value = event;
      /* purchases.forEach((purch) async {
        purch.inputs = await DB.inputsDao.getInputsByPurchase(purch.id);
      });*/
      // log(event.toString());
    });

    super.onReady();
  }
}
