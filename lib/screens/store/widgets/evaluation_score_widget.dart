import 'package:flutter/material.dart';
import 'package:kezzle/utils/colors.dart';

class EvaluationScore extends StatelessWidget {
  final String evaluation;
  final int score;

  const EvaluationScore({
    super.key,
    required this.evaluation,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
        bottom: 5,
      ),
      decoration: BoxDecoration(
        color: gray02,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$evaluation ',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: gray05,
            ),
          ),
          Text(
            '$score%',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: coral01,
            ),
          ),
        ],
      ),
    );
  }
}
