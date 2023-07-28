// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class UserReviewWidget extends StatefulWidget {
//   const UserReviewWidget({
//     super.key,
//   });

//   @override
//   State<UserReviewWidget> createState() => _UserReviewWidgetState();
// }

// class _UserReviewWidgetState extends State<UserReviewWidget> {
//   bool isExpanded = false;

//   void moreText() {
//     setState(() {
//       isExpanded = !isExpanded;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text('[블리스케이크]',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             const SizedBox(width: 5),
//             Expanded(child: Container()),
//             Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                 ),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                 child: Text('삭제'))
//           ],
//         ),
//         const SizedBox(height: 5),
//         Row(
//           children: [
//             RatingBar.builder(
//               ignoreGestures: true,
//               itemSize: 20,
//               initialRating: 3,
//               minRating: 1,
//               direction: Axis.horizontal,
//               allowHalfRating: true,
//               itemCount: 5,
//               itemBuilder: (context, _) => const Icon(
//                 Icons.star,
//                 color: Colors.amber,
//               ),
//               onRatingUpdate: (rating) {
//                 print(rating);
//               },
//             ),
//             Expanded(child: Container()),
//             const Text('2021.09.01', style: TextStyle(fontSize: 14)),
//           ],
//         ),
//         const SizedBox(height: 10),
//         const Image(
//           image: AssetImage('assets/heart_cake.png'),
//         ),
//         const SizedBox(height: 15),
//         Text(
//             '도안대로 너무 예쁘게 케이크 작업 해주셨습니다! 도안에서 이것저것 신경쓸 것이 많았는데 정말 친절하게 응대하며 반영해주셨어요!! 색 또한 어울리는 것으로 추천해주셨는데 덕분에 더욱 예쁘게 나왔습니다. 심지어 케이크도 초코시트가 너무 달지 않아서 맛있게 먹었어요 다음에도 또 제작하고 싶어요 :) ',
//             maxLines: isExpanded ? 100 : 3,
//             overflow: TextOverflow.ellipsis),
//         isExpanded
//             ? Container()
//             : GestureDetector(
//                 onTap: () => moreText(),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       '더보기',
//                       textAlign: TextAlign.end,
//                       style: TextStyle(
//                         color: Color(0xff979797),
//                         fontSize: 14,
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