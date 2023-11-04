import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/serch_similar_cake/search_similar_cake_screen.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/utils/colors.dart';

class CakeKeywordWidget extends StatelessWidget {
  const CakeKeywordWidget({
    super.key,
    required this.width,
    required this.cake,
  });

  final double width;
  final Cake cake;

  @override
  Widget build(BuildContext context) {
    void onTapCake() {
      // print('유사케이크 검색');
      context.pushNamed(SearchSimilarCakeScreen.routeName, extra: cake);
    }

    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTapCake,
            child: Container(
                width: double.infinity,
                // width: width,
                // height: widthList[index % 4],
                height: width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16)),
                clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(
                    imageUrl:
                        // cakes[index].image.s3Url.replaceFirst("https", "http"),
                        cake.image.s3Url.replaceFirst("https", "http"),
                    fit: BoxFit.cover)),
          ),
          // Image.asset('assets/heart_cake.png',
          //     fit: BoxFit.cover)),
          const SizedBox(height: 8),
          // cakes[index].hashtag.isEmpty
          cake.hashtag!.isEmpty
              ? const SizedBox()
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (var tagIndex = 0;
                          tagIndex < cake.hashtag!.length;
                          tagIndex++) ...[
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: coral04),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              child: Text(
                                  // cakes[index].hashtag[tagIndex],
                                  cake.hashtag![tagIndex].replaceAll('\n', ' '),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: coral01))),
                        ),
                        const SizedBox(width: 5),
                      ]
                    ],
                  ),
                )

          // ListView.separated(
          //     shrinkWrap: true,
          //     // itemCount: keywords.length,
          //     // itemCount: cakes[index].hashtag.length,
          //     itemCount: cake.hashtag!.length,
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, tagIndex) {
          //       return Container(
          //         clipBehavior: Clip.hardEdge,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(16),
          //             color: coral04),
          //         child: Padding(
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 10, vertical: 4),
          //             child: Text(
          //                 // cakes[index].hashtag[tagIndex],
          //                 cake.hashtag![tagIndex],
          //                 style: TextStyle(
          //                     fontSize: 12,
          //                     fontWeight: FontWeight.w500,
          //                     color: coral01))),
          //       );
          //     },
          //     separatorBuilder: (context, index) =>
          //         const SizedBox(width: 5)),
        ]);
  }
}
