
import 'package:get/get.dart';
import 'package:menu_bar/menu_bar.dart';
import 'package:top_stock_manager/application/ui/home/home_screen.dart';
import 'package:top_stock_manager/application/ui/splash/splash_screen.dart';
import 'package:top_stock_manager/system/widgets/menu.dart';

class Routes {
  static String home = '/';
  static String login = '/login';
  static String splash = '/splash';


  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: login,
      page: () => WindowMenu(
        child: HomeScreen(),
      ),
    ),

    GetPage(
      name: home,
      page: () => WindowMenu(
        child: HomeScreen(),
      ),
      middlewares: [
        //  AuthMiddleware(),
      ],
    ),






  ];
}
