import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:top_stock_manager/application/ui/auth/login/login_screen.dart';

import '../../../system/configs/constants.dart';
import '../../../system/configs/theming.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String route = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  Future<Timer> _startTimer() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, () {
      Get.offNamed(LoginScreen.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Icon(
              Icons.account_balance_wallet_outlined,
              size: 100,
              color: kWhite,
            ),
            Spacer(),
            Text(
              kAppName,
              style: TextStyle(color: kWhite),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
