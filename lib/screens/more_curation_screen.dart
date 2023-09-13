import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kezzle/utils/colors.dart';

class MoreCurationScreen extends StatelessWidget {
  MoreCurationScreen({super.key});

  final int cakeLength = 10;
  final List<double> widthList = [240, 174, 200, 174];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('인기 Top10 케이크')),
      body: MasonryGridView.builder(
          mainAxisSpacing: 23,
          crossAxisSpacing: 5,
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 80, top: 20),
          itemCount: cakeLength,
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            List<String> keywords = ['생일', '파스텔', '초코'];
            return Column(children: [
              Container(
                  width: double.infinity,
                  height: widthList[index % 4],
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(16)),
                  clipBehavior: Clip.hardEdge,
                  child:
                      Image.asset('assets/heart_cake.png', fit: BoxFit.cover)),
              const SizedBox(height: 8),
              SizedBox(
                  height: 23,
                  child: ListView.separated(
                      itemCount: keywords.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: coral04),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              child: Text(keywords[index],
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: coral01))),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 5))),
            ]);
          }),
    );
  }
}
