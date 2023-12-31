import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_stock_manager/application/core/controllers/suppliers_controller.dart';
import 'package:top_stock_manager/application/core/services/data_services.dart';
import 'package:top_stock_manager/application/database/offline/models/product_model.dart';
import 'package:top_stock_manager/application/database/offline/models/supplier_model.dart';
import 'package:top_stock_manager/application/ui/purchases/purchases_screen.dart';
import 'package:top_stock_manager/system/configs/theming.dart';

import '../../core/controllers/purchases_controller.dart';
import '../../database/offline/app_database.dart';

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
      PurchasesController.to.supplier.value = SuppliersController.to.suppliers
          .singleWhere((element) =>
              element.id == PurchasesController.to.purchase.value!.supplierId);
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
    return Obx(() {
      return Scaffold(
        floatingActionButton: PurchasesController.to.purchase.value == null
            ? const SizedBox()
            : FloatingActionButton(
                onPressed: () {
                  PurchasesController.to.product.value = null;
                  inputAdd();
                },
                tooltip: "Add Item".tr,
                child: const Icon(Icons.add),
              ),
        body: Form(
          key: _purchaseAddFormKey,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Purchase Screen'.tr,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      if (PurchasesController.to.purchase.value != null)
                        Text.rich(
                          TextSpan(
                            text: '${'Total'.tr} : ',
                            children: [
                              TextSpan(
                                text:
                                    "${PurchasesController.to.purchase.value?.priceStringed ?? ''}",
                              ),
                            ],
                          ),
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      Row(
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              PurchasesController.to.purchase.value = null;
                              PurchasesController.to.supplier.value = null;
                              Get.toNamed(PurchasesScreen.route);
                            },
                            style: OutlinedButton.styleFrom(
                                foregroundColor: kWhite,
                                backgroundColor: kSecondary),
                            label: Text(
                              'Back'.tr,
                            ),
                            icon: const Icon(Icons.arrow_back),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          OutlinedButton.icon(
                            onPressed: () {
                              // log('save purchase');
                              if (!_purchaseAddFormKey.currentState!
                                  .validate()) {
                                //  log('failed');
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
                            label: Text(
                              'Save'.tr,
                            ),
                            icon: const Icon(Icons.save),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
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
                                          initialDate:
                                              DateTime.tryParse(dateEC.text) ??
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
                                log(PurchasesController.to.supplier.value
                                    .toString());
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
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    "Items".tr,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverFillRemaining(
                child: SingleChildScrollView(
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
                      rows: PurchasesController.to.purchase.value == null
                          ? []
                          : PurchasesController.to.purchase.value!.inputs!
                              .mapIndexed((i, ipt) {
                              return DataRow(
                                cells: [
                                  DataCell(Text("${i + 1}")),
                                  DataCell(Text("${ipt.productName}")),
                                  DataCell(Text("${ipt.quantityStringed}")),
                                  DataCell(Text("${ipt.priceStringed}")),
                                  DataCell(Text("${ipt.totalStringed}")),
                                  DataCell(
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            inputAdd(
                                                title: "Edit item".tr,
                                                input: ipt.input);
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
                                            PurchasesController.to
                                                .deleteInput(ipt.input);
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
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  inputAdd({String title = "Add an item", Input? input}) {
    final inputAddFormKey = GlobalKey<FormState>();
    late Map<String, dynamic> item = {
      'productId': null,
      'purchaseId': null,
      'quantity': 0.0,
      'price': 0.0,
    };
    if (input != null) {
      item = {
        'id': input.id,
        'productId': input.productId,
        'purchaseId': input.purchaseId,
        'quantity': input.quantity,
        'price': input.price,
      };
      PurchasesController.to.product.value = DataServices.to.products
          .firstWhereOrNull((element) => element.id == input.productId);
    }
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
        child: Wrap(
          children: [
            Form(
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
                      SizedBox(
                        height: 60,
                        child: DropdownButtonFormField<ProductModel>(
                          value: PurchasesController.to.product.value,
                          items: productsDrop,
                          onChanged: (ProductModel? sup) {
                            PurchasesController.to.product.value = sup;
                            item['productId'] =
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
                              initialValue: item['quantity'].toString(),
                              onSaved: (String? value) {
                                item['quantity'] =
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
                              initialValue: item['price'].toString(),
                              onSaved: (String? value) {
                                item['price'] =
                                    double.tryParse(value.toString());
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

                            PurchasesController.to
                                .appendToInputs(data: item, input: input);
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
