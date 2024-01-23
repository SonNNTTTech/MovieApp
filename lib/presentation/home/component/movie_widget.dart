// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:test_app/presentation/home/entity/movie_entity.dart';
import 'package:test_app/widget/my_network_image.dart';

class MovieWidget extends StatelessWidget {
  final MovieEntity entity;
  const MovieWidget({
    Key? key,
    required this.entity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 3)]),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 5,
                child: MyNetworkImage(
                  url: entity.imageUrl,
                ),
              ),
              Expanded(
                  child: Center(
                child: Column(
                  children: [
                    Text(entity.name,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Text(DateFormat('MMM dd, yyyy').format(entity.date),
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ))
            ],
          ),
          Positioned.fill(child: LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: constraints.biggest.height * 2 / 7 - 16),
                child: CircularPercentIndicator(
                  radius: 32,
                  lineWidth: 4,
                  percent: entity.rate / 100,
                  center: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entity.rate.toString(),
                          style: const TextStyle(fontSize: 18)),
                      const Text(
                        '%',
                        style: TextStyle(fontSize: 8),
                      )
                    ],
                  ),
                  progressColor: getRateColor(entity.rate),
                ),
              );
            },
          ))
        ],
      ),
    );
  }

  Color getRateColor(int rate) {
    if (rate >= 70) return Colors.green;
    if (rate >= 30) return Colors.yellowAccent;
    return Colors.redAccent;
  }
}
