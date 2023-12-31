import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_stock_manager/system/configs/theming.dart';

import '../../core/controllers/clients_controller.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  static String route = "/clients";

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Clients Screen'.tr,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      ClientsController.to.client.value = null;
                      clientAdd();
                    },
                    style: OutlinedButton.styleFrom(
                        foregroundColor: kWhite, backgroundColor: kPrimary),
                    label: Text(
                      'Add'.tr,
                    ),
                    icon: const Icon(Icons.add),
                  )
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: Obx(() {
              return SingleChildScrollView(
                child: SizedBox(
                  width: Get.width - 50,
                  child: DataTable(
                    sortAscending: true,
                    sortColumnIndex: 0,
                    showBottomBorder: true,
                    columns: [
                      DataColumn(
                        label: Text('#'.tr),
                      ),
                      DataColumn(
                        label: Text('Name'.tr),
                      ),
                      DataColumn(
                        label: Text('Sex'.tr),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Text('Contact'.tr),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Text('Description'.tr),
                      ),
                      DataColumn(
                        label: Text(''.tr),
                      ),
                    ],
                    rows: ClientsController.to.clients.mapIndexed((i, cl) {
                      return DataRow(
                        cells: [
                          DataCell(Text("${i + 1}")),
                          DataCell(Text(cl.name)),
                          DataCell(Text(cl.sex)),
                          DataCell(Text(cl.contact)),
                          DataCell(Text(cl.description ?? '')),
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    ClientsController.to.client.value =
                                        cl.client;
                                    clientAdd(title: cl.client.name);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: kWhite,
                                      backgroundColor: kWarning),
                                  label: Text('Edit'.tr),
                                  icon: const Icon(Icons.edit),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    ClientsController.to
                                        .deleteClient(cl.client);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: kWhite,
                                      backgroundColor: kDanger),
                                  label: Text('Delete'.tr),
                                  icon: const Icon(Icons.clear),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  clientAdd({String title = "Add a new client"}) {
    final clientAddFormKey = GlobalKey<FormState>();
    late Map<String, dynamic> client = {
      'name': '',
      'sex': '',
      'contact': '',
      'description': '',
    };

    if (ClientsController.to.client.value != null) {
      client = {
        'name': ClientsController.to.client.value?.name,
        'sex': ClientsController.to.client.value?.sex,
        'contact': ClientsController.to.client.value?.contact,
        'description': ClientsController.to.client.value?.description,
      };
    }
    Get.bottomSheet(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Wrap(
          children: [
            Form(
                key: clientAddFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          title.tr,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: client['name'],
                        validator: (va) {
                          if (va!.isEmpty) {
                            return "Name must not be empty".tr;
                          } else if (va.length < 3) {
                            return "Length of name must be 3 characters and above";
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          client['name'] = value.toString();
                        },
                        decoration: InputDecoration(
                          hintText: "Client Name".tr,
                          labelText: "Name".tr,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: client['description'],
                        onSaved: (String? value) {
                          client['description'] = value.toString();
                        },
                        decoration: InputDecoration(
                          hintText: "Client Description".tr,
                          labelText: "Description".tr,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: DropdownButtonFormField(
                              value: client['sex'].toString(),
                              decoration: InputDecoration(
                                hintText: "Sex".tr,
                                labelText: "Sex".tr,
                                border: const OutlineInputBorder(),
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: "",
                                  child: Text(
                                    "UNDEFINED".tr,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "M",
                                  child: Text(
                                    "Male".tr,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "F",
                                  child: Text(
                                    "Female".tr,
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                client['sex'] = value.toString();
                              },
                            ),
                          ),
                          /*  Flexible(
                            child: TextFormField(
                              initialValue: client['sex'].toString(),
                              onSaved: (String? value) {
                                client['sex'] = value.toString();
                              },
                              decoration: InputDecoration(
                                hintText: "Sex".tr,
                                labelText: "Sex".tr,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),*/
                          const SizedBox(
                            width: 10.0,
                          ),
                          Flexible(
                            child: TextFormField(
                              initialValue: client['contact'],
                              onSaved: (String? value) {
                                client['contact'] = value.toString();
                              },
                              decoration: InputDecoration(
                                hintText: "Contact".tr,
                                labelText: "Contact".tr,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (!clientAddFormKey.currentState!.validate()) {
                              return;
                            }
                            clientAddFormKey.currentState!.save();
                            ClientsController.to.saveClient(client);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: kWhite,
                            backgroundColor: kWarning,
                          ),
                          label: Text('Save'.tr),
                          icon: const Icon(Icons.save),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
      backgroundColor: kWhite,
      ignoreSafeArea: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
