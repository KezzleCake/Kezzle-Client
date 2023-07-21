import 'package:flutter/material.dart';
import 'package:kezzle/utils/colors.dart';

class MyRatingBar extends StatelessWidget {
  final double percent;

  const MyRatingBar({
    super.key,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 4,
          width: 6 * MediaQuery.of(context).size.width / 13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: gray03,
          ),
        ),
        Container(
          height: 4,
          width: 6 * MediaQuery.of(context).size.width / 13 * percent,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: orange01,
          ),
        ),
      ],
    );
  }
}
