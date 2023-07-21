import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kezzle/screens/store/detail_store_screen.dart';
import 'package:kezzle/screens/more_review_screen.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/widgets/keyword_widget.dart';
import 'package:kezzle/widgets/store_widget.dart';

class DetailCakeScreen extends StatelessWidget {
  final String imageUrl; //케이크 이미지 경로
  final List keywordList = [
    '스마일',
    '케이크',
    '하트',
    '포항항',
    // '크리스마스',
    // '김이한팀',
    // '화이팅',
    // '가나다라마바사',
  ]; //케이크 이미지 키워드
  final List priceList = [10000, 20000, 30000, 40000]; //사이즈별 케이크 평균 가격
  final List reviewUrlList = [
    'assets/heart_cake.png',
    'assets/heart_cake.png',
    'assets/heart_cake.png',
  ];

  DetailCakeScreen({super.key, required this.imageUrl});

  void onTapStore(BuildContext context) {
    print('ddd');
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DetailStoreScreen(),
      ),
    );
  }

  void moreReview(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MoreReviewScreen(),
      ),
    );
  }

  // void onTapOrderButton(BuildContext context) {
  //   print('주문하러가기 버튼 클릭');
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => DetailStoreScreen(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '케이크 상세보기',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              'assets/icons/like=off.svg', //좋아요 off
              width: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // 바운스 되는 게 낫나?
        // physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Image(
              image: AssetImage(imageUrl),
              height: 390,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (var keyword in keywordList)
                              KeywordWidget(text: keyword),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // SizePricedWidget(priceList: priceList),
                  Text(
                    '사이즈 별 평균가',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: gray08,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: gray02,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '미니 (지름 12cm)',
                              style: TextStyle(
                                fontSize: 12,
                                color: gray07,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '1호 (지름 15cm)',
                              style: TextStyle(
                                fontSize: 12,
                                color: gray07,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '2호 (지름 18cm)',
                              style: TextStyle(
                                fontSize: 12,
                                color: gray07,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '3호 (지름 21cm)',
                              style: TextStyle(
                                fontSize: 12,
                                color: gray07,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '30,000',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: orange01,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  ' 원~',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: gray05,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  '30,000',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: orange01,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  ' 원~',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: gray05,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  '40,000',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: orange01,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  ' 원~',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: gray05,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  '50,000',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: orange01,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  ' 원~',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: gray05,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Text(
                        '리뷰',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: gray08,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '10건',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: gray05,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var reviewUrl in reviewUrlList)
                        Container(
                          // 6이 padding값(3개의 패딩)
                          width:
                              (MediaQuery.of(context).size.width - 40 - 3 * 6) /
                                  4,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Image(
                            image: AssetImage(reviewUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      GestureDetector(
                        onTap: () => moreReview(context),
                        child: Stack(
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Image.asset(
                                'assets/heart_cake.png',
                                width: (MediaQuery.of(context).size.width -
                                        40 -
                                        3 * 6) /
                                    4,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: (MediaQuery.of(context).size.width -
                                      40 -
                                      3 * 6) /
                                  4,
                              height: (MediaQuery.of(context).size.width -
                                      40 -
                                      3 * 6) /
                                  4,
                              decoration: BoxDecoration(
                                color: dim01.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                '+ 더보기',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: gray01,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '스토어',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: gray08,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '3건',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: gray05,
                            ),
                          )
                        ],
                      ),
                      // 여기 그냥 나타낼지.. 아니면 클릭해서 나타낼지 고민
                      Row(
                        // mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Text(
                              '거리순',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: coral01,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 6,
                            ),
                            child: Text(
                              '낮은 가격순',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: gray05,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Text(
                              '별점순',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: gray05,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Text(
                              '후기순',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: gray05,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  StoreWidget(
                    onTap: onTapStore,
                  ),
                  const SizedBox(height: 12),
                  StoreWidget(
                    onTap: onTapStore,
                  ),
                  const SizedBox(height: 12),
                  StoreWidget(
                    onTap: onTapStore,
                  ),
                  const SizedBox(height: 12),
                  StoreWidget(
                    onTap: onTapStore,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   notchMargin: 0,
      //   color: Colors.transparent,
      //   elevation: 0,
      //   child: GestureDetector(
      //     onTap: () => onTapOrderButton(context),
      //     child: Container(
      //       alignment: Alignment.center,
      //       // height: 10,
      //       color: Theme.of(context).primaryColor,
      //       child: const Text(
      //         '주문하러가기',
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

// class StoreWidget extends StatelessWidget {
//   final Function onTap;
//   const StoreWidget({
//     super.key,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => onTap(context),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [shadow01],
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const CircleAvatar(
//               backgroundImage: AssetImage('assets/heart_cake.png'),
//               radius: 63 / 2,
//             ),
//             const SizedBox(width: 8),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         '블리스 케이크',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: gray08,
//                         ),
//                       ),
//                       SvgPicture.asset(
//                         'assets/icons/like=on_in.svg',
//                         width: 22,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           FaIcon(
//                             FontAwesomeIcons.solidStar,
//                             size: 14,
//                             color: orange01,
//                           ),
//                           const SizedBox(width: 2),
//                           Text(
//                             '4.5(100+)',
//                             style: TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: gray07,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   // const SizedBox(height: 4),
//                   Text(
//                     '0.3km · 20,000원~40,000원',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: gray05,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     '초코 제누와즈: 가나 슈필링',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: gray06,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   Text(
//                     '바닐라 제누와즈: 버터크림 + 딸기잼필링',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: gray06,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   Text(
//                     '당근케잌(건포도 + 크렌베리 + 호두):크림치즈 필링',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: gray06,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
