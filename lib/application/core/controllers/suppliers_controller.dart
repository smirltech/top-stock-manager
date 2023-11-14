import 'package:drift/drift.dart' as d;
import 'package:get/get.dart';
import 'package:top_stock_manager/application/database/offline/app_database.dart';
import 'package:top_stock_manager/main.dart';

import '../../../system/configs/theming.dart';
import '../../database/offline/models/supplier_model.dart';

class SuppliersController extends GetxController {
  // ------- static methods ------- //
  static SuppliersController get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<SuppliersController>(() async => SuppliersController());
  }

// ------- ./static methods ------- //

  var supplier = Rxn<Supplier>();
  var suppliers = <SupplierModel>[].obs;

  saveSupplier(Map<String, dynamic> data) async {
    if (supplier.value == null) {
      await DB.suppliersDao.insertSupplier(data);
      Get.back();
      Get.snackbar('Supplier'.tr, 'Supplier added successfully'.tr);
    } else {
      SuppliersCompanion c = supplier.value!
          .copyWith(
            name: data['name'],
            sex: d.Value(data['sex']),
            contact: d.Value(data['contact']),
            description: d.Value(data['description']),
            updatedAt: d.Value(DateTime.now()),
          )
          .toCompanion(true);

      await DB.suppliersDao.updateSupplier(c);
      Get.back();
      Get.snackbar('Supplier'.tr, 'Supplier updated successfully'.tr);
    }
    supplier.value = null;
  }

  deleteSupplier(Supplier sup) {
    Get.defaultDialog(
      title: "Delete Supplier".tr,
      middleText:
          "${"Are you sure you want to delete supplier".tr} : \"${sup.name}\"",
      textConfirm: "Delete".tr,
      buttonColor: kDanger,
      onConfirm: () {
        DB.suppliersDao.deleteSupplier(sup);
        supplier.value = null;
        Get.back();
        Get.snackbar('Supplier'.tr, 'Supplier deleted successfully'.tr);
      },
    );
  }

  @override
  void onReady() {
    DB.suppliersDao.watchAllSuppliers().listen((event) {
      suppliers.value = event;
      // log(event.toString());
    });

    super.onReady();
  }
}
