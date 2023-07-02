import 'package:flutter/material.dart';
import 'package:kezzle/utils/colors.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: Container(
        width: double.infinity,
        height: 4,
        color: gray02,
      ),
    );
  }
}
