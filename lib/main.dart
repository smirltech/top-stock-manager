import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:top_stock_manager/application/core/services/auth_services.dart';
import 'package:top_stock_manager/application/database/offline/app_database.dart';
import 'package:top_stock_manager/application/ui/auth/login/login_screen.dart';
import 'package:top_stock_manager/routes.dart';
import 'package:top_stock_manager/system/configs/constants.dart';
import 'package:top_stock_manager/system/configs/theming.dart';
import 'package:top_stock_manager/system/configs/utils.dart';
import 'package:top_stock_manager/system/lang/locales.dart';
import 'package:uuid/uuid.dart';

import 'application/core/services/data_services.dart';

Locale _initLang() {
  var map = GetStorage().read('lang') ??
      {
        'name': 'French',
        'code': 'fr_FR',
      };
  var lb = map['code'].split("_");
  return Locale(lb[0], lb[1]);
}

const uuid = Uuid();

final DB = AppDatabase();
final GetStorage InnerStorage = GetStorage(kInnerStorage);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setFrameSize();
  await GetStorage.init(kInnerStorage);
  await _initServices();
  runApp(MyApp());
}

Future<void> _initServices() async {
  await AuthServices.init();
  await DataServices.init();
}

Future<void> _initControllers() async {}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    _initControllers();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppName,
      translations: Locales(),
      locale: _initLang(),
      fallbackLocale: const Locale('fr', 'FR'),
      theme: ThemeData(
        primarySwatch: kBaseColor,
        primaryColor: kDeepOrange,
        useMaterial3: true,
        /*appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
        ),*/
      ),
      // home: const SplashScreen(),
      // initialRoute: SplashScreen.route,
      initialRoute: LoginScreen.route,
      getPages: Routes.routes,
    );
  }
}
