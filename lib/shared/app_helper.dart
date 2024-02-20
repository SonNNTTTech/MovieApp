import 'dart:developer';

import 'package:flutter/material.dart';

class AppHelper {
  static void myLog(String message) {
    log('$message haha');
  }
  static void limitLog(String? message, {int limitChar = 200}) {
    if (message == null) {
      myLog('Null message');
    } else {
      myLog(message.length < limitChar - 1
          ? message
          : message.substring(0, limitChar - 1));
    }
  }

  static BuildContext? loadingContext;
}
