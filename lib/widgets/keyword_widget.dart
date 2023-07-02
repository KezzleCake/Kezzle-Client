import 'package:flutter/material.dart';
import 'package:kezzle/utils/colors.dart';

class KeywordWidget extends StatelessWidget {
  final String text;
  const KeywordWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: coral04,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, color: coral01),
      ),
    );
  }
}
