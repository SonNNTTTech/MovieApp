import 'package:flutter/material.dart';

class AutoHideKeyboard extends StatelessWidget {
  const AutoHideKeyboard({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    void hideKeyboard() {
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return GestureDetector(
      onTap: hideKeyboard,
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
