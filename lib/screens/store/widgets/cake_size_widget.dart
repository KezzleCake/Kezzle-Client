import 'package:flutter/material.dart';
import 'package:kezzle/utils/colors.dart';

class CakeSizeWidget extends StatelessWidget {
  final double width;
  final int radius;
  final String sizeName;

  const CakeSizeWidget({
    super.key,
    required this.width,
    required this.radius,
    required this.sizeName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: width,
              height: width,
              decoration: BoxDecoration(
                color: gray01,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: width,
              height: 1,
              decoration: BoxDecoration(
                color: gray04,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: gray01,
              ),
              child: Text(
                '${radius}cm',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: gray05,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          sizeName,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: gray06,
          ),
        ),
      ],
    );
  }
}
