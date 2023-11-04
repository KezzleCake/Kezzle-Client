import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/analytics/analytics.dart';
import 'package:kezzle/features/cake_search/model/hotkeyword_model.dart';
import 'package:kezzle/features/cake_search/notifier/search_cake_vm.dart';
import 'package:kezzle/features/cake_search/notifier/search_keywords_notifier.dart';
import 'package:kezzle/features/cake_search/widgets/keyword_widget.dart';
import 'package:kezzle/repo/ranks_repo.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/view_models/currnet_keyword_view_model.dart';
import 'package:kezzle/widgets/bookmark_cake_widget.dart';

// enum Change { up, down, maintain }

class SearchCakeInitailScreen extends ConsumerStatefulWidget {
  static const routeName = '/search_cake_initial_screen';
  String? keyword;

  SearchCakeInitailScreen({super.key, this.keyword});

  @override
  SearchCakeInitailScreenState createState() => SearchCakeInitailScreenState();
}

class SearchCakeInitailScreenState
    extends ConsumerState<SearchCakeInitailScreen> {
  bool searchedDataViewerMode = false; // 한 개의 키워드라도 적용된 경우, true로 변경
  final TextEditingController _textEditingController = TextEditingController();
  late Future<RankingListModel?> fetchRanking;
  final ScrollController controller = ScrollController();
  bool isLoading = false;

  // List<String> appliedKeyword = []; // 적용된 키워드 리스트

  void search(final String keyword) async {
    if (keyword.isEmpty) return;
    _textEditingController.clear();

    ref.read(recentKeywordRecordProvider.notifier).recordKeyword(keyword);

    ref.read(searchCakeViewModelProvider.notifier).addSearch(keyword,
        onSearch: () {
      if (!searchedDataViewerMode) changeSearchDataViewerMode(true);
      ref.read(analyticsProvider).logSearch(searchTerm: keyword);
    });
  }

  void changeSearchDataViewerMode(bool change) {
    searchedDataViewerMode = change;
    setState(() {});
  }

  void keyboardDown() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    fetchRanking = fetchRankingList();
    controller.addListener(scrollListener);
    super.initState();

    // 화면이 그려지고 난후, search함수 실행
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.keyword != null) {
        print('제발요');
        search(widget.keyword!);
      }
    });
  }

  void scrollListener() async {
    if (controller.offset > controller.position.maxScrollExtent - 300 &&
        !isLoading &&
        ref.read(searchCakeViewModelProvider.notifier).fetchMore) {
      print('fetchMore');
      setState(() => isLoading = true);

      await ref.read(searchCakeViewModelProvider.notifier).fetchNextPage();
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
    ref.read(recentKeywordRecordProvider.notifier).deleteAllRecentKeyword();
  }

  @override
  Widget build(BuildContext context) {
    // ref.read(searchCakeViewModelProvider);
    return WillPopScope(
      onWillPop: () async {
        ref.read(searchKeywordsProvider.notifier).clear();
        context.pop();
        return false;
      },
      child: GestureDetector(
          onTap: keyboardDown,
          // onPanDown: keyboardDown,
          child: Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CupertinoSearchTextField(
                      onSubmitted: search,
                      controller: _textEditingController,
                      style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                          color: gray06),
                      placeholder: '키워드로 케이크 디자인을 검색해보세요!',
                      placeholderStyle: TextStyle(color: gray04),
                      decoration: BoxDecoration(
                          color: gray02,
                          borderRadius: BorderRadius.circular(16),
                          border: _textEditingController.text.isEmpty
                              ? Border.all(color: Colors.transparent)
                              : Border.all(color: coral01)),
                      prefixIcon: SvgPicture.asset(
                        'assets/icons/search_bar.svg',
                        colorFilter: ColorFilter.mode(
                          gray05,
                          BlendMode.srcIn,
                        ),
                      ),
                      prefixInsets: const EdgeInsets.only(
                          left: 16, top: 10.5, bottom: 10.5, right: 4))),
            ),
            body: searchedDataViewerMode
                ? Column(
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
                            child: Consumer(builder: (context, ref, child) {
                              final searchKeywords =
                                  ref.watch(searchKeywordsProvider);
                              return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final keyword = searchKeywords[index];
                                    return KeywordWidget(
                                        keyword: keyword,
                                        deleteFunction: () => ref
                                            .read(searchCakeViewModelProvider
                                                .notifier)
                                            .deleteKeywordsWithReSearch(keyword,
                                                changeSearchMode: () =>
                                                    changeSearchDataViewerMode(
                                                        false)),
                                        applied: true);
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 8),
                                  itemCount: searchKeywords.length);
                            })),
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
                                    keyboardDismissBehavior:
                                        ScrollViewKeyboardDismissBehavior
                                            .onDrag,
                                    controller: controller,
                                    itemCount:
                                        cakes.length + (isLoading ? 3 : 0),
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
                                      // print(index);
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
                      ])
                : SingleChildScrollView(
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
                        ref.read(recentKeywordRecordProvider).isEmpty
                            ? const SizedBox()
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(children: [
                                      for (var i = 0;
                                          i <
                                              ref
                                                  .watch(
                                                      recentKeywordRecordProvider)
                                                  .length;
                                          i++) ...[
                                        GestureDetector(
                                          onTap: () {
                                            search(ref.read(
                                                recentKeywordRecordProvider)[i]);
                                            ref.read(analyticsProvider).gaEvent(
                                                'click_recent_keyword', {
                                              'keyword': ref.read(
                                                  recentKeywordRecordProvider)[i],
                                            });
                                          },
                                          child: KeywordWidget(
                                              // keyword: recentKeyword[index],
                                              keyword: ref.watch(
                                                  recentKeywordRecordProvider)[i],
                                              deleteFunction: () {}),
                                        ),
                                        const SizedBox(width: 8),
                                      ]
                                    ]))),
                        // Container(
                        //     padding:
                        //         const EdgeInsets.only(left: 20, right: 20),
                        //     height: 33,
                        //     child: ListView.separated(
                        //         scrollDirection: Axis.horizontal,
                        //         itemBuilder: (context, index) {
                        //           return GestureDetector(
                        //             onTap: () {
                        //               search(ref.read(
                        //                       recentKeywordRecordProvider)[
                        //                   index]);
                        //               ref
                        //                   .read(analyticsProvider)
                        //                   .gaEvent('click_recent_keyword', {
                        //                 'keyword': ref.read(
                        //                         recentKeywordRecordProvider)[
                        //                     index],
                        //               });
                        //             },
                        //             child: KeywordWidget(
                        //                 // keyword: recentKeyword[index],
                        //                 keyword: ref.watch(
                        //                         recentKeywordRecordProvider)[
                        //                     index],
                        //                 deleteFunction: () {}),
                        //           );
                        //         },
                        //         separatorBuilder: (context, index) {
                        //           return const SizedBox(width: 8);
                        //         },
                        //         itemCount: ref
                        //             .watch(recentKeywordRecordProvider)
                        //             .length),
                        //   ),
                        const SizedBox(height: 40),
                        FutureBuilder<RankingListModel?>(
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
                                                      for (var i = 0;
                                                          i < 5;
                                                          i++)
                                                        GestureDetector(
                                                          onTap: () {
                                                            search(rankingList
                                                                .ranks[i]
                                                                .keyword);

                                                            ref
                                                                .read(
                                                                    analyticsProvider)
                                                                .gaEvent(
                                                                    'click_hot_keyword',
                                                                    {
                                                                  'keyword':
                                                                      rankingList
                                                                          .ranks[
                                                                              i]
                                                                          .keyword,
                                                                });
                                                          },
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
                                                      for (var i = 5;
                                                          i < 10;
                                                          i++)
                                                        GestureDetector(
                                                          onTap: () {
                                                            search(rankingList
                                                                .ranks[i]
                                                                .keyword);
                                                            ref
                                                                .read(
                                                                    analyticsProvider)
                                                                .gaEvent(
                                                                    'click_hot_keyword',
                                                                    {
                                                                  'keyword':
                                                                      rankingList
                                                                          .ranks[
                                                                              i]
                                                                          .keyword,
                                                                });
                                                          },
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
                                return const SizedBox();
                              }
                            }),
                      ])),
          )),
    );
  }
}

class HotKeyWordWidget extends StatelessWidget {
  final RankModel rankData;
  final int rank;

  const HotKeyWordWidget({
    super.key,
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
                  fontSize: 14, fontWeight: FontWeight.w700, color: coral01)),
          SizedBox(width: rank == 10 ? 10 : 17),
          Expanded(
              child: Text(rankData.keyword,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: gray05))),
        ]));
  }
}
