import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void usePostFrameCallback(Dispose? Function() action, [List<Object?>? keys]) {
  useEffect(
    () {
      var isDisposed = false;
      Dispose? dispose;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!isDisposed) {
          dispose = action();
        }
      });
      return () {
        isDisposed = true;
        dispose?.call();
      };
    },
    keys,
  );
}
