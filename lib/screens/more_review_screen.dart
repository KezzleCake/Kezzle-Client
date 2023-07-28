// import 'package:flutter/material.dart';
// import 'package:kezzle/utils/colors.dart';
// import 'package:kezzle/widgets/review_widget.dart';

// class MoreReviewScreen extends StatefulWidget {
//   const MoreReviewScreen({super.key});

//   @override
//   State<MoreReviewScreen> createState() => _MoreReviewScreenState();
// }

// class _MoreReviewScreenState extends State<MoreReviewScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             '리뷰',
//             style: TextStyle(
//               color: gray08,
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 6,
//                       ),
//                       // 이거 위젯으로 뺄까 고민. row 전체로 빼야되나?
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
//                         vertical: 6,
//                       ),
//                       child: Text(
//                         '별점 높은순',
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
//                         vertical: 6,
//                       ),
//                       child: Text(
//                         '별점 낮은순',
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
//                 // 나중에 ListView builder 써야겠당
//                 for (int i = 0; i < 3; i++) ...[
//                   const ReviewWidget(),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                 ],
//                 const SizedBox(
//                   //아래 여백
//                   height: 70,
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
