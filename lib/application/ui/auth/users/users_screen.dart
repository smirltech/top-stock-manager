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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Users Screen'.tr,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                OutlinedButton(
                  onPressed: () {
                    AuthServices.to.user.value = null;
                    userAdd();
                  },
                  style: OutlinedButton.styleFrom(
                      foregroundColor: kWhite, backgroundColor: kPrimary),
                  child: Text(
                    'Add User'.tr,
                  ),
                )
              ],
            ),
          ),
          Obx(() {
            return SingleChildScrollView(
              child: Container(
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
                  rows: AuthServices.to.users.map((usr) {
                    return DataRow(
                      cells: [
                        DataCell(Text(usr.name)),
                        DataCell(Text(usr.username ?? '')),
                        DataCell(Text(usr.role)),
                        DataCell(
                          SizedBox(
                            width: 200.0,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      AuthServices.to.user.value = usr.user;
                                      userAdd(title: usr.user.name);
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
                                      AuthServices.to.deleteUser(usr.user);
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

  userAdd({String title = "Add a new user"}) {
    final _userAddFormKey = GlobalKey<FormState>();
    late Map<String, dynamic> _user = {
      'name': '',
      'username': '',
      'password': '',
    };

    if (AuthServices.to.user.value != null) {
      _user = {
        'name': AuthServices.to.user.value?.name,
        'username': AuthServices.to.user.value?.username,
        'password': '',
      };
    }
    Get.bottomSheet(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Form(
            key: _userAddFormKey,
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
                    initialValue: _user['name'],
                    validator: (va) {
                      if (va!.isEmpty) {
                        return "Name must not be empty".tr;
                      } else if (va.length < 3) {
                        return "Length of name must be 3 characters and above";
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _user['name'] = value.toString();
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
                    initialValue: _user['username'],
                    onSaved: (String? value) {
                      _user['username'] = value.toString();
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
                      initialValue: _user['password'],
                      onSaved: (String? value) {
                        _user['password'] = value.toString();
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
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_userAddFormKey.currentState!.validate()) {
                          return;
                        }
                        _userAddFormKey.currentState!.save();
                        AuthServices.to.saveUser(_user);
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
