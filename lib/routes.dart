import 'package:get/get.dart';
import 'package:top_stock_manager/application/ui/home/home_screen.dart';
import 'package:top_stock_manager/application/ui/products/products_screen.dart';
import 'package:top_stock_manager/application/ui/splash/splash_screen.dart';
import 'package:top_stock_manager/system/widgets/menu.dart';

class Routes {
  static String login = '/login';

  static List<GetPage> routes = [
    GetPage(
      name: SplashScreen.route,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: login,
      page: () => const WindowMenu(
        child: HomeScreen(),
      ),
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
  ];
}
