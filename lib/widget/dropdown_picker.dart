import 'package:flutter/material.dart';

class DropdownPicker<T> extends StatefulWidget {
  final List<T> items;
  final Function(T value)? onPick;
  final int? initialIndex;

  ///if it null, call T.toString()
  final String Function(T value)? textBuilder;

  ///create a dropdown of a list T, can be pick
  const DropdownPicker({
    Key? key,
    required this.items,
    this.onPick,
    this.initialIndex,
    this.textBuilder,
  }) : super(key: key);

  @override
  State<DropdownPicker<T>> createState() => _DropdownPickerState<T>();
}

class _DropdownPickerState<T> extends State<DropdownPicker<T>> {
  late int index;
  @override
  void initState() {
    index = widget.initialIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<T>(
          value: widget.items[index],
          onChanged: (newValue) {
            if (newValue == null) return;
            setState(() {
              index = widget.items.indexOf(newValue);
              widget.onPick?.call(newValue);
            });
          },
          items: widget.items
              .map((item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(widget.textBuilder != null
                        ? widget.textBuilder!(item)
                        : item.toString()),
                  ))
              .toList(),
        )
      ],
    );
  }
}
