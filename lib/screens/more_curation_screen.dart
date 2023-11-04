import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/widgets/cake_with_keyword_widget.dart';

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
                      left: 30, right: 15, bottom: 80, top: 20),
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


