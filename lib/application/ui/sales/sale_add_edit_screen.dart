import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_stock_manager/application/database/offline/models/client_model.dart';
import 'package:top_stock_manager/application/ui/purchases/purchases_screen.dart';
import 'package:top_stock_manager/system/configs/theming.dart';

import '../../core/controllers/clients_controller.dart';
import '../../core/controllers/sales_controller.dart';

class SaleAddEditScreen extends StatefulWidget {
  const SaleAddEditScreen({super.key});

  static String route = "/sales/create-edit";

  @override
  State<SaleAddEditScreen> createState() => _SaleAddEditScreenState();
}

class _SaleAddEditScreenState extends State<SaleAddEditScreen> {
  final _saleAddFormKey = GlobalKey<FormState>();
  final TextEditingController dateEC = TextEditingController();

  final TextEditingController descriptionEC = TextEditingController();

  late List<DropdownMenuItem<ClientModel>> clientsDrop;

  @override
  void initState() {
    if (SalesController.to.sale.value != null) {
      dateEC.text = SalesController.to.sale.value!.date.toString();

      descriptionEC.text =
          SalesController.to.sale.value!.description.toString();
    }

    clientsDrop = ClientsController.to.clients
        .map(
          (cup) => DropdownMenuItem<ClientModel>(
            value: cup,
            child: Text(cup.name),
          ),
        )
        .toList();
    clientsDrop.insert(
      0,
      const DropdownMenuItem<ClientModel>(
        value: null,
        child: Text("== SELECT CLIENT =="),
      ),
    );
    log(ClientsController.to.clients.toString());
    //PurchasesController.to.supplier.value = SuppliersController.to.suppliers[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Obx(() {
            return Form(
              key: _saleAddFormKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sale Screen'.tr,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                Get.toNamed(PurchasesScreen.route);
                              },
                              style: OutlinedButton.styleFrom(
                                  foregroundColor: kWhite,
                                  backgroundColor: kSecondary),
                              child: Text(
                                'Back'.tr,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                log('save purchase');
                                if (!_saleAddFormKey.currentState!.validate()) {
                                  log('failed');
                                  return;
                                }
                                _saleAddFormKey.currentState!.save();
                                Map<String, dynamic> sale = {
                                  'date': DateTime.parse(dateEC.text),
                                  'clientId':
                                      SalesController.to.client.value?.id,
                                  'description': descriptionEC.text,
                                };
                                // log(_purchase.toString());
                                SalesController.to.saveSale(sale);
                              },
                              style: OutlinedButton.styleFrom(
                                  foregroundColor: kWhite,
                                  backgroundColor: kPrimary),
                              child: Text(
                                'Save Sale'.tr,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 8.0),
                      child: Column(
                        children: [
                          Row(children: [
                            Flexible(
                              child: TextFormField(
                                controller: dateEC,
                                readOnly: true,
                                validator: (va) {
                                  if (va!.isEmpty) {
                                    return "Date must not be empty".tr;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Date of purchase".tr,
                                  labelText: "Date".tr,
                                  border: const OutlineInputBorder(),
                                ),
                                onTap: () {
                                  Get.dialog(
                                    Center(
                                      child: SizedBox(
                                        width: Get.width / 3,
                                        child: Card(
                                          child: CalendarDatePicker(
                                            initialDate: DateTime.tryParse(
                                                    dateEC.text) ??
                                                DateTime.now(),
                                            firstDate: DateTime.now().subtract(
                                                const Duration(days: 30)),
                                            lastDate: DateTime.now(),
                                            onDateChanged: (DateTime value) {
                                              dateEC.text = value.toString();
                                              Get.back();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ).then((value) {
                                    // setState(() {});
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: DropdownButtonFormField(
                                value: SalesController.to.client.value,
                                items: clientsDrop,
                                onChanged: (ClientModel? cup) {
                                  SalesController.to.client.value = cup;
                                },
                                decoration: InputDecoration(
                                  hintText: "Client".tr,
                                  labelText: "Client".tr,
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                            /* Flexible(
                          child: TextFormField(
                            controller: supplierEC,
                            validator: (va) {
                              if (va!.isEmpty) {
                                return "Supplier must not be empty".tr;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Supplier".tr,
                              labelText: "Supplier".tr,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),*/
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: TextFormField(
                                  controller: descriptionEC,
                                  decoration: InputDecoration(
                                    hintText: "Description".tr,
                                    labelText: "Description".tr,
                                    border: const OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          Center(
            child: Text(
              "Products".tr,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Obx(() {
            return SingleChildScrollView(
              child: SizedBox(
                width: Get.width - 50,
                child: DataTable(
                  sortAscending: true,
                  sortColumnIndex: 0,
                  showBottomBorder: true,
                  columns: [
                    DataColumn(
                      label: Text('Product'.tr),
                    ),
                    DataColumn(
                      label: Text('Quantity'.tr),
                    ),
                    DataColumn(
                      label: Text('Price'.tr),
                    ),
                    DataColumn(
                      label: Text('Total'.tr),
                    ),
                    DataColumn(
                      label: Text(''.tr),
                    ),
                  ],
                  rows: SalesController.to.sales.map((pur) {
                    return DataRow(
                      cells: [
                        const DataCell(Text("Product")),
                        const DataCell(Text("20")),
                        const DataCell(Text("10 000 Fc")),
                        const DataCell(Text("200 000 Fc")),
                        DataCell(
                          SizedBox(
                            width: 200.0,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: null,
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: kWhite,
                                        backgroundColor: kWarning),
                                    child: Text('Edit'.tr),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: null,
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: kWhite,
                                        backgroundColor: kDanger),
                                    child: Text('Delete'.tr),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
