import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_stock_manager/application/core/services/auth_services.dart';
import 'package:top_stock_manager/application/ui/auth/login/login_screen.dart';
import 'package:top_stock_manager/application/ui/home/home_screen.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? priority = 0;

  AuthMiddleware({required this.priority});

  @override
  RouteSettings redirect(String? route) {
    log('auth middleware : ${route!}');
    if (AuthServices.to.isLogin == true) {
      return RouteSettings(name: HomeScreen.route);
    } else {
      return RouteSettings(name: LoginScreen.route);
    }
  }
}
