import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_stock_manager/application/core/controllers/suppliers_controller.dart';
import 'package:top_stock_manager/system/configs/theming.dart';

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({super.key});

  static String route = "/suppliers";

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
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
                    'Suppliers Screen'.tr,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      supplierAdd();
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
                    rows: SuppliersController.to.suppliers.mapIndexed((i, sup) {
                      return DataRow(
                        cells: [
                          DataCell(Text("${i + 1}")),
                          DataCell(Text(sup.name)),
                          DataCell(Text(sup.sex)),
                          DataCell(Text(sup.contact)),
                          DataCell(Text(sup.description ?? '')),
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    SuppliersController.to.supplier.value =
                                        sup.supplier;
                                    supplierAdd(title: sup.supplier.name);
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
                                    SuppliersController.to
                                        .deleteSupplier(sup.supplier);
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

  supplierAdd({String title = "Add a new supplier"}) {
    final supplierAddFormKey = GlobalKey<FormState>();
    late Map<String, dynamic> supplier = {
      'name': '',
      'sex': '',
      'contact': '',
      'description': '',
    };

    if (SuppliersController.to.supplier.value != null) {
      supplier = {
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
            key: supplierAddFormKey,
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
                    initialValue: supplier['name'],
                    validator: (va) {
                      if (va!.isEmpty) {
                        return "Name must not be empty".tr;
                      } else if (va.length < 3) {
                        return "Length of name must be 3 characters and above";
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      supplier['name'] = value.toString();
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
                    initialValue: supplier['description'],
                    onSaved: (String? value) {
                      supplier['description'] = value.toString();
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
                          initialValue: supplier['sex'].toString(),
                          onSaved: (String? value) {
                            supplier['sex'] = value.toString();
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
                          initialValue: supplier['contact'],
                          onSaved: (String? value) {
                            supplier['contact'] = value.toString();
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
                        if (!supplierAddFormKey.currentState!.validate()) {
                          return;
                        }
                        supplierAddFormKey.currentState!.save();
                        SuppliersController.to.saveSupplier(supplier);
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
      ),
      backgroundColor: kWhite,
      ignoreSafeArea: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
