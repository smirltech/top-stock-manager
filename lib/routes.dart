import 'package:get/get.dart';
import 'package:top_stock_manager/application/ui/auth/login/login_screen.dart';
import 'package:top_stock_manager/application/ui/home/home_screen.dart';
import 'package:top_stock_manager/application/ui/products/products_screen.dart';
import 'package:top_stock_manager/application/ui/splash/splash_screen.dart';
import 'package:top_stock_manager/system/widgets/menu.dart';

import 'application/ui/auth/users/users_screen.dart';

class Routes {
  static List<GetPage> routes = [
    GetPage(
      name: SplashScreen.route,
      page: () => const SplashScreen(),
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
        //  AuthMiddleware(),
      ],
    ),
    GetPage(
      name: ProductsScreen.route,
      page: () => const WindowMenu(
        child: ProductsScreen(),
      ),
      middlewares: [
        //  AuthMiddleware(),
      ],
    ),
    GetPage(
      name: UsersScreen.route,
      page: () => const WindowMenu(
        child: UsersScreen(),
      ),
      middlewares: [
        //  AuthMiddleware(),
      ],
    ),
  ];
}
