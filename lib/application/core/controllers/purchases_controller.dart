import 'dart:developer';

import 'package:drift/drift.dart' as d;
import 'package:get/get.dart';
import 'package:top_stock_manager/application/core/controllers/suppliers_controller.dart';
import 'package:top_stock_manager/application/core/services/data_services.dart';
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
    purchase.value = await DB.purchasesDao.getPurchase(pur.id);
    supplier.value = SuppliersController.to.suppliers.firstWhereOrNull((element) => element.id == pur.supplierId);

    Get.toNamed(PurchaseAddEditScreen.route);
  }

  savePurchase(Map<String, dynamic> data) async {
    if (purchase.value == null) {
      await DB.purchasesDao.insertPurchase(data);
     // Get.back();
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
     // Get.back();
      Get.snackbar('Purchase'.tr, 'Purchase updated successfully'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
    //
   // purchase.value = null;
  //  supplier.value = null;
    //  purchase = Rxn<Purchase>();
  }

  appendToInputs({required Map<String, dynamic> data, Input? input}) async {
    if (input == null) {
      data['updatedAt'] = DateTime.now();
      data['createdAt'] = DateTime.now();
      data['purchaseId'] = purchase.value!.id;
      await DB.inputsDao.insertInput(data);
      Get.back();
      Get.snackbar('Item'.tr, 'Item added successfully'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      InputsCompanion c = input
          .copyWith(
            productId: d.Value(data['productId']),
            purchaseId: d.Value(data['purchaseId']),
            quantity: d.Value(data['quantity']),
            price: d.Value(data['price']),
            updatedAt: d.Value(DateTime.now()),
          )
          .toCompanion(true);

      await DB.inputsDao.updateInput(c);
      Get.back();
      Get.snackbar('Item'.tr, 'Item updated successfully'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
    purchase.value!.inputs =
        await DB.inputsDao.getInputsWithProductByPurchase(purchase.value!.id);
    purchase.refresh();
  }

  deleteInput(Input input) {
    Get.defaultDialog(
      title: "Remove Item".tr,
      middleText:
          "${"Are you sure you want to remove item".tr} : \"${input.id}\"",
      textConfirm: "Remove".tr,
      buttonColor: kDanger,
      onConfirm: () async {
        await DB.inputsDao.deleteInput(input);
        purchase.value!.inputs =
            await DB.inputsDao.getInputsWithProductByPurchase(purchase.value!.id);
        purchase.refresh();
        Get.back();
        Get.snackbar('Item'.tr, 'Item removed successfully'.tr,
            snackPosition: SnackPosition.BOTTOM);
      },
    );
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
