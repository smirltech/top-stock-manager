import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_bar/menu_bar.dart';
import 'package:top_stock_manager/application/core/services/auth_services.dart';
import 'package:top_stock_manager/application/ui/auth/users/users_screen.dart';
import 'package:top_stock_manager/application/ui/home/home_screen.dart';
import 'package:top_stock_manager/application/ui/products/products_screen.dart';
import 'package:window_manager/window_manager.dart';

List<BarButton> _menuBarButtons() {
  return [
    BarButton(
      text: Text(
        'File'.tr,
        style: const TextStyle(color: Colors.white),
      ),
      submenu: SubMenu(
        menuItems: [
          MenuButton(
            onTap: () => Get.toNamed(HomeScreen.route),
            text: Text('Home'.tr),
          ),
          MenuButton(
            onTap: () {
              AuthServices.to.logout();
            },
            text: Text('Logout'.tr),
          ),
          MenuButton(
            text: Text('Database'.tr),
            //icon: const Icon(Icons.settings),
            submenu: SubMenu(
              menuItems: [
                MenuButton(
                  onTap: () {},
                  text: Text('Export to'.tr),
                ),
                MenuButton(
                  onTap: () {},
                  text: Text('Import from'.tr),
                ),
                MenuButton(
                  onTap: () {},
                  text: Text('Backup Offline'.tr),
                ),
                MenuButton(
                  onTap: () {},
                  text: Text('Backup Online'.tr),
                ),
              ],
            ),
          ),
          if (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
            const MenuDivider(),
          if (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
            MenuButton(
              onTap: () {
                WindowManager.instance.close();
              },
              shortcutText: 'Ctrl+Q',
              text: Text('Exit'.tr),
              icon: const Icon(Icons.exit_to_app),
            ),
          if (Platform.isWindows || Platform.isLinux || Platform.isMacOS)
            MenuButton(
              onTap: () {
                AuthServices.to.logout(exit: true);
              },
              shortcutText: 'Ctrl+Shift+Q',
              text: Text('Logout and Exit'.tr),
              icon: const Icon(Icons.exit_to_app),
            ),
        ],
      ),
    ),
    // Products
    BarButton(
      text: Text(
        'Products'.tr,
        style: const TextStyle(color: Colors.white),
      ),
      submenu: SubMenu(
        menuItems: [
          MenuButton(
            onTap: () => Get.toNamed(ProductsScreen.route),
            text: Text('Products'.tr),
          ),
          MenuButton(
            onTap: () {},
            text: Text('Purchases'.tr),
          ),
          MenuButton(
            onTap: () {},
            text: Text('Sales'.tr),
          ),
        ],
      ),
    ),
    // Accounts
    BarButton(
      text: Text(
        'Accounts'.tr,
        style: const TextStyle(color: Colors.white),
      ),
      submenu: SubMenu(
        menuItems: [
          MenuButton(
            onTap: () => Get.toNamed(UsersScreen.route),
            text: Text('Users'.tr),
          ),
          MenuButton(
            onTap: () {},
            text: Text('Roles'.tr),
          ),
        ],
      ),
    ),
    // Partners
    BarButton(
      text: Text(
        'Partners'.tr,
        style: const TextStyle(color: Colors.white),
      ),
      submenu: SubMenu(
        menuItems: [
          MenuButton(
            onTap: () {},
            text: Text('Suppliers'.tr),
          ),
          MenuButton(
            onTap: () {},
            text: Text('Clients'.tr),
          ),
        ],
      ),
    ),
    // Reports
    BarButton(
      text: Text(
        'Reports'.tr,
        style: const TextStyle(color: Colors.white),
      ),
      submenu: SubMenu(
        menuItems: [
          MenuButton(
            onTap: () {},
            text: Text('Sales Reports'.tr),
          ),
          MenuButton(
            onTap: () {},
            text: Text('Purchases Reports'.tr),
          ),
          MenuButton(
            onTap: () {},
            text: Text('Stocks Reports'.tr),
          ),
          MenuButton(
            onTap: () {},
            text: Text('Users Performances'.tr),
          ),
        ],
      ),
    ),
    // System
    BarButton(
      text: Text(
        'System'.tr,
        style: const TextStyle(color: Colors.white),
      ),
      submenu: SubMenu(
        menuItems: [
          MenuButton(
            onTap: () {},
            text: Text('Settings'.tr),
          ),
          MenuButton(
            onTap: () {},
            text: Text('Check Updates'.tr),
          ),
          MenuButton(
            onTap: () {},
            text: Text('Notifications'.tr),
          ),
          MenuButton(
            onTap: () {},
            text: Text('Log'.tr),
          ),
        ],
      ),
    ),

    // Help
    BarButton(
      text: Text(
        'Help'.tr,
        style: const TextStyle(color: Colors.white),
      ),
      submenu: SubMenu(
        menuItems: [
          MenuButton(
            onTap: () {},
            text: Text("What's New".tr),
          ),
          MenuButton(
            onTap: () {},
            text: Text('Contact Support'.tr),
          ),
          MenuButton(
            onTap: () {},
            text: Text('Submit Feedback'.tr),
          ),
          MenuButton(
            onTap: () {},
            text: Text('Help'.tr),
          ),
          MenuButton(
            onTap: () {},
            text: Text('About'.tr),
          ),
        ],
      ),
    ),
  ];
}

class WindowMenu extends StatelessWidget {
  const WindowMenu({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MenuBarWidget(
      barButtons: _menuBarButtons(),
      // Style the menu bar itself. Hover over [MenuStyle] for all the options
      barStyle: const MenuStyle(
        padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 6.0, vertical: 40.0)),
        backgroundColor: MaterialStatePropertyAll(Color(0xFF2b2b2b)),
        maximumSize: MaterialStatePropertyAll(Size(double.infinity, 28.0)),
      ),

      // Style the menu bar buttons. Hover over [ButtonStyle] for all the options
      barButtonStyle: const ButtonStyle(
        padding:
            MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 6.0)),
        minimumSize: MaterialStatePropertyAll(Size(0.0, 32.0)),
      ),

      // Style the menu and submenu buttons. Hover over [ButtonStyle] for all the options
      menuButtonStyle: const ButtonStyle(
        minimumSize: MaterialStatePropertyAll(Size.fromHeight(36.0)),
        padding: MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0)),
      ),

      // Enable or disable the bar
      enabled: true,
      child: child,
    );
  }
}
