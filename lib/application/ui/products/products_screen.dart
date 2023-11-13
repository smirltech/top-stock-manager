import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  child: Text(
                    'Add Product'.tr,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  productAdd() {
    Get.bottomSheet(
      Container(
        height: Get.mediaQuery.size.height,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Form(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Add a new product".tr,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Product Name".tr,
                  labelText: "Name".tr,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Product Description".tr,
                  labelText: "Description".tr,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Minimum Quantity".tr,
                        labelText: "Min".tr,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Maximum Quantity".tr,
                        labelText: "Max".tr,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Unit of Measure".tr,
                        labelText: "Unit".tr,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Save'.tr),
                ),
              ),
            ],
          ),
        )),
      ),
      backgroundColor: kWhite,
      ignoreSafeArea: true,
    );
  }
}
