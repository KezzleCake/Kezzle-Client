// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:kezzle/screens/store/widgets/evaluation_score_widget.dart';
// import 'package:kezzle/screens/store/widgets/my_rating_bar_widget.dart';
// import 'package:kezzle/utils/colors.dart';
// import 'package:kezzle/widgets/my_divider_widget.dart';
// import 'package:kezzle/widgets/review_widget.dart';

// class StoreReview extends StatelessWidget {
//   final double horizontalPadding = 20.0;

//   final List reviewUrlList = [
//     'assets/heart_cake.png',
//     'assets/heart_cake.png',
//     'assets/heart_cake.png',
//   ];

//   StoreReview({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(
//             height: 30,
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       '스토어 후기',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: gray08,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       '20명 참여',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: gray05,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 const Wrap(
//                   spacing: 8,
//                   runSpacing: 12,
//                   children: [
//                     EvaluationScore(
//                       evaluation: '맛있어요',
//                       score: 90,
//                     ),
//                     EvaluationScore(
//                       evaluation: '구현을 잘해줘요',
//                       score: 78,
//                     ),
//                     EvaluationScore(
//                       evaluation: '친절해요',
//                       score: 70,
//                     ),
//                     EvaluationScore(
//                       evaluation: '재료가 신선해요',
//                       score: 90,
//                     ),
//                     EvaluationScore(
//                       evaluation: '포장이 깔끔해요',
//                       score: 90,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const MyDivider(),
//           Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: horizontalPadding,
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           '4.0',
//                           style: TextStyle(
//                               fontSize: 26,
//                               fontWeight: FontWeight.w800,
//                               color: gray07),
//                         ),
//                         const SizedBox(
//                           height: 3,
//                         ),
//                         RatingBar.builder(
//                           unratedColor: gray03,
//                           ignoreGestures: true,
//                           itemSize: 20,
//                           initialRating: 3,
//                           minRating: 1,
//                           direction: Axis.horizontal,
//                           allowHalfRating: true,
//                           itemCount: 5,
//                           itemBuilder: (context, _) => FaIcon(
//                             FontAwesomeIcons.solidStar,
//                             size: 14,
//                             color: orange01,
//                           ),
//                           onRatingUpdate: (rating) {
//                             print(rating);
//                           },
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       width: 20,
//                     ),
//                     Expanded(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 '5점',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: gray05,
//                                 ),
//                               ),
//                               Text(
//                                 '4점',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: gray05,
//                                 ),
//                               ),
//                               Text(
//                                 '3점',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: gray05,
//                                 ),
//                               ),
//                               Text(
//                                 '2점',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: gray05,
//                                 ),
//                               ),
//                               Text(
//                                 '1점',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: gray05,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           const SizedBox(
//                             height: 85,
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 MyRatingBar(
//                                   percent: 0.8,
//                                 ),
//                                 MyRatingBar(percent: 0.6),
//                                 MyRatingBar(percent: 0.3),
//                                 MyRatingBar(percent: 0.2),
//                                 MyRatingBar(percent: 0.1),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 '17',
//                                 style: TextStyle(
//                                   color: orange01,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Text(
//                                 '6',
//                                 style: TextStyle(
//                                   color: orange01,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Text(
//                                 '5',
//                                 style: TextStyle(
//                                   color: orange01,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Text(
//                                 '4',
//                                 style: TextStyle(
//                                   color: orange01,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Text(
//                                 '1',
//                                 style: TextStyle(
//                                   color: orange01,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       '리뷰',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: gray08,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 6,
//                     ),
//                     Text(
//                       '10건',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: gray05,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     for (var reviewUrl in reviewUrlList)
//                       Container(
//                         // 6이 padding값(3개의 패딩)
//                         width:
//                             (MediaQuery.of(context).size.width - 40 - 3 * 6) /
//                                 4,
//                         clipBehavior: Clip.hardEdge,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: Image(
//                           image: AssetImage(reviewUrl),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     GestureDetector(
//                       onTap: () => {},
//                       child: Stack(
//                         children: [
//                           Container(
//                             clipBehavior: Clip.hardEdge,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: Image.asset(
//                               'assets/heart_cake.png',
//                               width: (MediaQuery.of(context).size.width -
//                                       horizontalPadding * 2 -
//                                       3 * 6) /
//                                   4,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.center,
//                             width: (MediaQuery.of(context).size.width -
//                                     40 -
//                                     3 * 6) /
//                                 4,
//                             height: (MediaQuery.of(context).size.width -
//                                     40 -
//                                     3 * 6) /
//                                 4,
//                             decoration: BoxDecoration(
//                               color: dim01.withOpacity(0.7),
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             child: Text(
//                               '+ 더보기',
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w500,
//                                 color: gray01,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 Row(
//                   // mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                       ),
//                       child: Text(
//                         '최신순',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w700,
//                           color: coral01,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                       ),
//                       child: Text(
//                         '별점 높은 순',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: gray05,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                       ),
//                       child: Text(
//                         '별점 낮은 순',
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: gray05,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const ReviewWidget(),
//                 //아래 잘 보이게 여백. 이것도 다 맞춰야 될 듯..
//                 const SizedBox(
//                   height: 100,
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
