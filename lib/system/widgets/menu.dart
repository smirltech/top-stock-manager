import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:menu_bar/menu_bar.dart';

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
            onTap: () {},
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
          const MenuDivider(),
          MenuButton(
            onTap: () {},
            shortcutText: 'Ctrl+Q',
            text: const Text('Exit'),
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
            onTap: () {},
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
            onTap: () {},
            text: Text('Users'.tr),
            shortcutText: 'Ctrl+Shift+U',
            shortcut:
                const SingleActivator(LogicalKeyboardKey.keyU, control: true),
          ),
          MenuButton(
            onTap: () {},
            text: Text('Roles'.tr),
            shortcutText: 'Ctrl+Shift+R',
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
        padding: MaterialStatePropertyAll(EdgeInsets.zero),
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
