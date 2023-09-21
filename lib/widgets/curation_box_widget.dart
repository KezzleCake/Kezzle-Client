import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/models/curation_model.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/cakes_repo.dart';
import 'package:kezzle/screens/more_curation_screen.dart';
import 'package:kezzle/utils/colors.dart';

class CurationBoxWidget extends StatelessWidget {
  // final String imageUrl;
  // final String title;
  final CurationCoverModel cover;
  final Color color;

  const CurationBoxWidget({
    super.key,
    // required this.imageUrl,
    // required this.title,
    required this.cover,
    required this.color,
  });

  void onTapCurationBox(BuildContext context) {
    // print('큐레이션 박스 클릭');
    // 함수와 함께 전달
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MoreCurationScreen(
                title: cover.description, fetchCakes: fetchCoverCakes)));
  }

  Future<List<Cake>> fetchCoverCakes(WidgetRef ref) async {
    //케이크 정보 가져오기
    List<Cake> cakes = [];
    final response =
        await ref.read(cakesRepo).fetchCoverCakes(coverId: cover.id);
    if (response != null) {
      // print(response);
      response['cakes'].forEach((cake) {
        cakes.add(Cake.fromJson(cake));
      });
      return cakes;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapCurationBox(context),
      child: Container(
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
            // Image.asset(
            //   imageUrl,
            //   width: 150,
            //   height: 180,
            //   fit: BoxFit.cover,
            // ),
            Image.network(
              // imageUrl.replaceFirst("https", "http"),
              cover.s3url.replaceFirst("https", "http"),

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
                // title,
                cover.description,
                style: TextStyle(
                  color: gray01,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
