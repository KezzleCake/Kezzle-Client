import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kezzle/models/similar_cake_model.dart';
import 'package:kezzle/utils/colors.dart';

class SimilarCakeWidget extends StatelessWidget {
  final SimilarCake similarCake;
  const SimilarCakeWidget({super.key, required this.similarCake});

  void onTapSimilarCake() {
    print(
        '유사 케이크 클릭됨. name: ${similarCake.ownerStoreName},lat: ${similarCake.ownerStoreLatitude}, lng: ${similarCake.ownerStoreLongitude}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapSimilarCake,
      child: Container(
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
            child: CachedNetworkImage(
                imageUrl: similarCake.image.s3Url.replaceFirst("https", "http"),
                width: double.infinity,
                fit: BoxFit.cover),
            // Image.asset(
            //   similarCake.imageUrl,
            //   width: double.infinity,
            //   fit: BoxFit.cover,
            // ),
          ),
        ),
      ),
    );
  }
}
