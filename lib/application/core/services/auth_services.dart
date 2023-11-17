import 'dart:convert';
import 'dart:developer';

import 'package:drift/drift.dart' as d;
import 'package:get/get.dart';
import 'package:top_stock_manager/application/database/offline/app_database.dart';
import 'package:top_stock_manager/application/ui/auth/login/login_screen.dart';
import 'package:top_stock_manager/main.dart';
import 'package:window_manager/window_manager.dart';

import '../../../system/configs/theming.dart';
import '../../database/offline/models/role_model.dart';
import '../../database/offline/models/user_model.dart';
import '../../ui/home/home_screen.dart';

class AuthServices extends GetxService {
  // ------- static methods ------- //
  static AuthServices get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<AuthServices>(() async => AuthServices());
  }

// ------- ./static methods ------- //
  var me = Rxn<UserModel>();
  var user = Rxn<User>();
  var users = <UserModel>[].obs;

  var role = Rxn<Role>();
  var roles = <RoleModel>[].obs;

  login(Map<String, dynamic> data) async {
    String username = data['username'];
    String password = data['password'];
    await DB.usersDao.login(username, password).then((value) {
      me.value = value;
      InnerStorage.write('user', jsonEncode(value.user));
      Get.offAndToNamed(HomeScreen.route);
      Get.snackbar('Login'.tr, 'Login successfully'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }).catchError((err) {
      Get.defaultDialog(
        title: "Login Failed".tr,
        middleText:
            '${"No user found with those credentials, please try again".tr} !',
        textConfirm: "Ok".tr,
        buttonColor: kDanger,
        onConfirm: () {
          Get.back();
        },
      );
    });
  }

  autoLogin() {
    if (InnerStorage.hasData("user")) {
      Map<String, dynamic> uusr = jsonDecode(InnerStorage.read("user"));
      log(uusr.toString());
      login(uusr);
    } else {
      log("no user saved");
    }
  }

  logout({bool exit = false}) {
    if (InnerStorage.hasData("user")) {
      InnerStorage.remove("user");
      me.value = null;
      if (!exit) {
        Get.offAndToNamed(LoginScreen.route);
        Get.snackbar('Logout'.tr, 'Logout successfully'.tr,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        WindowManager.instance.close();
      }
    } else {
      if (!exit) {
        Get.offAndToNamed(LoginScreen.route);
        Get.snackbar('Logout'.tr, 'You were not connected previously'.tr,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        WindowManager.instance.close();
      }
    }
  }

  saveUser(Map<String, dynamic> data) async {
    if (user.value == null) {
      await DB.usersDao.insertUser(data);
      Get.back();
      Get.snackbar('User'.tr, 'User added successfully'.tr);
    } else {
      UsersCompanion c = user.value!
          .copyWith(
            name: data['name'],
            username: data['username'],
            updatedAt: d.Value(DateTime.now()),
          )
          .toCompanion(true);

      await DB.usersDao.updateUser(c);
      Get.back();
      Get.snackbar('User'.tr, 'User updated successfully'.tr);
    }
    user.value = null;
  }

  deleteUser(User usr) {
    Get.defaultDialog(
      title: "Delete User".tr,
      middleText:
          "${"Are you sure you want to delete user".tr} : \"${usr.name}\"",
      textConfirm: "Delete".tr,
      buttonColor: kDanger,
      onConfirm: () {
        DB.usersDao.deleteUser(usr);
        user.value = null;
        Get.back();
        Get.snackbar('User'.tr, 'User deleted successfully'.tr);
      },
    );
  }

  saveRole(Map<String, dynamic> data) async {
    if (role.value == null) {
      await DB.rolesDao.insertRole(data);
      Get.back();
      Get.snackbar('Role'.tr, 'Role added successfully'.tr);
    } else {
      RolesCompanion c = role.value!
          .copyWith(
            name: data['name'],
            description: d.Value(data['description']),
            updatedAt: d.Value(DateTime.now()),
          )
          .toCompanion(true);

      await DB.rolesDao.updateRole(c);
      Get.back();
      Get.snackbar('Role'.tr, 'Role updated successfully'.tr);
    }
    role.value = null;
  }

  deleteRole(Role rol) {
    Get.defaultDialog(
      title: "Delete Role".tr,
      middleText:
          "${"Are you sure you want to delete role".tr} : \"${rol.name}\"",
      textConfirm: "Delete".tr,
      buttonColor: kDanger,
      onConfirm: () {
        DB.rolesDao.deleteRole(rol);
        user.value = null;
        Get.back();
        Get.snackbar('Role'.tr, 'Role deleted successfully'.tr);
      },
    );
  }

  isMe(UserModel usr) {
    return me.value!.id == usr.id;
  }

  @override
  void onReady() {
    autoLogin();
    DB.usersDao.watchAllUsers().listen((event) {
      users.value = event;
      // log(event.toString());
    });

    DB.rolesDao.watchAllRoles().listen((event) {
      roles.value = event;
      // log(event.toString());
    });

    super.onReady();
  }
}
