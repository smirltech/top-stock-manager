import 'dart:convert';
import 'dart:developer';

import 'package:drift/drift.dart' as d;
import 'package:get/get.dart';
import 'package:top_stock_manager/application/database/offline/app_database.dart';
import 'package:top_stock_manager/application/ui/auth/login/login_screen.dart';
import 'package:top_stock_manager/main.dart';
import 'package:window_manager/window_manager.dart';

import '../../../system/configs/theming.dart';
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

  login(Map<String, dynamic> data) async {
    String username = data['username'];
    String password = data['password'];
    await DB.usersDao.login(username, password).then((value) {
      me.value = value;
      InnerStorage.write('user', jsonEncode(value.user));
      Get.offAndToNamed(HomeScreen.route);
      Get.snackbar('Login'.tr, 'Login successfully'.tr);
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
        Get.snackbar('Logout'.tr, 'Logout successfully'.tr);
      } else {
        WindowManager.instance.close();
      }
    } else {
      if (!exit) {
        Get.offAndToNamed(LoginScreen.route);
        Get.snackbar('Logout'.tr, 'You were not connected previously'.tr);
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

  @override
  void onReady() {
    autoLogin();
    DB.usersDao.watchAllUsers().listen((event) {
      users.value = event;
      // log(event.toString());
    });

    super.onReady();
  }
}
