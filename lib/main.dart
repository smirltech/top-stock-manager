import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:top_stock_manager/routes.dart';
import 'package:top_stock_manager/system/configs/constants.dart';
import 'package:top_stock_manager/system/configs/theming.dart';
import 'package:top_stock_manager/system/configs/utils.dart';
import 'package:top_stock_manager/system/lang/locales.dart';
import 'package:uuid/uuid.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setFrameSize();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
        ),
      ),
      // home: const SplashScreen(),
      initialRoute: Routes.splash,
      getPages: Routes.routes,
    );
  }
}
