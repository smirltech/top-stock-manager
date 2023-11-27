import 'package:get/get.dart';
import 'package:top_stock_manager/application/core/middlewares/loggedin_middleware.dart';
import 'package:top_stock_manager/application/ui/auth/login/login_screen.dart';
import 'package:top_stock_manager/application/ui/auth/roles/roles_screen.dart';
import 'package:top_stock_manager/application/ui/clients/clients_screen.dart';
import 'package:top_stock_manager/application/ui/home/home_screen.dart';
import 'package:top_stock_manager/application/ui/products/products_screen.dart';
import 'package:top_stock_manager/application/ui/splash/splash_screen.dart';
import 'package:top_stock_manager/application/ui/suppliers/suppliers_screen.dart';
import 'package:top_stock_manager/system/widgets/menu.dart';

import 'application/core/middlewares/auth_middleware.dart';
import 'application/ui/auth/users/users_screen.dart';
import 'application/ui/purchases/purchase_add_edit_screen.dart';
import 'application/ui/purchases/purchases_screen.dart';
import 'application/ui/sales/sale_add_edit_screen.dart';
import 'application/ui/sales/sales_screen.dart';

class Routes {
  static List<GetPage> routes = [
    GetPage(
      name: SplashScreen.route,
      transitionDuration: const Duration(seconds: 5),
      transition: Transition.fadeIn,
      page: () => const SplashScreen(),
      middlewares: [
        AuthMiddleware(priority: -1),
      ],
    ),
    GetPage(
      name: LoginScreen.route,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: HomeScreen.route,
      page: () => const WindowMenu(
        child: HomeScreen(),
      ),
      middlewares: [
        LoggedinMiddleware(priority: 0),
      ],
    ),
    GetPage(
      name: ProductsScreen.route,
      page: () => const WindowMenu(
        child: ProductsScreen(),
      ),
      middlewares: [
        LoggedinMiddleware(priority: 0),
      ],
    ),
    GetPage(
      name: UsersScreen.route,
      page: () => const WindowMenu(
        child: UsersScreen(),
      ),
      middlewares: [
        LoggedinMiddleware(priority: 0),
      ],
    ),
    GetPage(
      name: RolesScreen.route,
      page: () => const WindowMenu(
        child: RolesScreen(),
      ),
      middlewares: [
        LoggedinMiddleware(priority: 0),
      ],
    ),
    GetPage(
      name: SuppliersScreen.route,
      page: () => const WindowMenu(
        child: SuppliersScreen(),
      ),
      middlewares: [
        LoggedinMiddleware(priority: 0),
      ],
    ),
    GetPage(
      name: ClientsScreen.route,
      page: () => const WindowMenu(
        child: ClientsScreen(),
      ),
      middlewares: [
        LoggedinMiddleware(priority: 0),
      ],
    ),
    GetPage(
      name: PurchasesScreen.route,
      page: () => const WindowMenu(
        child: PurchasesScreen(),
      ),
      middlewares: [
        LoggedinMiddleware(priority: 0),
      ],
    ),
    GetPage(
      name: PurchaseAddEditScreen.route,
      page: () => const WindowMenu(
        child: PurchaseAddEditScreen(),
      ),
      middlewares: [
        LoggedinMiddleware(priority: 0),
      ],
    ),
    GetPage(
      name: SaleAddEditScreen.route,
      page: () => const WindowMenu(
        child: SaleAddEditScreen(),
      ),
      middlewares: [
        LoggedinMiddleware(priority: 0),
      ],
    ),
    GetPage(
      name: SalesScreen.route,
      page: () => const WindowMenu(
        child: SalesScreen(),
      ),
      middlewares: [
        LoggedinMiddleware(priority: 0),
      ],
    ),
  ];
}
