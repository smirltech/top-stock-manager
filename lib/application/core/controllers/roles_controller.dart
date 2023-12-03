import 'package:drift/drift.dart' as d;
import 'package:get/get.dart';
import 'package:top_stock_manager/main.dart';

import '../../../system/configs/theming.dart';
import '../../database/offline/app_database.dart';
import '../../database/offline/models/role_model.dart';
import '../../database/offline/models/role_permission_model.dart';

class RolesController extends GetxController {
  // ------- static methods ------- //
  static RolesController get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<RolesController>(() async => RolesController());
  }

// ------- ./static methods ------- //
  var role = Rxn<Role>();
  var roleModel = Rxn<RoleModel>();
  var roles = <RoleModel>[].obs;

  var rolePermission = Rxn<RolePermissionModel>();
  var rolePermissions = <RolePermissionModel>[].obs;
  var permissions = <Permission>[].obs;
  var permission = Rxn<Permission>();

  selectRole(Role? role) async {
    this.role.value = role;
    _refreshRolePermissions();
  }

  _refreshRolePermissions() async {
    if (role.value == null) {
      rolePermissions.clear();
      permissions.value = await DB.permissionsDao.getPermissions();
    } else {
      rolePermissions.value =
          await DB.roleHasPermissionsDao.rolePermissionsOfRole(role.value!.id);
      permissions.value = await DB.permissionsDao.getPermissions();
      // log(rolePermissions.value.toString());
    }
  }

  saveRole(Map<String, dynamic> data) async {
    if (role.value == null) {
      int id = await DB.rolesDao.insertRole(data);

      role.value = await DB.rolesDao.getRole(id);
      Get.snackbar('Role'.tr, 'Role added successfully'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      RolesCompanion c = role.value!
          .copyWith(
            name: data['name'],
            description: d.Value(data['description']),
            updatedAt: d.Value(DateTime.now()),
          )
          .toCompanion(true);

      await DB.rolesDao.updateRole(c);
      // Get.back();
      Get.snackbar('Role'.tr, 'Role updated successfully'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
    // role.value = null;
    _refreshRolePermissions();
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
        // user.value = null;
        Get.back();
        Get.snackbar('Role'.tr, 'Role deleted successfully'.tr,
            snackPosition: SnackPosition.BOTTOM);
      },
    );
  }

  // RoleHasPermissions
  saveRoleHasPermission(Map<String, dynamic> data) async {
    if (rolePermission.value == null) {
      data['roleId'] = role.value!.id;
      await DB.roleHasPermissionsDao.insertData(data);
      Get.back();
      Get.snackbar('Permission'.tr, 'Permission added successfully'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      RoleHasPermissionsCompanion c = rolePermission.value!.roleHasPermission
          .copyWith(
            permissionId: data['permissionId'],
            updatedAt: d.Value(DateTime.now()),
          )
          .toCompanion(true);

      await DB.roleHasPermissionsDao.updateData(c);
      Get.back();
      Get.snackbar('Permission'.tr, 'Permission updated successfully'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
    rolePermission.value = null;
    permission.value = null;
    _refreshRolePermissions();
  }

  deleteRoleHasPermission(
    RolePermissionModel perm,
  ) {
    Get.defaultDialog(
      title: "Remove Permission".tr,
      middleText:
          "${"Are you sure you want to remove permission".tr} : \"${perm.permissionDescription}\"",
      textConfirm: "Remove".tr,
      buttonColor: kDanger,
      onConfirm: () {
        DB.roleHasPermissionsDao.deleteData(perm.roleHasPermission);
        // user.value = null;
        Get.back();
        Get.snackbar('Permission'.tr, 'Permission removed successfully'.tr,
            snackPosition: SnackPosition.BOTTOM);
        _refreshRolePermissions();
      },
    );
  }

  @override
  void onReady() {
    DB.rolesDao.watchAllRolesWithPermissions().listen((event) {
      roles.value = event;
      // log(event.toString());
    });

    super.onReady();
  }
}
