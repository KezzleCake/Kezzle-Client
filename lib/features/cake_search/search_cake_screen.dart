// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:kezzle/features/cake_search/widgets/keyword_widget.dart';
// import 'package:kezzle/utils/colors.dart';
// import 'package:kezzle/widgets/my_divider_widget.dart';

// class SearchCakeScreen extends StatefulWidget {
//   final String newKeyword;
//   const SearchCakeScreen({
//     super.key,
//     required this.newKeyword,
//   });

//   @override
//   State<SearchCakeScreen> createState() => _SearchCakeScreenState();
// }

// class _SearchCakeScreenState extends State<SearchCakeScreen> {
//   final TextEditingController _textEditingController = TextEditingController();
//   final List recentKeyword = [
//     // 최근 검색 키워드 리스트
//     '스마일',
//     '케이크',
//     '하트',
//     '포항항',
//     '크리스마스',
//     '김이한팀',
//     '화이팅',
//     '가나다라마바사',
//   ];
//   List<String> appliedKeyword = [];

//   void search(String value) {
//     // 검색 할 시, 실행되는 함수
//     if (value.isNotEmpty) {
//       setState(() {
//         appliedKeyword.insert(0, value);
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     appliedKeyword.add(widget.newKeyword);
//   }

//   @override
//   void dispose() {
//     _textEditingController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         titleSpacing: 0,
//         title: Padding(
//           padding: const EdgeInsets.only(right: 20),
//           child: CupertinoSearchTextField(
//             onSubmitted: search,
//             controller: _textEditingController,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: gray06,
//             ),
//             placeholder: '검색어를 입력해주세요.',
//             placeholderStyle: TextStyle(
//               color: gray04,
//             ),
//             decoration: BoxDecoration(
//               color: gray02,
//               borderRadius: BorderRadius.circular(16),
//               //검색창 비어있으면 border 없애고, 검색어 입력되면 border 생기게 하기
//               border: _textEditingController.text.isEmpty
//                   ? Border.all(color: Colors.transparent)
//                   : Border.all(color: coral01),
//             ),
//             prefixIcon: SvgPicture.asset('assets/icons/search_bar.svg'),
//             prefixInsets: const EdgeInsets.only(
//               left: 16,
//               top: 10.5,
//               bottom: 10.5,
//               right: 4,
//             ),
//           ),
//         ),
//         // title: SizedBox(
//         //   height: 37,
//         //   child: TextField(
//         //     style: const TextStyle(
//         //       fontSize: 14,
//         //       fontWeight: FontWeight.w600,
//         //     ),
//         //     decoration: InputDecoration(
//         //       prefix: SvgPicture.asset('assets/tab_icons/search.svg'),
//         //       suffixIcon: IconButton(
//         //         onPressed: () {},
//         //         icon: FaIcon(FontAwesomeIcons.x),
//         //       ),
//         //       suffix: SvgPicture.asset('assets/tab_icons/search.svg'),
//         //       // prefixIcon: Container(
//         //       //   width: 16,
//         //       //   height: 16,
//         //       //   alignment: Alignment.center,
//         //       //   child: SvgPicture.asset('assets/tab_icons/search.svg',
//         //       //       width: 16,
//         //       //       colorFilter: ColorFilter.mode(gray05, BlendMode.srcIn)),
//         //       // ),
//         //       // 왜인지 모르겠지만 패딩안넣으면 이상함...
//         //       contentPadding: const EdgeInsets.all(0),
//         //       fillColor: gray02,
//         //       filled: true,
//         //       enabledBorder: OutlineInputBorder(
//         //         borderSide: BorderSide(color: gray08.withOpacity(0)),
//         //         borderRadius: BorderRadius.circular(16),
//         //       ),
//         //       focusedBorder: OutlineInputBorder(
//         //         borderSide: BorderSide(color: orange01),
//         //         borderRadius: BorderRadius.circular(16),
//         //       ),
//         //       hintText: '검색어를 입력해주세요.',
//         //       hintStyle: TextStyle(
//         //         color: gray04,
//         //       ),
//         //     ),
//         //     onSubmitted: (value) => search(value),
//         //   ),
//         // ),
//       ),
//       body: 
//       SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 18,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 '최근 검색 키워드',
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   color: gray06,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 12,
//             ),
//             Container(
//               padding: const EdgeInsets.only(left: 20, right: 20),
//               height: 33,
//               child: ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     return KeywordWidget(keyword: recentKeyword[index]);
//                   },
//                   separatorBuilder: (context, index) {
//                     return const SizedBox(width: 8);
//                   },
//                   itemCount: recentKeyword.length),
//             ),
//             const MyDivider(),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 '적용된 검색 키워드',
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   color: gray06,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 12,
//             ),
//             Container(
//               padding: const EdgeInsets.only(left: 20, right: 20),
//               height: 33,
//               child: ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     return KeywordWidget(
//                         keyword: appliedKeyword[index], applied: true);
//                   },
//                   separatorBuilder: (context, index) {
//                     return const SizedBox(width: 8);
//                   },
//                   itemCount: appliedKeyword.length),
//             ),
//             GridView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: 20,
//               padding: const EdgeInsets.only(
//                 top: 30,
//                 left: 20,
//                 right: 20,
//               ),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 6,
//                 mainAxisSpacing: 6,
//                 childAspectRatio: 1,
//               ),
//               itemBuilder: (context, index) => Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [shadow01],
//                 ),
//                 clipBehavior: Clip.hardEdge,
//                 child: Stack(
//                   alignment: Alignment.bottomRight,
//                   children: [
//                     Image.asset(
//                       'assets/heart_cake.png',
//                       fit: BoxFit.cover,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Stack(
//                         children: [
//                           SvgPicture.asset(
//                             'assets/icons/like=on_in.svg',
//                             colorFilter: ColorFilter.mode(
//                               coral01,
//                               BlendMode.srcATop,
//                             ),
//                           ),
//                           SvgPicture.asset(
//                             'assets/icons/like=off.svg',
//                             colorFilter: const ColorFilter.mode(
//                               Colors.white,
//                               BlendMode.srcATop,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 100),
//           ],
//         ),
//       ),
//     );
//   }
// }
