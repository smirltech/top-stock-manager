import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_stock_manager/application/ui/sales/sale_add_edit_screen.dart';
import 'package:top_stock_manager/system/configs/theming.dart';

import '../../core/controllers/sales_controller.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  static String route = "/sales";

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
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
                    'Sales Screen'.tr,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      Get.toNamed(SaleAddEditScreen.route);
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
                        label: Text('Client'.tr),
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
                    rows: SalesController.to.sales.mapIndexed((i, sal) {
                      return DataRow(
                        cells: [
                          DataCell(Text("${i + 1}")),
                          DataCell(Text(sal.dateStringed)),
                          DataCell(Text(sal.clientName)),
                          DataCell(Text(sal.priceStringed)),
                          DataCell(Text(sal.description ?? '')),
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    SalesController.to.sale.value = sal.sale;
                                    Get.toNamed(SaleAddEditScreen.route);
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
                                    SalesController.to.deleteSale(sal.sale);
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
}
