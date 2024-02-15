

import 'package:flutter/material.dart';

class PreventLoadOverlapFlag {
  static bool isLoading = false;
  static Future<void> turnOn(Future Function() task) async {
    isLoading = true;
    await task.call();
    isLoading = false;
  }
}

ScrollController getScrollController(Future Function() getNewPage) {
  var scrollController = ScrollController();
  scrollController.addListener(() {
    if (scrollController.offset >
            (scrollController.position.maxScrollExtent * 0.95) &&
        !PreventLoadOverlapFlag.isLoading) {
      PreventLoadOverlapFlag.turnOn(getNewPage);
    }
  });
  return scrollController;
}
