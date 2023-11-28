import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_stock_manager/application/core/services/data_services.dart';
import 'package:top_stock_manager/system/configs/theming.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  static String route = "/products";

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Products Screen'.tr,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                OutlinedButton(
                  onPressed: () {
                    productAdd();
                  },
                  style: OutlinedButton.styleFrom(
                      foregroundColor: kWhite, backgroundColor: kPrimary),
                  child: Text(
                    'Add Product'.tr,
                  ),
                )
              ],
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
                      label: Text('#'.tr),
                    ),
                    DataColumn(
                      label: Text('Name'.tr),
                    ),
                    DataColumn(
                      label: Text('Description'.tr),
                    ),
                    DataColumn(
                      label: Text('Min'.tr),
                      numeric: true,
                    ),
                    DataColumn(
                      label: Text('Max'.tr),
                      numeric: true,
                    ),
                    DataColumn(
                      label: Text('Stock'.tr),
                      numeric: true,
                    ),
                    DataColumn(
                      label: Text('Price'.tr),
                      numeric: true,
                    ),
                    DataColumn(
                      label: Text(''.tr),
                    ),
                  ],
                  rows: DataServices.to.products.mapIndexed((i, prod) {
                    return DataRow(
                      cells: [
                        DataCell(Text("${i + 1}")),
                        DataCell(Text(prod.name)),
                        DataCell(Text(prod.description ?? '')),
                        DataCell(Text(prod.minStringed)),
                        DataCell(Text(prod.maxStringed)),
                        DataCell(Text(prod.quantityStringed)),
                        DataCell(Text(prod.priceStringed)),
                        DataCell(
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    DataServices.to.product.value =
                                        prod.product;
                                    productAdd(title: prod.product.name);
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
                                    DataServices.to.deleteProduct(prod.product);
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

  productAdd({String title = "Add a new product"}) {
    final productAddFormKey = GlobalKey<FormState>();
    late Map<String, dynamic> product = {
      'name': '',
      'description': '',
      'minimum': 0.0,
      'maximum': 0.0,
      'unit': '',
      'product_id': null,
    };

    if (DataServices.to.product.value != null) {
      product = {
        'name': DataServices.to.product.value?.name,
        'description': DataServices.to.product.value?.description,
        'minimum': DataServices.to.product.value?.minimum,
        'maximum': DataServices.to.product.value?.maximum,
        'unit': DataServices.to.product.value?.unit,
        'product_id': null,
      };
    }
    Get.bottomSheet(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Form(
            key: productAddFormKey,
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
                    initialValue: product['name'],
                    validator: (va) {
                      if (va!.isEmpty) {
                        return "Name must not be empty".tr;
                      } else if (va.length < 3) {
                        return "Length of name must be 3 characters and above";
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      product['name'] = value.toString();
                    },
                    decoration: InputDecoration(
                      hintText: "Product Name".tr,
                      labelText: "Name".tr,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: product['description'],
                    onSaved: (String? value) {
                      product['description'] = value.toString();
                    },
                    decoration: InputDecoration(
                      hintText: "Product Description".tr,
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
                          initialValue: product['minimum'].toString(),
                          onSaved: (String? value) {
                            product['minimum'] = double.parse(value.toString());
                          },
                          decoration: InputDecoration(
                            hintText: "Minimum Quantity".tr,
                            labelText: "Min".tr,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: TextFormField(
                          initialValue: product['maximum'].toString(),
                          onSaved: (String? value) {
                            product['maximum'] = double.parse(value.toString());
                          },
                          decoration: InputDecoration(
                            hintText: "Maximum Quantity".tr,
                            labelText: "Max".tr,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: TextFormField(
                          initialValue: product['unit'],
                          validator: (va) {
                            if (va!.isEmpty) {
                              return "Unit must not be empty".tr;
                            } else if (va.length < 2) {
                              return "Length of unit must be 2 characters and above";
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            product['unit'] = value.toString();
                          },
                          decoration: InputDecoration(
                            hintText: "Unit of Measure".tr,
                            labelText: "Unit".tr,
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
                        if (!productAddFormKey.currentState!.validate()) {
                          return;
                        }
                        productAddFormKey.currentState!.save();
                        DataServices.to.saveProduct(product);
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
