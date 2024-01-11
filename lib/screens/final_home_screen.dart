import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kezzle/features/analytics/analytics.dart';
import 'package:kezzle/features/cake_search/model/hotkeyword_model.dart';
import 'package:kezzle/features/cake_search/search_cake_initial_screen.dart';
import 'package:kezzle/features/profile/view_models/profile_vm.dart';
import 'package:kezzle/models/curation_model.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/curation_repo.dart';
import 'package:kezzle/screens/infinite_anniversary_screen.dart';
import 'package:kezzle/screens/infinite_curation_screen.dart';
import 'package:kezzle/screens/infinite_new_cake_screen.dart';
import 'package:kezzle/screens/infinite_popular_cake_screen.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/view_models/id_token_provider.dart';
import 'package:kezzle/widgets/home_cake_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:developer';

class FinalHomeScreen extends ConsumerStatefulWidget {
  const FinalHomeScreen({super.key});

  @override
  FinalHomeScreenState createState() => FinalHomeScreenState();
}

class FinalHomeScreenState extends ConsumerState<FinalHomeScreen>
    with SingleTickerProviderStateMixin {
  final CarouselController _carouselController = CarouselController();
  final CarouselController _bannerController = CarouselController();
  late Future<Map<String, dynamic>?> fetchHomeData;
  // late Future<Map<String, dynamic>> _dataFuture;
  // late Future<List<Cake>> fetchPopularCakes;
  // late Future<Map<String, dynamic>> fetchCurations;

  // int _currentBannerPage = 0;
  List bannerImageList = [
    'assets/event/가입이벤트배너.png',
    'assets/event/스벅배너.png',
    'assets/event/사장님배너.png',
  ];
  List<String> bannerUrl = [
    'https://forms.gle/YR9EnmqK9t9SbAXX8',
    'https://forms.gle/wztk59iVxkYPDhtL8',
    'https://forms.gle/Y6SV3LvCMUvvi4xE8',
  ];

  double verticalGap = 47;

  // var token;

  @override
  void initState() {
    // fetchPopularCakes = fetchTop10Cakes(ref);
    // print('inithome');

    //completer로 fetxhCuration 끝나면 팝업 띄우기
    super.initState();
    fetchHomeData = fetchData();
    // fetchCurations = fetchHomeCurations();
    // fetchHomeData.then((_) async {
    //   final sharedPreferences = await SharedPreferences.getInstance();
    //   if (sharedPreferences.getBool('isShowPopUp') == null ||
    //       sharedPreferences.getBool('isShowPopUp') == true) {
    //     popUpTest();
    //   }
    // });
  }

  // 현재 슬라이드 페이지
  int _currentPage = 0;
  // 자동 슬라이드 여부
  bool autoPlay = false;
  // bool banner_autoPlay = false;
  // late String anniversaryId;

  void onTapSlide(AniversaryCurationModel anniversaryCuration) {
    context.pushNamed(InfiniteAnniversaryScreen.routeName, extra: {
      'curation_id': anniversaryCuration.id,
      'curation_description': anniversaryCuration.anniversaryTitle,
    });
    ref.read(analyticsProvider).gaEvent('click_curation', {
      'anniversary_id': anniversaryCuration.id,
      'curation_description': 'anniversary',
    });
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    // 아니안하면 어떻게 하는데
    setState(() {
      _currentPage = index;
    });
  }

  // 슬라이드가 보이는지 안보이는지 체크 (보이면 자동재생, 안보이면 멈춤)
  void _slideVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 0) {
      if (mounted) {
        setState(() {
          autoPlay = false;
        });
      }
    } else {
      setState(() {
        autoPlay = true;
      });
    }
  }

  // 슬라이드가 보이는지 안보이는지 체크 (보이면 자동재생, 안보이면 멈춤)
  // void _bannerVisibilityChanged(VisibilityInfo info) {
  //   if (info.visibleFraction == 0) {
  //     if (mounted) {
  //       setState(() {
  //         banner_autoPlay = false;
  //       });
  //     }
  //   } else {
  //     setState(() {
  //       banner_autoPlay = true;
  //     });
  //   }
  // }

  // void popUpTest() async {
  //   //TODO: 두번씩 호출되는거 어쩔거야..

  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Column(
  //             // mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               GestureDetector(
  //                 onTap: () => launchUrlString(
  //                   'https://forms.gle/Y6SV3LvCMUvvi4xE8',
  //                   mode: LaunchMode.externalApplication,
  //                 ),
  //                 child: Container(
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(20)),
  //                     clipBehavior: Clip.hardEdge,
  //                     width: MediaQuery.of(context).size.width - 55,
  //                     // height: 475,
  //                     child: Image.asset('assets/event/store_event.png')),
  //               ),
  //               Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 27.5),
  //                   child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         TextButton(
  //                             onPressed: () async {
  //                               // shared 값 변경
  //                               //TODO: shared 쓰는 방식 고치기, 값저장하는거 고치기
  //                               final sharedPreferences =
  //                                   await SharedPreferences.getInstance();
  //                               sharedPreferences.setBool('isShowPopUp', false);
  //                               // Navigator.pop(context);
  //                               if (!mounted) return;
  //                               context.pop();
  //                             },
  //                             child: Row(
  //                               children: [
  //                                 FaIcon(FontAwesomeIcons.circleCheck,
  //                                     size: 15, color: gray01),
  //                                 const SizedBox(width: 5),
  //                                 Text(
  //                                   '다시 보지 않기',
  //                                   style: TextStyle(
  //                                       color: gray01,
  //                                       fontSize: 15,
  //                                       fontWeight: FontWeight.w500),
  //                                 ),
  //                               ],
  //                             )),
  //                         TextButton(
  //                             onPressed: () async {
  //                               // Navigator.pop(context);
  //                               // shared 값 변경
  //                               //TODO: shared 쓰는 방식 고치기, 값저장하는거 고치기
  //                               final sharedPreferences =
  //                                   await SharedPreferences.getInstance();
  //                               sharedPreferences.setBool('isShowPopUp', false);
  //                               // Navigator.pop(context);
  //                               if (!mounted) return;
  //                               context.pop();
  //                             },
  //                             child: Row(
  //                                 crossAxisAlignment: CrossAxisAlignment.center,
  //                                 children: [
  //                                   Text(
  //                                     '닫기',
  //                                     style: TextStyle(
  //                                         color: gray01,
  //                                         fontSize: 15,
  //                                         fontWeight: FontWeight.w500),
  //                                   ),
  //                                   const SizedBox(width: 5),
  //                                   FaIcon(FontAwesomeIcons.circleXmark,
  //                                       size: 15, color: gray01)
  //                                 ])),
  //                       ])),
  //             ]);
  //       });
  // }

  Future<Map<String, dynamic>?> fetchData() async {
    // 예제 비동기 함수: 여기에서 데이터를 가져온다고 가정
    final response = ref.read(curationRepo).fetchHomeData();
    return response;
  }

  void onTapMoreBest() {
    context.pushNamed(InfinitePopularCakeScreen.routeName, extra: {
      'curation_id': 'popular',
      'curation_description': '실시간 BEST',
    });
  }

  void redirectSearchScreen() {
    context.pushNamed(SearchCakeInitailScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    double bestCakeWidth = (MediaQuery.of(context).size.width - 40) * 0.65;

    return Scaffold(
      appBar: AppBar(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SvgPicture.asset('assets/Kezzle.svg',
            height: 20,
            colorFilter: ColorFilter.mode(coral01, BlendMode.srcIn)),
        const SizedBox(width: 35),
        Expanded(
            child: GestureDetector(
          onTap: redirectSearchScreen,
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: gray02,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: coral02, width: 2.7)),
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('어떤 케이크 디자인을 찾으시나요?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: gray04,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                    FaIcon(FontAwesomeIcons.magnifyingGlass,
                        size: 16, color: gray08),
                  ])),
        ))
      ])),
      body: FutureBuilder<Map<String, dynamic>?>(
          future: fetchHomeData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              // print('ddd');
              // if (snapshot.data == null) return Container();
              final rawData = snapshot.data;

              // 기념일 큐레이션 데이터
              final aniversaryCuration =
                  AniversaryCurationModel.fromJson(rawData!['anniversary']);

              // 추천케이크 데이터
              final List<Cake> recommendCakes = [];
              snapshot.data!['recommendCakes'].forEach((cake) {
                recommendCakes.add(Cake.fromJson(cake));
              });

              // best 케이크 데이터
              final List<Cake> bestCakes = [];
              snapshot.data!['popularCakes']['cakes'].forEach((cake) {
                bestCakes.add(Cake.fromJson(cake));
              });

              //랭킹 데이터
              final List<RankModel> rankList = [];
              snapshot.data!['keywordRanks']['ranking'].forEach((rank) {
                rankList.add(RankModel.fromJson(rank));
              });

              // 새로운 케이크 데이터
              final List<Cake> newCakes = [];
              snapshot.data!['newestCakes']['cakes'].forEach((cake) {
                newCakes.add(Cake.fromJson(cake));
              });

              // 큐레이션 목록 데이터
              final List<HomeCurationModel> curationList = [];
              snapshot.data!['curations'].forEach((curation) {
                curationList.add(HomeCurationModel.fromJson(curation));
              });

              return RefreshIndicator(
                color: coral01,
                onRefresh: () async {
                  setState(() {
                    fetchHomeData = fetchData();
                  });
                },
                child: ListView(children: [
                  const SizedBox(height: 5),
                  VisibilityDetector(
                      key: const Key('carousel'),
                      onVisibilityChanged: _slideVisibilityChanged,
                      child: GestureDetector(
                        onTap: () => onTapSlide(aniversaryCuration),
                        child: Stack(children: [
                          CarouselSlider.builder(
                              carouselController: _carouselController,
                              itemCount: aniversaryCuration.imageUrls.length,
                              options: CarouselOptions(
                                onPageChanged: (index, reason) =>
                                    onPageChanged(index, reason),
                                reverse: false,
                                height: 230,
                                viewportFraction: 1,
                                enableInfiniteScroll: true,
                                autoPlay: autoPlay,
                                autoPlayInterval: const Duration(seconds: 2),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                scrollDirection: Axis.horizontal,
                              ),
                              itemBuilder: (context, index, realIndex) {
                                return Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      // Image.asset('assets/heart_cake.png',
                                      //     fit: BoxFit.cover,
                                      //     width: double.maxFinite),
                                      CachedNetworkImage(
                                          imageUrl: aniversaryCuration
                                              .imageUrls[index]
                                              .replaceFirst('https', 'http'),
                                          fit: BoxFit.cover,
                                          width: double.maxFinite),
                                      Container(
                                          // 그림자
                                          width: double.maxFinite,
                                          height: 240,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                Colors.transparent,
                                                Colors.black.withOpacity(0.5)
                                              ]))),
                                    ]);
                              }),
                          Positioned(
                              bottom: 0,
                              left: 0,
                              child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: MediaQuery.of(context).size.width /
                                      // slideItem.length *
                                      aniversaryCuration.imageUrls.length *
                                      // 5 *
                                      (_currentPage + 1),
                                  height: 4,
                                  color: coral01)),
                          Positioned(
                              left: 27,
                              bottom: 27,
                              child: IgnorePointer(
                                  child: Text(
                                      // '특별한\n크리스마스를 위한 케이크\nD-8',
                                      '${aniversaryCuration.anniversaryTitle}\n${aniversaryCuration.dday}',
                                      style: TextStyle(
                                          height: 1.2,
                                          fontSize: 23,
                                          fontWeight: FontWeight.w800,
                                          color: gray01)))),
                        ]),
                      )),
                  SizedBox(height: verticalGap),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RichText(
                          text: TextSpan(
                              text: '당신',
                              style: TextStyle(
                                  color: coral01,
                                  fontSize: 18,
                                  letterSpacing: -0.5,
                                  fontWeight: FontWeight.w600),
                              children: [
                            TextSpan(
                                text: '을 위한 추천 케이크',
                                style: TextStyle(
                                    color: gray08,
                                    letterSpacing: -0.5,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600))
                          ]))),
                  const SizedBox(height: 16),
                  SizedBox(
                      height: MediaQuery.of(context).size.width * 0.33,
                      child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: recommendCakes.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 11),
                          itemBuilder: (context, index) {
                            return HomeCakeWidget(
                                cakeData: recommendCakes[index], circular: 8);
                            // AspectRatio(
                            //   aspectRatio: 1,
                            //   child: ClipRRect(
                            //       borderRadius: BorderRadius.circular(8),
                            //       child: CachedNetworkImage(
                            //         imageUrl: recommendCakes[index]
                            //             .image
                            //             .s3Url
                            //             .replaceFirst('https', 'http'),
                            //         fit: BoxFit.cover,
                            //       )),
                            //   // Image.asset('assets/heart_cake.png',
                            //   //     fit: BoxFit.cover)),
                            // );
                          })),
                  // MyDivider(padding: 40, height: 6),
                  SizedBox(height: verticalGap),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('실시간 BEST',
                                style: TextStyle(
                                    color: gray08,
                                    fontSize: 18,
                                    letterSpacing: -0.5,
                                    fontWeight: FontWeight.w600)),
                            GestureDetector(
                                onTap: onTapMoreBest,
                                child: Row(children: [
                                  Text('더보기',
                                      style: TextStyle(
                                          color: gray08,
                                          fontSize: 14,
                                          letterSpacing: -0.5,
                                          fontWeight: FontWeight.w400)),
                                  // 화살표
                                  const SizedBox(width: 5),
                                  // SvgPicture.asset('assets/icons/arrow_right.svg'),
                                  FaIcon(FontAwesomeIcons.chevronRight,
                                      size: 12, color: gray08),
                                ])),
                          ])),
                  const SizedBox(height: 16),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width - 40,
                      child: Row(children: [
                        RankedCake(
                            cakeData: bestCakes[0],
                            width: bestCakeWidth,
                            rank: 1),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Column(children: [
                          RankedCake(
                              cakeData: bestCakes[1],
                              width: bestCakeWidth / 2 - 5,
                              rank: 2),
                          const SizedBox(height: 10),
                          RankedCake(
                              cakeData: bestCakes[2],
                              width: bestCakeWidth / 2 - 5,
                              rank: 3),
                        ]))
                      ])),
                  SizedBox(height: verticalGap),
                  Container(
                      decoration: BoxDecoration(
                          // boxShadow: [shadow01],
                          color: gray02,
                          borderRadius: BorderRadius.circular(8)),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 20),
                      width: double.infinity,
                      child: Column(children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('인기 검색어',
                                  style: TextStyle(
                                      color: gray08,
                                      fontSize: 18,
                                      letterSpacing: -0.5,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(width: 7),
                              // 하려면 Expanded 써야함
                              Expanded(
                                child: Text(
                                    // 24시 기준으로 가져오기
                                    '${DateFormat.H().format(DateTime.now())}시 기준',
                                    // 시간 가져오기
                                    style: TextStyle(
                                        color: gray05,
                                        fontSize: 12,
                                        letterSpacing: -0.5,
                                        fontWeight: FontWeight.w600)),
                              ),
                              GestureDetector(
                                  onTap: redirectSearchScreen,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('더보기',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: gray08,
                                                fontSize: 14,
                                                letterSpacing: -0.5,
                                                fontWeight: FontWeight.w400)),
                                        const SizedBox(width: 5),
                                        // SvgPicture.asset('assets/icons/arrow_right.svg'),
                                        FaIcon(FontAwesomeIcons.chevronRight,
                                            size: 12, color: gray08),
                                      ])),
                            ]),
                        const SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Column(children: [
                                  //TODO: 길어지는 경우도 잘 처리하기
                                  HomeKeywordRank(
                                      rank: 1,
                                      keyword: rankList[0].keyword,
                                      // keyword: '너무길어지면어떻게되나요궁금해요',
                                      change: CHANGE.up),
                                  const SizedBox(height: 13),
                                  HomeKeywordRank(
                                      rank: 2,
                                      keyword: rankList[1].keyword,
                                      change: CHANGE.down),
                                ]),
                              ),
                              const SizedBox(width: 30),
                              Flexible(
                                flex: 1,
                                child: Column(children: [
                                  HomeKeywordRank(
                                      rank: 3,
                                      keyword: rankList[2].keyword,
                                      change: CHANGE.none),
                                  const SizedBox(height: 13),
                                  HomeKeywordRank(
                                      rank: 4,
                                      keyword: rankList[3].keyword,
                                      change: CHANGE.up),
                                ]),
                              ),
                            ]),
                      ])),
                  // MyDivider(padding: 40, height: 6),
                  SizedBox(height: verticalGap),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: 'NEW ',
                                    style: TextStyle(
                                        color: coral01,
                                        fontSize: 18,
                                        letterSpacing: -0.5,
                                        fontWeight: FontWeight.w600),
                                    children: [
                                  TextSpan(
                                      text: '케이크 디자인',
                                      style: TextStyle(
                                          color: gray08,
                                          fontSize: 18,
                                          letterSpacing: -0.5,
                                          fontWeight: FontWeight.w600))
                                ])),
                            GestureDetector(
                              onTap: () => context
                                  .pushNamed(InfiniteNewCakeScreen.routeName),
                              child: Row(
                                children: [
                                  Text('더보기',
                                      style: TextStyle(
                                          color: gray08,
                                          fontSize: 14,
                                          letterSpacing: -0.5,
                                          fontWeight: FontWeight.w400)),
                                  // 화살표
                                  const SizedBox(width: 5),
                                  // SvgPicture.asset('assets/icons/arrow_right.svg'),
                                  FaIcon(FontAwesomeIcons.chevronRight,
                                      size: 12, color: gray08),
                                ],
                              ),
                            ),
                          ])),
                  const SizedBox(height: 16),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1,
                    ),
                    children: List.generate(4, (index) {
                      return HomeCakeWidget(
                          cakeData: newCakes[index], circular: 8);
                      // AspectRatio(
                      //     aspectRatio: 1,
                      //     child: ClipRRect(
                      //       borderRadius: BorderRadius.circular(8),
                      //       child: CachedNetworkImage(
                      //           imageUrl: newCakes[index]
                      //               .image
                      //               .s3Url
                      //               .replaceFirst('https', 'http'),
                      //           fit: BoxFit.cover),
                      //       //  Image.asset('assets/heart_cake.png',
                      //       //     fit: BoxFit.cover),
                      //     ));
                    }),
                  ),
                  // 배너
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: GestureDetector(
                        onTap: () => launchUrlString(bannerUrl[2],
                            mode: LaunchMode.externalApplication),
                        child: Image.asset(bannerImageList[2])),
                  ),

                  // VisibilityDetector(
                  //   key: const Key('banner'),
                  //   onVisibilityChanged: _bannerVisibilityChanged,
                  //   child: CarouselSlider(
                  //       carouselController: _bannerController,
                  //       options: CarouselOptions(
                  //         autoPlay: banner_autoPlay,
                  //         viewportFraction: 0.9,
                  //       ),
                  //       items: bannerImageList
                  //           .map((e) => Padding(
                  //                 padding: const EdgeInsets.all(4.0),
                  //                 child: GestureDetector(
                  //                     onTap: () => launchUrlString(
                  //                         bannerUrl[bannerImageList.indexOf(e)],
                  //                         mode: LaunchMode.externalApplication),
                  //                     child: Image.asset(e,
                  //                         width: double.infinity)),
                  //               ))
                  //           .toList()),
                  // ),
                  const SizedBox(height: 30),
                  // 큐레이션 풀어헤친 위젯들

                  for (var curation in curationList) ...[
                    CurationSection(curationData: curation),
                    SizedBox(height: verticalGap),
                  ]
                ]),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('에러'));
            } else if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return RefreshIndicator(
                color: coral01,
                onRefresh: () async {
                  setState(() {
                    fetchHomeData = fetchData();
                  });
                },
                child: ListView(
                  children: [
                    SizedBox(
                      // appbar 높이만큼 빼기
                      // bottom navigation 높이만큼 빼기
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const Center(
                        child: Text(
                          '홈화면 데이터를 불러오는데 실패했습니다.\n화면을 아래로 당겨 새로고침 해주세요.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // print('loading');
              // print(snapshot.connectionState);
              // print(snapshot.hasData);
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class CurationSection extends ConsumerWidget {
  final HomeCurationModel curationData;

  const CurationSection({
    super.key,
    required this.curationData,
  });

  void onTapMore(BuildContext context, WidgetRef ref) {
    context.pushNamed(InfiniteCurationScreen.routeName, extra: {
      'curation_id': curationData.id,
      'curation_description': curationData.description,
    });

    ref.read(analyticsProvider).gaEvent('click_curation', {
      'curation_id': curationData.id,
      // 'curation_description': curationData.description,
      // 'curation_cover_image': cover.s3url,
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(curationData.description,
                      style: TextStyle(
                          color: gray08,
                          fontSize: 18,
                          letterSpacing: -0.5,
                          fontWeight: FontWeight.w600)),
                  GestureDetector(
                    onTap: () => onTapMore(context, ref),
                    child: Row(
                      children: [
                        Text('더보기',
                            style: TextStyle(
                                color: gray08,
                                fontSize: 14,
                                letterSpacing: -0.5,
                                fontWeight: FontWeight.w400)),
                        // 화살표
                        const SizedBox(width: 5),
                        // SvgPicture.asset('assets/icons/arrow_right.svg'),
                        FaIcon(FontAwesomeIcons.chevronRight,
                            size: 12, color: gray08),
                      ],
                    ),
                  ),
                ])),
        const SizedBox(height: 16),
        SizedBox(
            height: MediaQuery.of(context).size.width * 0.33,
            child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: curationData.cakes.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 11),
                itemBuilder: (context, index) {
                  return HomeCakeWidget(
                      cakeData: curationData.cakes[index], circular: 8);
                  // AspectRatio(
                  //   aspectRatio: 1,
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(8),
                  //     child: CachedNetworkImage(
                  //       imageUrl: curationData.cakes[index].image.s3Url
                  //           .replaceFirst('https', 'http'),
                  //       fit: BoxFit.cover,
                  //     ),
                  //     // Image.asset('assets/heart_cake.png',
                  //     //     fit: BoxFit.cover),
                  //   ),
                  // );
                })),
      ],
    );
  }
}

enum CHANGE { up, down, none }

class HomeKeywordRank extends StatelessWidget {
  int rank;
  String keyword;
  CHANGE change;

  HomeKeywordRank({
    super.key,
    required this.rank,
    required this.keyword,
    required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SearchCakeInitailScreen(keyword: keyword)));
      },
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        Text('$rank',
            style: TextStyle(
                color: coral01, fontSize: 14, fontWeight: FontWeight.w700)),
        const SizedBox(width: 7),
        Text(
            // keyword,
            // 너무 길어지는 경우 대비하기
            keyword.length > 10 ? '${keyword.substring(0, 10)}...' : keyword,
            maxLines: 1,
            style: TextStyle(
              color: gray08,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.5,
            )),
        // Expanded(child: Container()),
        // SvgPicture.asset(change == CHANGE.up
        //     ? 'assets/icons/up_rank.svg'
        //     : change == CHANGE.down
        //         ? 'assets/icons/down_rank.svg'
        //         : 'assets/icons/rank.svg'),
      ]),
    );
  }
}

class RankedCake extends StatelessWidget {
  const RankedCake({
    super.key,
    required this.width,
    required this.rank,
    required this.cakeData,
  });

  final double width;
  final int rank;
  final Cake cakeData;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.hardEdge,
        // width: bestCakeWidth / 2 - 5,
        width: width,
        child:
            //  AspectRatio(
            //     aspectRatio: 1,
            //     child:
            //         // Image.asset('assets/heart_cake.png', fit: BoxFit.cover)
            //         CachedNetworkImage(
            //       imageUrl: cakeData.image.s3Url.replaceFirst('https', 'http'),
            //       fit: BoxFit.cover,
            //     ))
            HomeCakeWidget(cakeData: cakeData, circular: 8),
      ),
      Positioned(
          left: 5,
          child: Stack(alignment: Alignment.topCenter, children: [
            SvgPicture.asset('assets/icons/bookclip.svg', width: width * 0.2),
            Padding(
              padding: EdgeInsets.only(top: width * 0.2 * 0.15),
              child: Text('$rank',
                  style: TextStyle(color: gray01, fontSize: width * 0.13)),
            ),
          ])),
    ]);
  }
}
