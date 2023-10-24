import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:kezzle/features/analytics/analytics.dart';
import 'package:kezzle/models/similar_cake_model.dart';
import 'package:kezzle/utils/colors.dart';

class SimilarCakeWidget extends ConsumerWidget {
  final SimilarCake similarCake;
  const SimilarCakeWidget({super.key, required this.similarCake});

  // void onTapSimilarCake(BuildContext context, ref) {
  //   print(
  //       '유사 케이크 클릭됨. name: ${similarCake.ownerStoreName},lat: ${similarCake.ownerStoreLatitude}, lng: ${similarCake.ownerStoreLongitude}');

  //   context.push("/detail_cake/${similarCake.id}/${similarCake.ownerStoreId}");

  //   ref.read(analyticsProvider).gaEvent('click_detail_similar_cake', {
  //     'cake_id': similarCake.id,
  //     'cake_store_id': similarCake.ownerStoreId,
  //     'cake_store_name': similarCake.ownerStoreName,
  //     'original_cake_id': widget.originalCake.id,
  //     'original_cake_store_id': widget.originalCake.ownerStoreId,
  //   });
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        // margin: const EdgeInsets.fromLTRB(8, 400, 8, 0),
        // height: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [shadow01],
            color: Colors.white),
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: AspectRatio(
                      aspectRatio: 1,
                      child: CachedNetworkImage(
                          imageUrl: similarCake.image.s3Url
                              .replaceFirst("https", "http"),
                          width: double.infinity,
                          fit: BoxFit.cover))),
              const SizedBox(height: 10),
              Text(similarCake.ownerStoreName,
                  style: TextStyle(
                      color: gray08,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              // 텍스트 넘치면 끝에 ...로
              SizedBox(
                width: double.infinity,
                child: Text(
                    // similarCake.ownerStoreAddress.length > 16
                    //     ? "${similarCake.ownerStoreAddress.substring(0, 16)}..."
                    //     :
                    similarCake.ownerStoreAddress,
                    overflow: TextOverflow.ellipsis,

                    // similarCake.ownerStoreAddress,
                    style: TextStyle(
                        color: gray05,
                        fontSize: 12,
                        fontWeight: FontWeight.w400)),
              ),
            ])));
  }
}
