import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kezzle/features/cake_search/search_cake_screen.dart';
import 'package:kezzle/features/cake_search/widgets/keyword_widget.dart';
import 'package:kezzle/utils/colors.dart';

enum Change { up, down, maintain }

class SearchCakeInitailScreen extends StatefulWidget {
  const SearchCakeInitailScreen({super.key});

  @override
  State<SearchCakeInitailScreen> createState() =>
      _SearchCakeInitailScreenState();
}

class _SearchCakeInitailScreenState extends State<SearchCakeInitailScreen> {
  bool isSearch = false; // 한 개의 키워드라도 적용된 경우, true로 변경
  String newKeyword = ''; // 새로운 키워드를 입력받을 변수
  final TextEditingController _textEditingController = TextEditingController();
  String _text = ''; // 검색창에 입력된 텍스트를 저장할 변수

  final List recentKeyword = [
    // 최근 검색 키워드 리스트
    '스마일',
    '케이크',
    '하트',
    '포항항',
    '크리스마스',
    '김이한팀',
    '화이팅',
    '가나다라마바사',
  ];

  final List hotKeyword = [
    // 인기 검색 키워드 리스트
    '스마일',
    '케이크',
    '하트',
    '포항항',
    '크리스마스',
    '김이한팀',
    '스마일',
    '케이크',
    '하트',
    '포항항',
  ];

  List<String> appliedKeywordList = []; // 적용된 키워드 리스트

  final List recentCakeUrl = [
    // 최근 본 케이크 리스트
    'assets/heart_cake.png',
    'assets/heart_cake.png',
    'assets/heart_cake.png',
  ];

  // List<String> searcedCakeUrl = [
  //   // 검색된 케이크 리스트
  //   'assets/heart_cake.png',
  //   'assets/heart_cake.png',
  //   'assets/heart_cake.png',
  //   'assets/heart_cake.png',
  //   'assets/heart_cake.png',
  //   'assets/heart_cake.png',
  //   'assets/heart_cake.png',
  //   'assets/heart_cake.png',
  //   'assets/heart_cake.png',
  //   'assets/heart_cake.png',
  //   'assets/heart_cake.png',
  //   'assets/heart_cake.png',
  //   'assets/heart_cake.png',
  //   'assets/heart_cake.png',
  // ]; // 검색된 케이크 리스트

  void search(String value) {
    // 검색 키워드를 입력하고 검색 버튼을 누른 경우, 실행될 함수

    // isSearch = true; // 키워드가 검색된 경우, true로 변경
    // newKeyword = value; // 새로운 키워드를 입력받음
    // if (!appliedKeywordList.contains(newKeyword)) {
    //   // 새로운 키워드가 적용된 키워드 리스트에 없는 경우, 추가
    //   appliedKeywordList.add(newKeyword);
    // }
    if (value.isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SearchCakeScreen(newKeyword: value),
      ));
    }
  }

  void keyboardDown() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
        _text = _textEditingController.text;
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: keyboardDown,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: CupertinoSearchTextField(
              onSubmitted: search,
              controller: _textEditingController,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: gray06,
              ),
              placeholder: '검색어를 입력해주세요.',
              placeholderStyle: TextStyle(
                color: gray04,
              ),
              decoration: BoxDecoration(
                color: gray02,
                borderRadius: BorderRadius.circular(16),
                //검색창 비어있으면 border 없애고, 검색어 입력되면 border 생기게 하기
                border: _textEditingController.text.isEmpty
                    ? Border.all(color: Colors.transparent)
                    : Border.all(color: coral01),
              ),
              prefixIcon: SvgPicture.asset('assets/icons/search_bar.svg'),
              prefixInsets: const EdgeInsets.only(
                left: 16,
                top: 10.5,
                bottom: 10.5,
                right: 4,
              ),
            ),
          ),
        ),

        body: SingleChildScrollView(
          // physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  '최근 검색 키워드',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: gray08,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: 33,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return KeywordWidget(keyword: recentKeyword[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 8);
                    },
                    itemCount: recentKeyword.length),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '인기 검색 키워드',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: gray08,
                          ),
                        ),
                        Text(
                          '07시 기준',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: gray05,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width:
                              (MediaQuery.of(context).size.width - 40 - 36) / 2,
                          height: 213,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              HotKeyWordWidget(
                                keyword: hotKeyword[0],
                                rank: 1,
                                change: Change.up,
                              ),
                              HotKeyWordWidget(
                                keyword: hotKeyword[1],
                                rank: 2,
                                change: Change.down,
                              ),
                              HotKeyWordWidget(
                                keyword: hotKeyword[2],
                                rank: 3,
                                change: Change.maintain,
                              ),
                              HotKeyWordWidget(
                                keyword: hotKeyword[2],
                                rank: 3,
                                change: Change.maintain,
                              ),
                              HotKeyWordWidget(
                                keyword: hotKeyword[2],
                                rank: 3,
                                change: Change.up,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 36),
                        SizedBox(
                          width:
                              (MediaQuery.of(context).size.width - 40 - 36) / 2,
                          height: 213,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              HotKeyWordWidget(
                                keyword: hotKeyword[5],
                                rank: 6,
                                change: Change.up,
                              ),
                              HotKeyWordWidget(
                                keyword: hotKeyword[6],
                                rank: 7,
                                change: Change.down,
                              ),
                              HotKeyWordWidget(
                                keyword: hotKeyword[7],
                                rank: 8,
                                change: Change.maintain,
                              ),
                              HotKeyWordWidget(
                                keyword: hotKeyword[8],
                                rank: 9,
                                change: Change.up,
                              ),
                              HotKeyWordWidget(
                                keyword: hotKeyword[9],
                                rank: 10,
                                change: Change.down,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  '최근 본 케이크',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: gray08,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                height: 160,
                child: ListView.separated(
                  itemCount: recentCakeUrl.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 12);
                  },
                  itemBuilder: (context, index) {
                    return RecentCakeWidget(
                        recentCakeUrl: recentCakeUrl[index]);
                  },
                ),
              ),
              // !isSearch ? const HotKeyWordWidget() : const SizedBox(),
              // !isSearch
              //     ? RecentCakeSectionWidget(recentCakeUrl: recentCakeUrl)
              //     : const SizedBox(),
              // isSearch
              //     ? AppliedKeywordSection(
              //         appliedKeywordList: appliedKeywordList)
              //     : const SizedBox(),
              // const SizedBox(height: 20),
              // isSearch
              //     ? Expanded(
              //         child: GridView.builder(
              //           keyboardDismissBehavior:
              //               ScrollViewKeyboardDismissBehavior.onDrag,
              //           itemCount: searcedCakeUrl.length,
              //           gridDelegate:
              //               const SliverGridDelegateWithFixedCrossAxisCount(
              //             crossAxisSpacing: 3,
              //             mainAxisSpacing: 3,
              //             crossAxisCount:
              //                 3, // 3개씩 보여주기 위해 crossAxisCount를 3으로 설정
              //           ),
              //           itemBuilder: (BuildContext context, int index) {
              //             return AspectRatio(
              //               aspectRatio: 1,
              //               child: Stack(
              //                 children: [
              //                   Image.asset(
              //                     searcedCakeUrl[index],
              //                   ),
              //                   const Align(
              //                     alignment: Alignment.bottomRight,
              //                     child: Padding(
              //                       padding: EdgeInsets.all(8),
              //                       child:
              //                           Icon(Icons.favorite, color: Colors.red),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             );
              //           },
              //         ),
              //       )
              //     : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class HotKeyWordWidget extends StatelessWidget {
  final String keyword;
  final int rank;
  final Change change;

  const HotKeyWordWidget({
    super.key,
    required this.keyword,
    required this.rank,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Text(
            '$rank',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: gray08,
            ),
          ),
          SizedBox(
            width: rank == 10 ? 10 : 17,
          ),
          Expanded(
            child: Text(
              keyword,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: gray05,
              ),
            ),
          ),
          SvgPicture.asset(
            change == Change.up
                ? 'assets/icons/up_rank.svg'
                : change == Change.down
                    ? 'assets/icons/down_rank.svg'
                    : 'assets/icons/rank.svg',
            width: 21,
          ),
        ],
      ),
    );
  }
}

// class AppliedKeywordSection extends StatelessWidget {
//   const AppliedKeywordSection({
//     super.key,
//     required this.appliedKeywordList,
//   });

//   final List<String> appliedKeywordList;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           '적용된 검색 키워드',
//           style: TextStyle(
//             fontSize: 14,
//             color: Color(0xFF979797),
//           ),
//         ),
//         const SizedBox(height: 5),
//         SizedBox(
//           height: 30,
//           child: ListView.separated(
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 return AppliedKeyword(keyword: appliedKeywordList[index]);
//               },
//               separatorBuilder: (context, index) {
//                 return const SizedBox(width: 3);
//               },
//               itemCount: appliedKeywordList.length),
//         ),
//       ],
//     );
//   }
// }

// class RecentCakeSectionWidget extends StatelessWidget {
//   const RecentCakeSectionWidget({
//     super.key,
//     required this.recentCakeUrl,
//   });

//   final List recentCakeUrl;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           '최근 본 케이크',
//           style: TextStyle(
//             fontSize: 14,
//             color: Color(0xFF979797),
//           ),
//         ),
//         const SizedBox(height: 10),
//         SizedBox(
//           height: 140,
//           child: ListView.separated(
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 return RecentCakeWidget(recentCakeUrl: recentCakeUrl[index]);
//               },
//               separatorBuilder: (context, index) {
//                 return const SizedBox(width: 10);
//               },
//               itemCount: recentCakeUrl.length),
//         ),
//       ],
//     );
//   }
// }

class RecentCakeWidget extends StatelessWidget {
  const RecentCakeWidget({
    super.key,
    required this.recentCakeUrl,
  });

  final String recentCakeUrl;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage(recentCakeUrl),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  SvgPicture.asset('assets/icons/like=off_in.svg'),
                  // 나중에 하트 눌렀는에 따라 다르게 나타내야됨.
                  SvgPicture.asset('assets/icons/like=on_in.svg'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class RecentKeyword extends StatelessWidget {
//   const RecentKeyword({
//     super.key,
//     required this.keyword,
//   });

//   final String keyword;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(
//         border: Border.all(color: gray04),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           Text(
//             keyword,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//               color: gray06,
//             ),
//           ),
//           const SizedBox(width: 5),
//           GestureDetector(
//             onTap: () => print('delete'),
//             child: FaIcon(
//               FontAwesomeIcons.xmark,
//               size: 12,
//               color: gray04,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class AppliedKeyword extends StatelessWidget {
//   const AppliedKeyword({
//     super.key,
//     required this.keyword,
//   });

//   final String keyword;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: const Color(0xFFD9D9D9),
//         // border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             keyword,
//             style: const TextStyle(
//               fontSize: 14,
//             ),
//           ),
//           const SizedBox(width: 5),
//           GestureDetector(
//               onTap: () => print('delete'),
//               child: const FaIcon(FontAwesomeIcons.squareXmark, size: 14)),
//         ],
//       ),
//     );
//   }
// }
