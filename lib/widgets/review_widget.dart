// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:kezzle/utils/colors.dart';

// class ReviewWidget extends StatefulWidget {
//   const ReviewWidget({
//     super.key,
//   });

//   @override
//   State<ReviewWidget> createState() => _ReviewWidgetState();
// }

// class _ReviewWidgetState extends State<ReviewWidget> {
//   bool isExpanded = false;

//   void moreText() {
//     setState(() {
//       isExpanded = !isExpanded;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       // mainAxisSize: MainAxisSize.min,
//       // crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '[블리스케이크]',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: gray08,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 RatingBar.builder(
//                   unratedColor: gray03,
//                   ignoreGestures: true,
//                   itemSize: 14,
//                   initialRating: 3,
//                   minRating: 1,
//                   direction: Axis.horizontal,
//                   allowHalfRating: true,
//                   itemCount: 5,
//                   itemBuilder: (context, _) => FaIcon(
//                     FontAwesomeIcons.solidStar,
//                     size: 14,
//                     color: orange01,
//                   ),
//                   onRatingUpdate: (rating) {
//                     print(rating);
//                   },
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'clscls**',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: gray05,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   '2021.09.01',
//                   style: TextStyle(
//                       fontSize: 12, color: gray05, fontWeight: FontWeight.w400),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   '신고하기',
//                   style: TextStyle(
//                     color: gray05,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Container(
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             color: gray01,
//           ),
//           clipBehavior: Clip.hardEdge,
//           child: const AspectRatio(
//             aspectRatio: 1,
//             child: Image(
//               image: AssetImage('assets/heart_cake.png'),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         const SizedBox(height: 12),
//         // RichText(
//         //   // maxLines: 3,
//         //   text: TextSpan(
//         //     semanticsLabel: '...',
//         //     text:
//         //         '도안대로 너무 예쁘게 케이크 작업 해주셨습니다! 도안에서 이것저것 신경쓸 것이 많았는데 정말 친절하게 응대하며 반영해주셨어요!! 색 또한 어울리는 것으로 추천해주셨는데 덕분에 더욱 예쁘게 나왔습니다. 심지어 케이크도 초코시트가 너무 달지 않아서 맛있게 먹었어요 다음에도 또 제작하고 싶어요 :) ',
//         //     style: TextStyle(
//         //       fontSize: 12,
//         //       color: gray07,
//         //       fontWeight: FontWeight.w400,
//         //     ),
//         //     children: [
//         //       const TextSpan(
//         //         text: '...',
//         //         style: TextStyle(color: Colors.blue),
//         //       ),
//         //       const TextSpan(
//         //         text: '자세히 보기',
//         //         style: TextStyle(color: Colors.blue),
//         //       ),
//         //     ],
//         //   ),
//         // ),
//         Text(
//           '도안대로 너무 예쁘게 케이크 작업 해주셨습니다! 도안에서 이것저것 신경쓸 것이 많았는데 정말 친절하게 응대하며 반영해주셨어요!! 색 또한 어울리는 것으로 추천해주셨는데 덕분에 더욱 예쁘게 나왔습니다. 심지어 케이크도 초코시트가 너무 달지 않아서 맛있게 먹었어요 다음에도 또 제작하고 싶어요 :) ',
//           maxLines: isExpanded ? 100 : 3,
//           overflow: TextOverflow.ellipsis,
//           style: TextStyle(
//             fontSize: 12,
//             color: gray07,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         isExpanded
//             ? Container()
//             : GestureDetector(
//                 onTap: () => moreText(),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       '자세히 보기', //RichText 사용해보면 좋겠다.
//                       textAlign: TextAlign.end,
//                       style: TextStyle(
//                         color: gray04,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//       ],
//     );
//   }
// }
// //더보기 클릭하면 모든 텍스트 다 보이도록
