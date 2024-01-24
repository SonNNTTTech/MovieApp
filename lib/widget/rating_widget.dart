import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RatingWidget extends StatelessWidget {
  ///0 -> 100
  final int rate;
  const RatingWidget({
    super.key,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 20,
      lineWidth: 3,
      backgroundColor: Colors.black,
      percent: rate / 100,
      center: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(rate.toString(),
              style: const TextStyle(fontSize: 16, color: Colors.white)),
          const Text(
            '%',
            style: TextStyle(fontSize: 8, color: Colors.white),
          )
        ],
      ),
      progressColor: getRateColor(rate),
    );
  }

  Color getRateColor(int rate) {
    if (rate >= 70) return Colors.green;
    if (rate >= 30) return Colors.yellowAccent;
    return Colors.redAccent;
  }
}
