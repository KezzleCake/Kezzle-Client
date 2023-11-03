import 'package:flutter/material.dart';
import 'package:kezzle/utils/colors.dart';


class MyDivider extends StatelessWidget {
  double? padding;
  double? height;

  MyDivider({
    super.key,
    this.padding = 30,
    this.height = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        // vertical: 30,
        vertical: padding!,
      ),
      child: Container(
        width: double.infinity,
        // height: 4,
        height: height!,
        color: gray02,
      ),
    );
  }
}
