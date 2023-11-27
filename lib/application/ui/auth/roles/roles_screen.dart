import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_stock_manager/application/core/services/auth_services.dart';
import 'package:top_stock_manager/application/ui/auth/roles/role_add_edit_screen.dart';
import 'package:top_stock_manager/system/configs/theming.dart';

class RolesScreen extends StatefulWidget {
  const RolesScreen({super.key});

  static String route = "/roles";

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
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
                  'Roles Screen'.tr,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                OutlinedButton(
                  onPressed: () {
                    AuthServices.to.selectRole(null);
                    Get.toNamed(RoleAddEditScreen.route);
                  },
                  style: OutlinedButton.styleFrom(
                      foregroundColor: kWhite, backgroundColor: kPrimary),
                  child: Text(
                    'Add Role'.tr,
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
                      label: Text('Name'.tr),
                    ),
                    DataColumn(
                      label: Text('Description'.tr),
                    ),
                    DataColumn(
                      label: Text('Permissions'.tr),
                      numeric: true,
                    ),
                    DataColumn(
                      label: Text(''.tr),
                    ),
                  ],
                  rows: AuthServices.to.roles.map((rol) {
                    return DataRow(
                      cells: [
                        DataCell(Text(rol.name)),
                        DataCell(Text(rol.description ?? '')),
                        DataCell(Text(rol.permissions)),
                        DataCell(
                          SizedBox(
                            width: 200.0,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      //AuthServices.to.role.value = rol.role;
                                      AuthServices.to.selectRole(rol.role);
                                      Get.toNamed(RoleAddEditScreen.route);
                                      // roleAdd(title: rol.role.name);
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
                                      AuthServices.to.deleteRole(rol.role);
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

  roleAdd({String title = "Add a new role"}) {
    final roleAddFormKey = GlobalKey<FormState>();
    late Map<String, dynamic> role = {
      'name': '',
      'description': '',
    };

    if (AuthServices.to.role.value != null) {
      role = {
        'name': AuthServices.to.role.value?.name,
        'description': AuthServices.to.role.value?.description,
      };
    }
    Get.bottomSheet(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Form(
            key: roleAddFormKey,
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
                    initialValue: role['name'],
                    validator: (va) {
                      if (va!.isEmpty) {
                        return "Name must not be empty".tr;
                      } else if (va.length < 3) {
                        return "Length of name must be 3 characters and above";
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      role['name'] = value.toString();
                    },
                    decoration: InputDecoration(
                      hintText: "Name".tr,
                      labelText: "Name".tr,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: role['description'],
                    onSaved: (String? value) {
                      role['description'] = value.toString();
                    },
                    decoration: InputDecoration(
                      hintText: "Role Description".tr,
                      labelText: "Description".tr,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (!roleAddFormKey.currentState!.validate()) {
                          return;
                        }
                        roleAddFormKey.currentState!.save();
                        AuthServices.to.saveRole(role);
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
