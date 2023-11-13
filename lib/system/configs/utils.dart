import 'dart:io';

import 'package:flutter/material.dart';
import 'package:top_stock_manager/system/configs/theming.dart';
import 'package:window_manager/window_manager.dart';

import 'constants.dart';

void setFrameSize() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    //logcat("this is not mobile app");
    // await DesktopWindow.setMinWindowSize(Size(750, 650));
    await windowManager.ensureInitialized();

  /*  WindowOptions windowOptions = const WindowOptions(
      // size: Size(700, 600),
      minimumSize:
      Size(kDefaultMinimumDesktopWidth, kDefaultMinimumDesktopHeight),
      *//*maximumSize:
      Size(kDefaultMinimumDesktopWidth, kDefaultMinimumDesktopHeight),*//*
      center: false,
      backgroundColor: kDeepOrange,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );*/
   /* windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });*/
   // windowManager.setAlignment(Alignment.topLeft);
    /*windowManager.setSize(
        const Size(kDefaultMinimumDesktopWidth, kDefaultMinimumDesktopHeight));*/
    //windowManager.setAsFrameless();
    // windowManager.setMovable(true);
  }
}
