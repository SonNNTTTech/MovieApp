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
    return Container(
      padding: const EdgeInsets.all(4),
      decoration:
          const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
      child: CircularPercentIndicator(
        radius: 16,
        lineWidth: 3,
        addAutomaticKeepAlive: false,
        animation: false,
        backgroundColor: Colors.white30,
        percent: rate / 100,
        center: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(rate.toString(),
                style: const TextStyle(fontSize: 10, color: Colors.white)),
            const Text(
              '%',
              style: TextStyle(fontSize: 6, color: Colors.white),
            )
          ],
        ),
        progressColor: _getRateColor(rate),
      ),
    );
  }

  Color _getRateColor(int rate) {
    if (rate >= 70) return Colors.green;
    if (rate >= 30) return Colors.yellowAccent;
    return Colors.redAccent;
  }
}
