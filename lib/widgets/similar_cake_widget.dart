import 'package:flutter/material.dart';
import 'package:kezzle/similar_cake.dart';
import 'package:kezzle/utils/colors.dart';

class SimilarCakeWidget extends StatelessWidget {
  final SimilarCake similarCake;
  const SimilarCakeWidget({super.key, required this.similarCake});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.fromLTRB(8, 400, 8, 0),
      // height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [shadow01],
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: Image.asset(
            similarCake.imageUrl,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
