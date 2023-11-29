import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_stock_manager/application/core/services/auth_services.dart';
import 'package:top_stock_manager/system/configs/theming.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  static String route = "/users";

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
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
                    'Users Screen'.tr,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      AuthServices.to.user.value = null;
                      userAdd();
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
                        label: Text('Username'.tr),
                      ),
                      DataColumn(
                        label: Text('Role'.tr),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Text(''.tr),
                      ),
                    ],
                    rows: AuthServices.to.users.mapIndexed((i, usr) {
                      return DataRow(
                        cells: [
                          DataCell(Text("${i + 1}")),
                          DataCell(Text(usr.name)),
                          DataCell(Text(usr.username ?? '')),
                          DataCell(Text(usr.role)),
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    AuthServices.to.user.value = usr.user;
                                    userAdd(title: usr.user.name);
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
                                  onPressed: AuthServices.to.isMe(usr)
                                      ? null
                                      : () {
                                          AuthServices.to.deleteUser(usr.user);
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

  userAdd({String title = "Add a new user"}) {
    final userAddFormKey = GlobalKey<FormState>();
    late Map<String, dynamic> user = {
      'name': '',
      'username': '',
      'password': '',
    };

    if (AuthServices.to.user.value != null) {
      user = {
        'name': AuthServices.to.user.value?.name,
        'username': AuthServices.to.user.value?.username,
        'password': '',
      };
    }
    Get.bottomSheet(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Wrap(
          children: [
            Form(
                key: userAddFormKey,
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
                        initialValue: user['name'],
                        validator: (va) {
                          if (va!.isEmpty) {
                            return "Name must not be empty".tr;
                          } else if (va.length < 3) {
                            return "Length of name must be 3 characters and above";
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          user['name'] = value.toString();
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
                        initialValue: user['username'],
                        onSaved: (String? value) {
                          user['username'] = value.toString();
                        },
                        decoration: InputDecoration(
                          hintText: "User identifier".tr,
                          labelText: "Username".tr,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (AuthServices.to.user.value == null)
                        TextFormField(
                          initialValue: user['password'],
                          onSaved: (String? value) {
                            user['password'] = value.toString();
                          },
                          validator: (va) {
                            if (va!.isEmpty) {
                              return "Password must not be empty".tr;
                            } else if (va.length < 4) {
                              return "Length of password must be 4 characters and above";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "User password".tr,
                            labelText: "Password".tr,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      if (AuthServices.to.user.value == null)
                        const SizedBox(
                          height: 10,
                        ),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (!userAddFormKey.currentState!.validate()) {
                              return;
                            }
                            userAddFormKey.currentState!.save();
                            AuthServices.to.saveUser(user);
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
