import 'dart:convert';

import 'package:drift/drift.dart' as d;
import 'package:get/get.dart';
import 'package:top_stock_manager/application/core/controllers/roles_controller.dart';
import 'package:top_stock_manager/application/core/controllers/roles_controller.dart';
import 'package:top_stock_manager/application/database/offline/app_database.dart';
import 'package:top_stock_manager/application/database/offline/models/role_permission_model.dart';
import 'package:top_stock_manager/application/ui/auth/login/login_screen.dart';
import 'package:top_stock_manager/application/ui/home/home_screen.dart';
import 'package:top_stock_manager/main.dart';
import 'package:window_manager/window_manager.dart';

import '../../../system/configs/theming.dart';
import '../../database/offline/models/role_model.dart';
import '../../database/offline/models/user_model.dart';

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

  final _isLogin = false.obs;

  bool get isLogin => _isLogin.value;

  selectUser({UserModel? userModel}) async {
    if (userModel == null) {
      user.value = null;
      RolesController.to.roleModel.value = null;
    } else {
      user.value = userModel!.user;
      RolesController.to.roleModel.value = await userModel.roleModel;
    }
  }

  login(Map<String, dynamic> data) async {
    String username = data['username'];
    String password = data['password'];
    await DB.usersDao.login(username, password).then((value) {
      me.value = value;
      _isLogin.value = true;
      InnerStorage.write('user', jsonEncode(value.user));
      Get.offAndToNamed(HomeScreen.route);

      Get.snackbar('Login'.tr, 'Login successfully'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }).onError((error, stackTrace) {
      _isLogin.value = true;
      Get.defaultDialog(
        title: "Login Failed".tr,
        middleText:
            '${"No user found with those credentials, please try again".tr} !',
        textConfirm: "Ok".tr,
        buttonColor: kDanger,
        onConfirm: () {
          Get.offAndToNamed(LoginScreen.route);
        },
      );
    });
  }

  autoLogin() async {
    if (InnerStorage.hasData("user")) {
      // log('autologin');
      Map<String, dynamic> uusr = jsonDecode(InnerStorage.read("user"));
      String username = uusr['username'];
      String password = uusr['password'];
      await DB.usersDao.login(username, password).then((value) {
        //  log('autologin : done');
        me.value = value;
        _isLogin.value = true;
      }).onError((error, stackTrace) {
        me.value = null;
        _isLogin.value = true;
      });
    } else {
      me.value = null;
      _isLogin.value = true;
    }
  }

  logout({bool exit = false}) {
    if (InnerStorage.hasData("user")) {
      InnerStorage.remove("user");
      me.value = null;
      _isLogin.value = true;
      if (!exit) {
        Get.offAndToNamed(LoginScreen.route);
        Get.snackbar('Logout'.tr, 'Logout successfully'.tr,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        WindowManager.instance.close();
      }
    } else {
      if (!exit) {
        _isLogin.value = true;
        Get.offAndToNamed(LoginScreen.route);
        Get.snackbar('Logout'.tr, 'You were not connected previously'.tr,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        _isLogin.value = true;
        WindowManager.instance.close();
      }
    }
  }

  saveUser(Map<String, dynamic> data) async {
    if (user.value == null) {
      await DB.usersDao.insertUser(data);
      Get.back();
      Get.snackbar('User'.tr, 'User added successfully'.tr,
          snackPosition: SnackPosition.BOTTOM);
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
      Get.snackbar('User'.tr, 'User updated successfully'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
    if (RolesController.to.roleModel.value != null) {
      DB.userHasRolesDao.insertData(data);
    }
    user.value = null;
    RolesController.to.roleModel.value = null;
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
        Get.snackbar('User'.tr, 'User deleted successfully'.tr,
            snackPosition: SnackPosition.BOTTOM);
      },
    );
  }

  isMe(UserModel usr) {
    return me.value!.id == usr.id;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    autoLogin();
  }

  @override
  void onReady() {
    DB.usersDao.watchAllUsers().listen((event) {
      users.value = event;
      // log(event.toString());
    });

    DB.rolesDao.watchAllRolesWithPermissions().listen((event) {
      roles.value = event;
      // log(event.toString());
    });

    super.onReady();
  }
}
