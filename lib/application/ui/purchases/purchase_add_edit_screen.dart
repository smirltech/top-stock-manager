import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_stock_manager/application/core/controllers/suppliers_controller.dart';
import 'package:top_stock_manager/application/core/services/data_services.dart';
import 'package:top_stock_manager/application/database/offline/models/Input_product_model.dart';
import 'package:top_stock_manager/application/database/offline/models/product_model.dart';
import 'package:top_stock_manager/application/database/offline/models/supplier_model.dart';
import 'package:top_stock_manager/application/ui/purchases/purchases_screen.dart';
import 'package:top_stock_manager/main.dart';
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
    // log(SuppliersController.to.suppliers.toString());
    //PurchasesController.to.supplier.value = SuppliersController.to.suppliers[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          inputAdd();
        },
        tooltip: "Add input".tr,
        child: const Icon(Icons.add),
      ),
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
                                Map<String, dynamic> purchase = {
                                  'date': DateTime.parse(dateEC.text),
                                  'supplierId':
                                      PurchasesController.to.supplier.value?.id,
                                  'description': descriptionEC.text,
                                };
                                // log(_purchase.toString());
                                PurchasesController.to.savePurchase(purchase);
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
                  rows: PurchasesController.to.inputs.map((ipt) {
                    InputProductModel? ipm;
                    DB.inputsDao
                        .getInputProduct(ipt.id)
                        .then((value) => ipm = value);
                    return DataRow(
                      cells: [
                        DataCell(Text("${ipm?.productName}")),
                        DataCell(Text("${ipm?.quantity}")),
                        DataCell(Text("${ipm?.price}")),
                        DataCell(Text("${ipm?.total!}")),
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

  inputAdd({String title = "Add a new input"}) {
    final inputAddFormKey = GlobalKey<FormState>();
    late Map<String, dynamic> input = {
      'productId': null,
      'purchaseId': null,
      'quantity': 0.0,
      'price': 0.0,
    };
    late List<DropdownMenuItem<ProductModel>> productsDrop;

    productsDrop = DataServices.to.products
        .map(
          (sup) => DropdownMenuItem<ProductModel>(
            value: sup,
            child: Text(sup.name),
          ),
        )
        .toList();

    productsDrop.insert(
      0,
      const DropdownMenuItem<ProductModel>(
        value: null,
        child: Text("== SELECT PRODUCT =="),
      ),
    );

    Get.bottomSheet(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Form(
            key: inputAddFormKey,
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
                  Flexible(
                    child: DropdownButtonFormField<ProductModel>(
                      value: PurchasesController.to.product.value,
                      items: productsDrop,
                      onChanged: (ProductModel? sup) {
                        PurchasesController.to.product.value = sup;
                        input['productId'] =
                            PurchasesController.to.product.value?.id;
                      },
                      decoration: InputDecoration(
                        hintText: "Product".tr,
                        labelText: "Product".tr,
                        border: const OutlineInputBorder(),
                      ),
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
                          initialValue: input['quantity'].toString(),
                          onSaved: (String? value) {
                            input['quantity'] =
                                double.tryParse(value.toString());
                          },
                          decoration: InputDecoration(
                            hintText: "Quantity".tr,
                            labelText: "Quantity".tr,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: TextFormField(
                          initialValue: input['price'].toString(),
                          onSaved: (String? value) {
                            input['price'] = double.tryParse(value.toString());
                          },
                          decoration: InputDecoration(
                            hintText: "Price".tr,
                            labelText: "Price".tr,
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
                        if (!inputAddFormKey.currentState!.validate()) {
                          return;
                        }
                        inputAddFormKey.currentState!.save();

                        PurchasesController.to.appendToInputs(input);
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
  }
}
