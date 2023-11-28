import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_stock_manager/application/core/services/auth_services.dart';
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
    if (AuthServices.to.role.value != null) {
      nameEC.text = AuthServices.to.role.value!.name.toString();

      descriptionEC.text = AuthServices.to.role.value!.description.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(() {
        return AuthServices.to.role.value == null
            ? const SizedBox()
            : FloatingActionButton(
                onPressed: () {
                  inputAdd();
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
                          label: Text('Permission'.tr),
                        ),
                        DataColumn(
                          label: Text('Description'.tr),
                        ),
                        DataColumn(
                          label: Text(''.tr),
                        ),
                      ],
                      rows: AuthServices.to.rolePermissions
                          .mapIndexed((i, rolePermission) {
                        return DataRow(cells: [
                          DataCell(Text("${i + 1}")),
                          DataCell(Text("${rolePermission.permissionName}")),
                          DataCell(
                              Text("${rolePermission.permissionDescription}")),
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                //Spacer(),
                                ElevatedButton(
                                  onPressed: null,
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: kWhite,
                                      backgroundColor: kWarning),
                                  child: Text('Edit'.tr),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    AuthServices.to.deleteRoleHasPermission(
                                        rolePermission);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: kWhite,
                                      backgroundColor: kDanger),
                                  child: Text('Delete'.tr),
                                ),
                              ],
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
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

  inputAdd({String title = "Add permission"}) {
    final inputAddFormKey = GlobalKey<FormState>();
    late Map<String, dynamic> rolePerm = {
      'permissionId': null,
    };
    late List<DropdownMenuItem<Permission>> permissionsDrop;

    permissionsDrop = AuthServices.to.permissions
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
                    child: DropdownButtonFormField<Permission>(
                      value: AuthServices.to.permission.value,
                      items: permissionsDrop,
                      onChanged: (Permission? sup) {
                        AuthServices.to.permission.value = sup;
                        rolePerm['permissionId'] =
                            AuthServices.to.permission.value?.id;
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
                    child: ElevatedButton(
                      onPressed: () {
                        if (!inputAddFormKey.currentState!.validate()) {
                          return;
                        }
                        inputAddFormKey.currentState!.save();

                        AuthServices.to.saveRoleHasPermission(rolePerm);
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

/* DataTable(
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
                          rows: AuthServices.to.rolePermissions
                              .mapIndexed((i, rolePermission) {
                            return DataRow(cells: [
                              DataCell(Text("${i + 1}")),
                              DataCell(
                                  Text("${rolePermission.permissionName}")),
                              DataCell(Text(
                                  "${rolePermission.permissionDescription}")),
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
                                          onPressed: () {
                                            AuthServices.to
                                                .deleteRoleHasPermission(
                                                    rolePermission);
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
                            ]);
                          }).toList(),
                        ),*/
