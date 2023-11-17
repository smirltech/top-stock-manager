import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_stock_manager/application/core/controllers/suppliers_controller.dart';
import 'package:top_stock_manager/application/database/offline/models/supplier_model.dart';
import 'package:top_stock_manager/application/ui/purchases/purchases_screen.dart';
import 'package:top_stock_manager/system/configs/theming.dart';

import '../../core/controllers/purchases_controller.dart';

class PurchaseAddEditScreen extends StatefulWidget {
  const PurchaseAddEditScreen({super.key});

  static String route = "/purchases/create-edit";

  @override
  State<PurchaseAddEditScreen> createState() => _PurchaseAddEditScreenState();
}

class _PurchaseAddEditScreenState extends State<PurchaseAddEditScreen> {
  final _purchaseAddFormKey = GlobalKey<FormState>();
  final TextEditingController dateEC = TextEditingController();

  final TextEditingController descriptionEC = TextEditingController();

  late List<DropdownMenuItem<SupplierModel>> suppliersDrop;

  @override
  void initState() {
    if (PurchasesController.to.purchase.value != null) {
      dateEC.text = PurchasesController.to.purchase.value!.date.toString();

      descriptionEC.text =
          PurchasesController.to.purchase.value!.description.toString();
    }

    suppliersDrop = SuppliersController.to.suppliers
        .map(
          (sup) => DropdownMenuItem<SupplierModel>(
            value: sup,
            child: Text(sup.name),
          ),
        )
        .toList();
    suppliersDrop.insert(
      0,
      const DropdownMenuItem<SupplierModel>(
        value: null,
        child: Text("== SELECT SUPPLIER =="),
      ),
    );
    log(SuppliersController.to.suppliers.toString());
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
              key: _purchaseAddFormKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Purchase Screen'.tr,
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
                                if (!_purchaseAddFormKey.currentState!
                                    .validate()) {
                                  log('failed');
                                  return;
                                }
                                _purchaseAddFormKey.currentState!.save();
                                Map<String, dynamic> _purchase = {
                                  'date': DateTime.parse(dateEC.text),
                                  'supplierId':
                                      PurchasesController.to.supplier.value!.id,
                                  'description': descriptionEC.text,
                                };
                                // log(_purchase.toString());
                                PurchasesController.to.savePurchase(_purchase);
                              },
                              style: OutlinedButton.styleFrom(
                                  foregroundColor: kWhite,
                                  backgroundColor: kPrimary),
                              child: Text(
                                'Save Purchase'.tr,
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
                                value: PurchasesController.to.supplier.value,
                                items: suppliersDrop,
                                onChanged: (SupplierModel? sup) {
                                  PurchasesController.to.supplier.value = sup;
                                },
                                decoration: InputDecoration(
                                  hintText: "Supplier".tr,
                                  labelText: "Supplier".tr,
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
              child: Container(
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
                  rows: PurchasesController.to.purchases.map((pur) {
                    return DataRow(
                      cells: [
                        DataCell(Text("Producr")),
                        DataCell(Text("20")),
                        DataCell(Text("10 000 Fc")),
                        DataCell(Text("200 000 Fc")),
                        DataCell(
                          SizedBox(
                            width: 200.0,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      PurchasesController.to.purchase.value =
                                          pur.purchase;
                                      //purchaseAdd(title: sup.supplier.name);
                                    },
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
                                    onPressed: () {
                                      PurchasesController.to
                                          .deletePurchase(pur.purchase);
                                    },
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

/*supplierAdd({String title = "Add a new supplier"}) {
    final _supplierAddFormKey = GlobalKey<FormState>();
    late Map<String, dynamic> _supplier = {
      'name': '',
      'sex': '',
      'contact': '',
      'description': '',
    };

    if (SuppliersController.to.supplier.value != null) {
      _supplier = {
        'name': SuppliersController.to.supplier.value?.name,
        'sex': SuppliersController.to.supplier.value?.sex,
        'contact': SuppliersController.to.supplier.value?.contact,
        'description': SuppliersController.to.supplier.value?.description,
      };
    }
    Get.bottomSheet(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Form(
            key: _supplierAddFormKey,
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
                    initialValue: _supplier['name'],
                    validator: (va) {
                      if (va!.isEmpty) {
                        return "Name must not be empty".tr;
                      } else if (va.length < 3) {
                        return "Length of name must be 3 characters and above";
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _supplier['name'] = value.toString();
                    },
                    decoration: InputDecoration(
                      hintText: "Supplier Name".tr,
                      labelText: "Name".tr,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: _supplier['description'],
                    onSaved: (String? value) {
                      _supplier['description'] = value.toString();
                    },
                    decoration: InputDecoration(
                      hintText: "Supplier Description".tr,
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
                        child: TextFormField(
                          initialValue: _supplier['sex'].toString(),
                          onSaved: (String? value) {
                            _supplier['sex'] = value.toString();
                          },
                          decoration: InputDecoration(
                            hintText: "Sex".tr,
                            labelText: "Sex".tr,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: TextFormField(
                          initialValue: _supplier['contact'],
                          onSaved: (String? value) {
                            _supplier['contact'] = value.toString();
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
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_supplierAddFormKey.currentState!.validate()) {
                          return;
                        }
                        _supplierAddFormKey.currentState!.save();
                        SuppliersController.to.saveSupplier(_supplier);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: kWhite,
                        backgroundColor: kWarning,
                      ),
                      child: Text('Save'.tr),
                    ),
                  ),
                ],
              ),
            )),
      ),
      backgroundColor: kWhite,
      ignoreSafeArea: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }*/
}
