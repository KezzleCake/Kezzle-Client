import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/analytics/analytics.dart';
import 'package:kezzle/models/detail_store_model.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/view_models/store_view_model.dart';

class StoreWidget extends ConsumerWidget {
  // final Function onTap;
  final DetailStoreModel storeData;
  const StoreWidget({
    super.key,
    required this.storeData,
  });

  void onTapLikes(bool initialLike, WidgetRef ref) async {
    if (ref.read(storeProvider(storeData.id)) == null) {
      ref.read(storeProvider(storeData.id).notifier).init(initialLike);
    }
    ref.read(storeProvider(storeData.id).notifier).toggleLike();
    // ref.read(storeProvider(storeData.id).notifier).toggleLike(
    // /*widget.storeData*/);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
        onTap: () {
          // 케이크 상세보기에서 스토어 위젯 클릭 로깅
          ref.read(analyticsProvider).gaEvent('click_taste_store_widget', {
            'store_id': storeData.id,
            'store_name': storeData.name,
            'store_taste': storeData.taste.join(', '),
          });
          // print('스토어 상세보기 페이지로 이동');
          context.push("/detail_store/${storeData.id}");
        },
        child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [shadow01],
            ),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: gray03, width: 1),
                ),
                child: CircleAvatar(
                  backgroundColor: coral04,
                  radius: 63 / 2,
                  foregroundImage: NetworkImage(storeData.logo != null
                      ? storeData.logo!.s3Url.replaceFirst("https", "http")
                      : ''),
                  onForegroundImageError: (exception, stackTrace) =>
                      const SizedBox(),
                ),
              ),
              // CircleAvatar(
              //   foregroundImage: NetworkImage(storeData.logo == null
              //       ? ''
              //       : storeData.logo!.s3Url.replaceFirst("https", "http")),
              //   // backgroundImage: AssetImage('assets/heart_cake.png'),
              //   radius: 63 / 2,
              //   onForegroundImageError: (exception, stackTrace) {},
              // ),
              const SizedBox(width: 8),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(storeData.name,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: gray08)),
                          GestureDetector(
                            onTap: () => onTapLikes(storeData.isLiked, ref),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SvgPicture.asset(
                                  ref.watch(storeProvider(storeData.id)) ??
                                          storeData.isLiked
                                      ? 'assets/icons/like=on_in.svg'
                                      : 'assets/icons/like=off_in.svg',
                                  // ref.watch(storeProvider(storeData.id)).when(
                                  //       data: (data) {
                                  //         if (data == true) {
                                  //           return 'assets/icons/like=on_in.svg';
                                  //         } else {
                                  //           return 'assets/icons/like=off_in.svg';
                                  //         }
                                  //       },
                                  //       loading: () =>
                                  //           'assets/icons/like=off_in.svg',
                                  //       error: (err, stack) =>
                                  //           'assets/icons/like=off_in.svg',
                                  //     ),
                                  width: 22),
                            ),
                          ),
                        ]),
                    // const SizedBox(height: 4),
                    Text(storeData.address, // '서울특별시 강남구 역삼동 123-45',
                        style: TextStyle(
                            fontSize: 12,
                            color: gray06,
                            fontWeight: FontWeight.w400)),
                    // Row(
                    //   children: [
                    //     FaIcon(
                    //       FontAwesomeIcons.solidStar,
                    //       size: 14,
                    //       color: orange01,
                    //     ),
                    //     const SizedBox(width: 2),
                    //     Text(
                    //       '4.5(100+)',
                    //       style: TextStyle(
                    //         fontSize: 12,
                    //         fontWeight: FontWeight.w600,
                    //         color: gray07,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 4),
                    // Text('${(storeData.distance / 1000).toStringAsFixed(1)}km',
                    //     // '0.3km · 20,000원~40,000원',
                    //     style: TextStyle(
                    //         fontSize: 12,
                    //         color: gray05,
                    //         fontWeight: FontWeight.w400)),
                    const SizedBox(height: 8),
                    for (int i = 0; i < storeData.taste.length; i++)
                      Text(
                        storeData.taste[i],
                        style: TextStyle(
                          fontSize: 12,
                          color: gray06,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    // Text(storeData.taste[0],
                    //     style: TextStyle(
                    //       fontSize: 12,
                    //       color: gray06,
                    //       fontWeight: FontWeight.w400,
                    //     )),
                    // Text(storeData.taste[1],
                    //     style: TextStyle(
                    //         fontSize: 12,
                    //         color: gray06,
                    //         fontWeight: FontWeight.w400)),
                    // Text(storeData.taste[2],
                    //     style: TextStyle(
                    //         fontSize: 12,
                    //         color: gray06,
                    //         fontWeight: FontWeight.w400)),
                  ])),
            ])));
  }
}
