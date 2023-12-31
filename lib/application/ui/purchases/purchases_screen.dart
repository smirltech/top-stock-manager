import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_stock_manager/system/configs/theming.dart';

import '../../core/controllers/purchases_controller.dart';

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({super.key});

  static String route = "/purchases";

  @override
  State<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
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
                    'Purchases Screen'.tr,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      PurchasesController.to.openPurchase();
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
                        label: Text('Date'.tr),
                      ),
                      DataColumn(
                        label: Text('Supplier'.tr),
                      ),
                      DataColumn(
                        label: Text('Amount'.tr),
                      ),
                      DataColumn(
                        label: Text('Description'.tr),
                      ),
                      DataColumn(
                        label: Text(''.tr),
                      ),
                    ],
                    rows: PurchasesController.to.purchases.mapIndexed((i, pur) {
                      return DataRow(
                        cells: [
                          DataCell(Text("${i + 1}")),
                          DataCell(Text(pur.dateStringed)),
                          DataCell(Text(pur.supplierName)),
                          DataCell(Text(pur.priceStringed)),
                          DataCell(Text(pur.description ?? '')),
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    PurchasesController.to
                                        .openPurchase(pur: pur);
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
                                        .deletePurchase(pur.purchase);
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
