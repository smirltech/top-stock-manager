import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_stock_manager/application/core/controllers/roles_controller.dart';
import 'package:top_stock_manager/application/database/offline/app_database.dart';
import 'package:top_stock_manager/application/ui/auth/roles/roles_screen.dart';

import '../../../../system/configs/theming.dart';

class RoleAddEditScreen extends StatefulWidget {
  const RoleAddEditScreen({super.key});

  static String route = "/roles/create-edit";

  @override
  State<RoleAddEditScreen> createState() => _RoleAddEditScreenState();
}

class _RoleAddEditScreenState extends State<RoleAddEditScreen> {
  final _roleAddFormKey = GlobalKey<FormState>();
  final TextEditingController nameEC = TextEditingController();

  final TextEditingController descriptionEC = TextEditingController();

  @override
  void initState() {
    if (RolesController.to.role.value != null) {
      nameEC.text = RolesController.to.role.value!.name.toString();

      descriptionEC.text =
          RolesController.to.role.value!.description.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(() {
        return RolesController.to.role.value == null
            ? const SizedBox()
            : FloatingActionButton(
                onPressed: () {
                  permissionAdd();
                },
                tooltip: "Add permission".tr,
                child: const Icon(Icons.add),
              );
      }),
      body: Form(
        key: _roleAddFormKey,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Role Screen'.tr,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            Get.toNamed(RolesScreen.route);
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
                            //  log('save role');
                            if (!_roleAddFormKey.currentState!.validate()) {
                              //  log('failed');
                              return;
                            }
                            _roleAddFormKey.currentState!.save();
                            Map<String, dynamic> role = {
                              'name': nameEC.text,
                              'description': descriptionEC.text,
                            };
                            // log(_purchase.toString());
                            RolesController.to.saveRole(role);
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFormField(
                        controller: nameEC,
                        validator: (va) {
                          if (va!.isEmpty) {
                            return "Name must not be empty".tr;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Name of role".tr,
                          labelText: "Name".tr,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: descriptionEC,
                        decoration: InputDecoration(
                          hintText: "Description of role".tr,
                          labelText: "Description".tr,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  "Permissions".tr,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                            label: Text('Permission'.tr),
                          ),
                          DataColumn(
                            label: Text('Description'.tr),
                          ),
                          DataColumn(
                            label: Text(''.tr),
                          ),
                        ],
                        rows: RolesController.to.rolePermissions
                            .mapIndexed((i, rolePermission) {
                          return DataRow(cells: [
                            DataCell(Text("${i + 1}")),
                            DataCell(Text("${rolePermission.permissionName}")),
                            DataCell(Text(
                                "${rolePermission.permissionDescription}")),
                            DataCell(
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      RolesController.to
                                          .deleteRoleHasPermission(
                                              rolePermission);
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
                          ]);
                        }).toList(),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),

      /*  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Obx(() {
            return Form(
              key: _roleAddFormKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Role Screen'.tr,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                Get.toNamed(RolesScreen.route);
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
                                //  log('save role');
                                if (!_roleAddFormKey.currentState!.validate()) {
                                  //  log('failed');
                                  return;
                                }
                                _roleAddFormKey.currentState!.save();
                                Map<String, dynamic> role = {
                                  'name': nameEC.text,
                                  'description': descriptionEC.text,
                                };
                                // log(_purchase.toString());
                                AuthServices.to.saveRole(role);
                              },
                              style: OutlinedButton.styleFrom(
                                  foregroundColor: kWhite,
                                  backgroundColor: kPrimary),
                              child: Text(
                                'Save Role'.tr,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFormField(
                            controller: nameEC,
                            validator: (va) {
                              if (va!.isEmpty) {
                                return "Name must not be empty".tr;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Name of role".tr,
                              labelText: "Name".tr,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: descriptionEC,
                            decoration: InputDecoration(
                              hintText: "Description of role".tr,
                              labelText: "Description".tr,
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Permissions".tr,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        children: AuthServices.to.rolePermissions
                            .map(
                              (element) => ListTile(),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          })
        ],
      ),*/
    );
  }

  permissionAdd({String title = "Add permission"}) {
    final inputAddFormKey = GlobalKey<FormState>();
    late Map<String, dynamic> rolePerm = {
      'permissionId': null,
    };
    late List<DropdownMenuItem<Permission>> permissionsDrop;

    permissionsDrop = RolesController.to.permissions
        .map(
          (sup) => DropdownMenuItem<Permission>(
            value: sup,
            child: Text(sup.description!),
          ),
        )
        .toList();

    permissionsDrop.insert(
      0,
      const DropdownMenuItem<Permission>(
        value: null,
        child: Text("== SELECT PERMISSION =="),
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
                      child: DropdownButtonFormField<Permission>(
                        value: RolesController.to.permission.value,
                        items: permissionsDrop,
                        onChanged: (Permission? sup) {
                          RolesController.to.permission.value = sup;
                          rolePerm['permissionId'] =
                              RolesController.to.permission.value?.id;
                        },
                        decoration: InputDecoration(
                          hintText: "Permission".tr,
                          labelText: "Permission".tr,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (!inputAddFormKey.currentState!.validate()) {
                            return;
                          }
                          inputAddFormKey.currentState!.save();

                          RolesController.to.saveRoleHasPermission(rolePerm);
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
              ),
            ),
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
