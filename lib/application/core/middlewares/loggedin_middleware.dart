import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_stock_manager/application/core/services/auth_services.dart';
import 'package:top_stock_manager/application/ui/auth/login/login_screen.dart';

class LoggedinMiddleware extends GetMiddleware {
  @override
  int? priority = 0;

  LoggedinMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    log('loggedin middleware : ${route!}');
    if (AuthServices.to.isLogin == true) {
      return null;
    } else {
      return RouteSettings(name: LoginScreen.route);
    }
  }
}
