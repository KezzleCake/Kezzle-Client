// import 'package:flutter/material.dart';
// import 'package:kezzle/features/profile/widgets/user_review_widget.dart';
// import 'package:kezzle/features/profile/write_review_screen.dart';

// class ReviewScreen extends StatelessWidget {
//   const ReviewScreen({super.key});

//   void onTapReviewWriteButton(BuildContext context) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => ReviewWriteScreen(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('리뷰'),
//       ),
//       body: DefaultTabController(
//         length: 2,
//         child: Column(
//           children: [
//             const TabBar(
//               splashFactory: NoSplash.splashFactory,
//               labelColor: Colors.black,
//               indicatorSize: TabBarIndicatorSize.tab,
//               indicator: BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(
//                     color: Colors.black,
//                     width: 2,
//                   ),
//                 ),
//               ),
//               tabs: [
//                 Tab(
//                   text: '작성 가능한 리뷰',
//                 ),
//                 Tab(
//                   text: '작성한 리뷰',
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   ListView.builder(
//                     itemCount: 3,
//                     itemBuilder: (context, index) => Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 20,
//                         vertical: 10,
//                       ),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Image.asset(
//                             'assets/heart_cake.png',
//                             fit: BoxFit.cover,
//                             width: 90, //이미지 크기
//                             height: 90,
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           Expanded(
//                             child: Container(
//                               height: 90, //이미지 사이즈와 맞춰줘야함
//                               child: Column(
//                                 children: [
//                                   const Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text('2023/06/02'),
//                                           Text(
//                                             '21케이크',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Text('32,000'),
//                                     ],
//                                   ),
//                                   Expanded(child: Container()),
//                                   Row(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       const Text('픽업일: 금요일, 2023/05/26'),
//                                       Container(
//                                         padding: const EdgeInsets.symmetric(
//                                           horizontal: 10,
//                                           vertical: 5,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           color: Colors.grey[300],
//                                         ),
//                                         child: GestureDetector(
//                                           onTap: () =>
//                                               onTapReviewWriteButton(context),
//                                           child: const Text('리뷰 작성하기'),
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 15,
//                       // vertical: 10,
//                     ),
//                     child: ListView.separated(
//                         separatorBuilder: (context, index) => const SizedBox(
//                               height: 15,
//                             ),
//                         itemCount: 3,
//                         itemBuilder: (context, index) {
//                           return UserReviewWidget();
//                         }),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
