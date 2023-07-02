import 'package:flutter/material.dart';
import 'package:kezzle/utils/colors.dart';

class CurationBoxWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Color color;

  const CurationBoxWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [shadow02],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image.asset(
            imageUrl,
            width: 150,
            height: 180,
            fit: BoxFit.cover,
          ),
          Container(
            width: 150,
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  // Color(0xffFFB8B8).withAlpha(0),
                  // Color(0xffFFB8B8),
                  color.withAlpha(0),
                  color,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              bottom: 20,
            ),
            child: Text(
              // '일년에 하나 뿐인\n생일을 축하하며',
              title,
              style: TextStyle(
                color: gray01,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
