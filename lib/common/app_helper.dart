import 'dart:developer';

class AppHelper {
  static void myLog(String message) {
    log('$message haha');
  }

  static isSuccessApi(int statusCode) {
    return statusCode > 199 && statusCode < 300;
  }
}
