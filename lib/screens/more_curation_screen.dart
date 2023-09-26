import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/serch_similar_cake/search_similar_cake_screen.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/utils/colors.dart';

class MoreCurationScreen extends ConsumerWidget {
  static const routeName = '/more_curation_screen';

  MoreCurationScreen(
      {super.key,
      required this.title,
      required this.fetchCakes,
      this.initailCakes});

  final String title;
  final Function? fetchCakes;

  // final int cakeLength = 10;
  final List<double> widthList = [240, 174, 200, 174];
  List<Cake>? initailCakes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          title: Text(title
              .replaceAll(RegExp('\n'), ' ')
              .replaceAll(RegExp('  '), ' '))),
      body: FutureBuilder<List<dynamic>>(
          future: fetchCakes == null
              ? Future.wait([])
              : Future.wait([fetchCakes!(ref)]),
          builder: (context, data) {
            if (data.hasData) {
              final List<Cake> cakes = initailCakes ?? data.data![0];

              return MasonryGridView.builder(
                  mainAxisSpacing: 23,
                  crossAxisSpacing: 5,
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, bottom: 80, top: 20),
                  // itemCount: cakeLength,
                  itemCount: cakes.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    // List<String> keywords = ['생일', '파스텔', '초코'];
                    return CakeKeywordWidget(
                        width: widthList[index % 4], cake: cakes[index]);
                  });
            } else if (data.connectionState == ConnectionState.waiting) {
              return Scaffold(
                  body:
                      Center(child: CircularProgressIndicator(color: coral01)));
            } else {
              return const Scaffold(body: Center(child: Text('오류가 발생했습니다.')));
            }
          }),
    );
  }
}

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

    return Column(children: [
      GestureDetector(
        onTap: onTapCake,
        child: Container(
            width: double.infinity,
            // width: width,
            // height: widthList[index % 4],
            height: width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
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
      cake.hashtag.isEmpty
          ? const SizedBox()
          : SizedBox(
              height: 26,
              child: ListView.separated(
                  shrinkWrap: true,
                  // itemCount: keywords.length,
                  // itemCount: cakes[index].hashtag.length,
                  itemCount: cake.hashtag.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, tagIndex) {
                    return Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: coral04),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          child: Text(
                              // cakes[index].hashtag[tagIndex],
                              cake.hashtag[tagIndex],
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: coral01))),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 5))),
    ]);
  }
}
