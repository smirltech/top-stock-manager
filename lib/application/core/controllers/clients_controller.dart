import 'package:drift/drift.dart' as d;
import 'package:get/get.dart';
import 'package:top_stock_manager/application/database/offline/app_database.dart';
import 'package:top_stock_manager/main.dart';

import '../../../system/configs/theming.dart';
import '../../database/offline/models/client_model.dart';

class ClientsController extends GetxController {
  // ------- static methods ------- //
  static ClientsController get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<ClientsController>(() async => ClientsController());
  }

// ------- ./static methods ------- //

  var client = Rxn<Client>();
  var clients = <ClientModel>[].obs;

  saveClient(Map<String, dynamic> data) async {
    if (client.value == null) {
      await DB.clientsDao.insertClient(data);
      Get.back();
      Get.snackbar('Client'.tr, 'Client added successfully'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      ClientsCompanion c = client.value!
          .copyWith(
            name: data['name'],
            sex: d.Value(data['sex']),
            contact: d.Value(data['contact']),
            description: d.Value(data['description']),
            updatedAt: d.Value(DateTime.now()),
          )
          .toCompanion(true);

      await DB.clientsDao.updateClient(c);
      Get.back();
      Get.snackbar('Client'.tr, 'Client updated successfully'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
    client.value = null;
  }

  deleteClient(Client sup) {
    Get.defaultDialog(
      title: "Delete Client".tr,
      middleText:
          "${"Are you sure you want to delete client".tr} : \"${sup.name}\"",
      textConfirm: "Delete".tr,
      buttonColor: kDanger,
      onConfirm: () {
        DB.clientsDao.deleteClient(sup);
        client.value = null;
        Get.back();
        Get.snackbar('Client'.tr, 'Client deleted successfully'.tr,
            snackPosition: SnackPosition.BOTTOM);
      },
    );
  }

  @override
  void onReady() {
    DB.clientsDao.watchAllClients().listen((event) {
      clients.value = event;
      // log(event.toString());
    });

    super.onReady();
  }
}
