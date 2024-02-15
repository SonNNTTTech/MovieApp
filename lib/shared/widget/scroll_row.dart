import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ScrollRow extends HookWidget {
  final List<Widget> children;
  final double height;
  const ScrollRow({
    super.key,
    required this.children,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    return SizedBox(
      height: height,
      child: Scrollbar(
          controller: controller,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            controller: controller,
            itemCount: children.length,
            itemBuilder: (context, index) => children[index],
            separatorBuilder: (context, index) => const SizedBox(
              width: 12,
            ),
          )),
    );
  }
}
