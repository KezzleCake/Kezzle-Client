import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kezzle/features/analytics/analytics.dart';
import 'package:kezzle/features/cake_search/model/hotkeyword_model.dart';
import 'package:kezzle/features/cake_search/vm/search_cake_vm.dart';
import 'package:kezzle/features/cake_search/widgets/keyword_widget.dart';
import 'package:kezzle/repo/ranks_repo.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/view_models/currnet_keyword_view_model.dart';
import 'package:kezzle/widgets/bookmark_cake_widget.dart';

// enum Change { up, down, maintain }

class SearchCakeInitailScreen extends ConsumerStatefulWidget {
  static const routeName = '/search_cake_initial_screen';

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
  late Future<RankingListModel?> fetchRanking;
  final ScrollController controller = ScrollController();
  bool isLoading = false;

  List<String> appliedKeyword = []; // 적용된 키워드 리스트

  void search(String value) async {
    // 검색 키워드를 입력하고 검색 버튼을 누른 경우, 실행될 함수
    // if (isSearched == false && value.isNotEmpty) {
    //   // 키워드가 검색된 경우, true로 변경 -> 검색 결과 화면 나타내줘야됨.
    //   isSearched = true;
    // }
    ref.read(analyticsProvider).analytics.logSearch(searchTerm: value);

    if (value.isNotEmpty) {
      newKeyword = value; // 새로운 키워드를 입력받고 검색을 한 경우, newKeyword에 저장
      // 새로운 키워드가 적용된 키워드 리스트에 없는 경우, 추가
      if (!appliedKeyword.contains(newKeyword)) {
        appliedKeyword.insert(0, newKeyword);
        // print('새로운 키워드 적용');
        ref
            .read(searchCakeViewModelProvider.notifier)
            .search(keywords: appliedKeyword);
      }
      if (ref.read(currentKeywordVMProvider).contains(newKeyword)) {
        // 최근 검색 키워드 에 있었으면 삭제하고 앞쪽에 다시 추가

        // print(ref.read(currentKeywordVMProvider));
        ref.read(currentKeywordVMProvider.notifier).deleteKeyword(newKeyword);
        ref
            .read(currentKeywordVMProvider.notifier)
            .addCurrentKeyword(newKeyword);
      } else {
        ref
            .read(currentKeywordVMProvider.notifier)
            .addCurrentKeyword(newKeyword);
      }
      _textEditingController.clear(); // 검색창 비우기

      if (isSearched == false && value.isNotEmpty) {
        // 키워드가 검색된 경우, true로 변경 -> 검색 결과 화면 나타내줘야됨.
        // print('?');
        isSearched = true;
      }
      setState(() {});
    }
  }

  void keyboardDown() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    fetchRanking = fetchRankingList();
    _textEditingController.addListener(() {
      setState(() {
        _text = _textEditingController.text;
      });
    });
    controller.addListener(scrollListener);
    super.initState();
  }

  void scrollListener() async {
    // print('scrollListener 실행됨');
    // 현재 위치가 최대 길이보다 조금 덜 되는 위치까지 왔으면 새로운 데이터 추가요청
    if (controller.offset > controller.position.maxScrollExtent - 300 &&
        !isLoading &&
        ref.read(searchCakeViewModelProvider.notifier).fetchMore == true) {
      print('fetchMore');
      setState(() {
        isLoading = true;
      });
      await ref
          .read(searchCakeViewModelProvider.notifier)
          .fetchNextPage(keywords: appliedKeyword);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    controller.dispose();
    super.dispose();
  }

  // 적용된 키워드가 삭제 됐을 때, 실행 될 함수
  void deleteAppliedKeyword(String keyword) {
    appliedKeyword.remove(keyword);
    ref
        .read(searchCakeViewModelProvider.notifier)
        .search(keywords: appliedKeyword);
    // setState(() {});
  }

  Future<RankingListModel?> fetchRankingList() async {
    final response = await ref.read(ranksRepo).fetchRankingList();
    if (response == null) {
      return null;
    } else {
      final rankingListModel = RankingListModel.fromJson(response);
      return rankingListModel;
    }
  }

  void onTapDeleteRecentKeyword() {
    ref.read(currentKeywordVMProvider.notifier).deleteAllRecentKeyword();
  }

  @override
  Widget build(BuildContext context) {
    ref.read(searchCakeViewModelProvider);
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
              ? Column(
                  // mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      const SizedBox(height: 18),
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
                                  deleteFunction: () => deleteAppliedKeyword(
                                      appliedKeyword[index]),
                                  keyword: appliedKeyword[index],
                                  applied: true),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 8),
                              itemCount: appliedKeyword.length)),
                      const SizedBox(height: 16),
                      ref.watch(searchCakeViewModelProvider).when(
                            loading: () => Column(children: [
                              const SizedBox(height: 100),
                              Center(
                                  child: CircularProgressIndicator(
                                      color: coral01)),
                            ]),
                            error: (err, stack) =>
                                const Center(child: Text('검색 실패')),
                            data: (cakes) {
                              // List<Cake> cakes = data;
                              if (cakes.isEmpty) {
                                return const Center(
                                    child: Text('검색 결과가 없습니다.'));
                              }
                              return Expanded(
                                child: GridView.builder(
                                  controller: controller,
                                  // physics:
                                  //     const NeverScrollableScrollPhysics(),
                                  // shrinkWrap: true,
                                  // itemCount: 20,
                                  itemCount: cakes.length + (isLoading ? 3 : 0),
                                  padding: const EdgeInsets.only(
                                      // top: 30,
                                      left: 20,
                                      right: 20),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 6,
                                          mainAxisSpacing: 6,
                                          childAspectRatio: 1),
                                  itemBuilder: (context, index) {
                                    print(index);
                                    if (index == cakes.length && isLoading) {
                                      return Container();
                                    } else if (index == cakes.length + 1 &&
                                        isLoading) {
                                      return Center(
                                          child: CircularProgressIndicator(
                                              color: coral01));
                                    } else if (index == cakes.length + 2 &&
                                        isLoading) {
                                      return Container();
                                    } else if (index != cakes.length) {
                                      return BookmarkCakeWidget(
                                          cakeData: cakes[index]);
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                      // const SizedBox(height: 100),
                    ])
              // 초기 검색화면(최근, 인기, 검색어 목록)
              : SingleChildScrollView(
                  // physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const SizedBox(height: 16),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('최근 검색 키워드',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: gray08)),
                              GestureDetector(
                                  onTap: onTapDeleteRecentKeyword,
                                  child: Text('지우기',
                                      style: TextStyle(
                                          color: gray05,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600)))
                            ],
                          )),
                      const SizedBox(height: 16),
                      ref.read(currentKeywordVMProvider).isEmpty
                          ? const SizedBox()
                          : Container(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              height: 33,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => search(ref.read(
                                          currentKeywordVMProvider)[index]),
                                      child: KeywordWidget(
                                          // keyword: recentKeyword[index],
                                          keyword: ref.watch(
                                              currentKeywordVMProvider)[index],
                                          deleteFunction: () {}),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 8);
                                  },
                                  // itemCount: recentKeyword.length
                                  itemCount: ref
                                      .watch(currentKeywordVMProvider)
                                      .length),
                            ),
                      const SizedBox(height: 40),
                      FutureBuilder<RankingListModel?>(
                          // future: fetchRankingList(),
                          future: fetchRanking,
                          builder: (context, data) {
                            if (data.hasData) {
                              final RankingListModel rankingList = data.data!;
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
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
                                          // Text('07시 기준',
                                          //     style: TextStyle(
                                          //         fontSize: 14,
                                          //         fontWeight: FontWeight.w600,
                                          //         color: gray05)),
                                          Text(
                                              '${rankingList.startDate} ~ ${rankingList.endDate}',
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
                                              child:
                                                  Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                    // for 문으로 위젯 생성
                                                    for (var i = 0; i < 5; i++)
                                                      GestureDetector(
                                                        onTap: () => search(
                                                            rankingList.ranks[i]
                                                                .keyword),
                                                        child: HotKeyWordWidget(
                                                            rank: i + 1,
                                                            rankData:
                                                                rankingList
                                                                    .ranks[i]),
                                                      )
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
                                              child:
                                                  Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                    // for 문으로 위젯 생성
                                                    for (var i = 5; i < 10; i++)
                                                      GestureDetector(
                                                        onTap: () => search(
                                                            rankingList.ranks[i]
                                                                .keyword),
                                                        child: HotKeyWordWidget(
                                                            rank: i + 1,
                                                            rankData:
                                                                rankingList
                                                                    .ranks[i]),
                                                      )
                                                  ])),
                                        ]),
                                  ]));
                            } else {
                              // return const Center(child: CircularProgressIndicator());
                              return const SizedBox();
                            }
                          }),
                    ])),
        ));
  }
}

class HotKeyWordWidget extends StatelessWidget {
  // final String keyword;
  // final int rank;
  // final Change change;
  final RankModel rankData;
  final int rank;

  const HotKeyWordWidget({
    super.key,
    // required this.keyword,
    // required this.rank,
    // required this.change,
    required this.rankData,
    required this.rank,
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
              child: Text(
                  // keyword,
                  rankData.keyword,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: gray05))),
          // SvgPicture.asset(
          //     change == Change.up
          //         ? 'assets/icons/up_rank.svg'
          //         : change == Change.down
          //             ? 'assets/icons/down_rank.svg'
          //             : 'assets/icons/rank.svg',
          //     width: 21),
        ]));
  }
}
