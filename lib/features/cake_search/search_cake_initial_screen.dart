import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kezzle/features/cake_search/model/hotkeyword_model.dart';
import 'package:kezzle/features/cake_search/vm/search_cake_vm.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kezzle/features/cake_search/widgets/keyword_widget.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/widgets/bookmark_cake_widget.dart';
import 'package:kezzle/widgets/my_divider_widget.dart';

// enum Change { up, down, maintain }

class SearchCakeInitailScreen extends ConsumerStatefulWidget {
  const SearchCakeInitailScreen({super.key});

  @override
  SearchCakeInitailScreenState createState() => SearchCakeInitailScreenState();
}

class SearchCakeInitailScreenState
    extends ConsumerState<SearchCakeInitailScreen> {
  bool isSearched = false; // 한 개의 키워드라도 적용된 경우, true로 변경
  String newKeyword = ''; // 새로운 키워드를 입력받을 변수
  final TextEditingController _textEditingController = TextEditingController();
  String _text = ''; // 검색창에 입력된 텍스트를 저장할 변수

  final List recentKeyword = [
    // 최근 검색 키워드 리스트
    '스마일',
    '케이크',
  ];

  // final List hotKeyword = [
  //   // 인기 검색 키워드 리스트
  //   '스마일',
  //   '케이크',
  //   '하트',
  //   '포항항',
  //   '크리스마스',
  //   '김이한팀',
  //   '스마일',
  //   '케이크',
  //   '하트',
  //   '포항항',
  // ];

  List<HotKeywordModel> hotkeywords = [
    HotKeywordModel(change: Change.up, keyword: '스마일', rank: 1),
    HotKeywordModel(change: Change.down, keyword: '케이크', rank: 2),
    HotKeywordModel(change: Change.maintain, keyword: '하트', rank: 3),
    HotKeywordModel(change: Change.up, keyword: '포항항', rank: 4),
    HotKeywordModel(change: Change.up, keyword: '스마일', rank: 5),
    HotKeywordModel(change: Change.down, keyword: '케이크', rank: 6),
    HotKeywordModel(change: Change.maintain, keyword: '하트', rank: 7),
    HotKeywordModel(change: Change.up, keyword: '포항항', rank: 8),
    HotKeywordModel(change: Change.up, keyword: '스마일', rank: 9),
    HotKeywordModel(change: Change.down, keyword: '케이크', rank: 10),
  ];

  List<String> appliedKeyword = []; // 적용된 키워드 리스트

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
    if (isSearched == false && value.isNotEmpty) {
      // 키워드가 검색된 경우, true로 변경 -> 검색 결과 화면 나타내줘야됨.
      isSearched = true;
    }

    if (value.isNotEmpty) {
      newKeyword = value; // 새로운 키워드를 입력받고 검색을 한 경우, newKeyword에 저장
      // 새로운 키워드가 적용된 키워드 리스트에 없는 경우, 추가
      if (!appliedKeyword.contains(newKeyword)) {
        appliedKeyword.insert(0, newKeyword);
        print('새로운 키워드 적용');
        ref
            .read(searchCakeViewModelProvider.notifier)
            .refresh(keywords: appliedKeyword);
      }
      if (recentKeyword.contains(newKeyword)) {
        recentKeyword.remove(newKeyword); // 최근 검색키워드에 있었으면 삭제하고 앞쪽에 다시 추가
        recentKeyword.insert(0, newKeyword);
      } else {
        recentKeyword.insert(0, newKeyword); // 최근 검색키워드에 없었으면 추가
      }
      _textEditingController.clear(); // 검색창 비우기
      setState(() {});
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
            titleSpacing: 0,
            title: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: CupertinoSearchTextField(
                    onSubmitted: search,
                    controller: _textEditingController,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: gray06),
                    placeholder: '검색어를 입력해주세요.',
                    placeholderStyle: TextStyle(color: gray04),
                    decoration: BoxDecoration(
                        color: gray02,
                        borderRadius: BorderRadius.circular(16),
                        //검색창 비어있으면 border 없애고, 검색어 입력되면 border 생기게 하기
                        border: _textEditingController.text.isEmpty
                            ? Border.all(color: Colors.transparent)
                            : Border.all(color: coral01)),
                    prefixIcon: SvgPicture.asset('assets/icons/search_bar.svg'),
                    prefixInsets: const EdgeInsets.only(
                        left: 16, top: 10.5, bottom: 10.5, right: 4))),
          ),

          body: isSearched
              ? SingleChildScrollView(
                  child: Column(
                      // mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const SizedBox(height: 18),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text('최근 검색 키워드',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: gray06))),
                      const SizedBox(height: 12),
                      Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          height: 33,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  KeywordWidget(keyword: recentKeyword[index]),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 8),
                              itemCount: recentKeyword.length)),
                      const MyDivider(),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text('적용된 검색 키워드',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: gray06))),
                      const SizedBox(height: 12),
                      Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          height: 33,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => KeywordWidget(
                                  keyword: appliedKeyword[index],
                                  applied: true),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 8),
                              itemCount: appliedKeyword.length)),
                      ref.watch(searchCakeViewModelProvider).when(
                            loading: () => Column(
                              children: [
                                const SizedBox(height: 100),
                                Center(
                                  child: CircularProgressIndicator(
                                    color: coral01,
                                  ),
                                ),
                              ],
                            ),
                            error: (err, stack) =>
                                const Center(child: Text('검색 실패')),
                            data: (data) {
                              List<Cake> cakes = data;
                              if (cakes.isEmpty) {
                                return const Center(
                                    child: Text('검색 결과가 없습니다.'));
                              }
                              return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 20,
                                padding: const EdgeInsets.only(
                                    top: 30, left: 20, right: 20),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 6,
                                        mainAxisSpacing: 6,
                                        childAspectRatio: 1),
                                itemBuilder: (context, index) {
                                  return BookmarkCakeWidget(
                                      cakeData: cakes[index]);
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(16),
                                  //       boxShadow: [shadow01]),
                                  //   clipBehavior: Clip.hardEdge,
                                  //   child:
                                  //   Stack(
                                  //       alignment: Alignment.bottomRight,
                                  //       children: [
                                  //         // Image.asset('assets/heart_cake.png',
                                  //         //     fit: BoxFit.cover),
                                  //         Image.network(
                                  //             cakes[index].image.s3Url
                                  //                 .replaceFirst(
                                  //                     "https", "http"),
                                  //             fit: BoxFit.cover),
                                  //         Padding(
                                  //             padding: const EdgeInsets.all(8.0),
                                  //             child: Stack(children: [
                                  //               SvgPicture.asset(
                                  //                 'assets/icons/like=on_in.svg',
                                  //                 colorFilter: ColorFilter.mode(
                                  //                     coral01, BlendMode.srcATop),
                                  //               ),
                                  //               SvgPicture.asset(
                                  //                 'assets/icons/like=off.svg',
                                  //                 colorFilter:
                                  //                     const ColorFilter.mode(
                                  //                         Colors.white,
                                  //                         BlendMode.srcATop),
                                  //               ),
                                  //             ])),
                                  //       ]));
                                },
                              );
                            },
                          ),
                      //  GridView.builder(
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     shrinkWrap: true,
                      //     itemCount: 20,
                      //     padding:
                      //         const EdgeInsets.only(top: 30, left: 20, right: 20),
                      //     gridDelegate:
                      //         const SliverGridDelegateWithFixedCrossAxisCount(
                      //             crossAxisCount: 3,
                      //             crossAxisSpacing: 6,
                      //             mainAxisSpacing: 6,
                      //             childAspectRatio: 1),
                      //     itemBuilder: (context, index) => Container(
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(16),
                      //             boxShadow: [shadow01]),
                      //         clipBehavior: Clip.hardEdge,
                      //         child: Stack(
                      //             alignment: Alignment.bottomRight,
                      //             children: [
                      //               Image.asset('assets/heart_cake.png',
                      //                   fit: BoxFit.cover),
                      //               Padding(
                      //                   padding: const EdgeInsets.all(8.0),
                      //                   child: Stack(children: [
                      //                     SvgPicture.asset(
                      //                       'assets/icons/like=on_in.svg',
                      //                       colorFilter: ColorFilter.mode(
                      //                           coral01, BlendMode.srcATop),
                      //                     ),
                      //                     SvgPicture.asset(
                      //                       'assets/icons/like=off.svg',
                      //                       colorFilter: const ColorFilter.mode(
                      //                           Colors.white, BlendMode.srcATop),
                      //                     ),
                      //                   ])),
                      //             ])),
                      //   ),
                      const SizedBox(height: 100),
                    ]))
              // 초기 검색화면(최근, 인기, 검색어 목록)
              : SingleChildScrollView(
                  // physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const SizedBox(height: 16),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text('최근 검색 키워드',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: gray08))),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        height: 33,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return KeywordWidget(
                                  keyword: recentKeyword[index]);
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 8);
                            },
                            itemCount: recentKeyword.length),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('인기 검색 키워드',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: gray08)),
                                  Text('07시 기준',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: gray05)),
                                ]),
                            const SizedBox(height: 16),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: (MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40 -
                                              36) /
                                          2,
                                      height: 213,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            // for 문으로 위젯 생성
                                            for (var i = 0;
                                                i < hotkeywords.length / 2;
                                                i++)
                                              HotKeyWordWidget(
                                                  keyword:
                                                      hotkeywords[i].keyword,
                                                  rank: hotkeywords[i].rank,
                                                  change:
                                                      hotkeywords[i].change),
                                          ])),
                                  const SizedBox(width: 36),
                                  SizedBox(
                                      width: (MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40 -
                                              36) /
                                          2,
                                      height: 213,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            // for 문으로 위젯 생성
                                            for (var i = 5;
                                                i < hotkeywords.length;
                                                i++)
                                              HotKeyWordWidget(
                                                  keyword:
                                                      hotkeywords[i].keyword,
                                                  rank: hotkeywords[i].rank,
                                                  change:
                                                      hotkeywords[i].change),
                                          ])),
                                ]),
                          ])),
                    ])),
        ));
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
        child: Row(children: [
          Text('$rank',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w700, color: gray08)),
          SizedBox(width: rank == 10 ? 10 : 17),
          Expanded(
              child: Text(keyword,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: gray05))),
          SvgPicture.asset(
              change == Change.up
                  ? 'assets/icons/up_rank.svg'
                  : change == Change.down
                      ? 'assets/icons/down_rank.svg'
                      : 'assets/icons/rank.svg',
              width: 21),
        ]));
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

// class RecentCakeWidget extends StatelessWidget {
//   const RecentCakeWidget({
//     super.key,
//     required this.recentCakeUrl,
//   });

//   final String recentCakeUrl;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 160,
//       height: 160,
//       child: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             clipBehavior: Clip.hardEdge,
//             child: Image(
//               fit: BoxFit.cover,
//               image: AssetImage(recentCakeUrl),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: Stack(
//                 children: [
//                   SvgPicture.asset('assets/icons/like=off_in.svg'),
//                   // 나중에 하트 눌렀는에 따라 다르게 나타내야됨.
//                   SvgPicture.asset('assets/icons/like=on_in.svg'),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
