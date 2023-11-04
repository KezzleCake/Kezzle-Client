import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/analytics/analytics.dart';
import 'package:kezzle/features/cake_search/search_cake_initial_screen.dart';
import 'package:kezzle/models/curation_model.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/curation_repo.dart';
import 'package:kezzle/screens/infinite_anniversary_screen.dart';
import 'package:kezzle/screens/infinite_popular_cake_screen.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/view_models/id_token_provider.dart';
import 'package:kezzle/widgets/curation_box_widget.dart';
import 'package:kezzle/widgets/home_cake_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CurationHomeScreen extends ConsumerStatefulWidget {
  const CurationHomeScreen({super.key});

  @override
  CurationHomeScreenState createState() => CurationHomeScreenState();
}

class CurationHomeScreenState extends ConsumerState<CurationHomeScreen>
    with SingleTickerProviderStateMixin {
  final CarouselController _carouselController = CarouselController();
  final CarouselController _bannerController = CarouselController();
  // late Future<List<Cake>> fetchPopularCakes;
  late Future<Map<String, dynamic>> fetchCurations;
  List<List<Color>> colors = [
    [const Color(0xffFFB8B8), const Color(0xffB67272)],
    [const Color(0xFFE8B8FF), const Color(0xFF9E76B1)],
    [const Color(0xFFFFE7B8), const Color(0xFF96825C)],
    [const Color(0xFFB8D0FF), const Color(0xFF5376BB)],
    [const Color(0xFFFFCDB8), const Color(0xFFF3936B)],
    [const Color(0xffFFB8B8), const Color(0xffB67272)],
    [const Color(0xFFFFE7B8), const Color(0xFF96825C)],
    [const Color(0xFFE8B8FF), const Color(0xFF9E76B1)],
  ];

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

  @override
  void initState() {
    // fetchPopularCakes = fetchTop10Cakes(ref);
    // print('inithome');

    //completer로 fetxhCuration 끝나면 팝업 띄우기
    super.initState();
    fetchCurations = fetchHomeCurations();
    fetchCurations.then((_) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (sharedPreferences.getBool('isShowPopUp') == null ||
          sharedPreferences.getBool('isShowPopUp') == true) {
        // _showPopup(context);
        popUpTest();
      }
    });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // 화면이 다 그려진 후에 실행되는 코드
    //   popUpTest();
    // });
  }

  // 현재 슬라이드 페이지
  int _currentPage = 0;
  // 자동 슬라이드 여부
  bool autoPlay = false;
  bool banner_autoPlay = false;
  late String anniversaryId;

  void onTapSlide(AniversaryCurationModel aniversaryCuration) {
    // 슬라이드 이미지 선택 시..

    // context.pushNamed(MoreCurationScreen.routeName, extra: {
    //   'title': aniversaryCuration.anniversaryTitle,
    //   'fetchCakes': fetchAnniversaryCakes,
    // });
    context.pushNamed(InfiniteAnniversaryScreen.routeName, extra: {
      'curation_id': anniversaryId,
      'curation_description': aniversaryCuration.anniversaryTitle,
    });

    ref.read(analyticsProvider).gaEvent('click_curation', {
      'anniversary_id': anniversaryId,
      'curation_description': 'anniversary',
    });
  }

  // Future<List<Cake>> fetchAnniversaryCakes(WidgetRef ref) async {
  //   //케이크 정보 가져오기
  //   List<Cake> cakes = [];
  //   final response = await ref
  //       .read(curationRepo)
  //       .fetchAnniversaryCakes(curationId: anniversaryId);
  //   print(anniversaryId);
  //   if (response != null) {
  //     // print(response);
  //     response['cakes'].forEach((cake) {
  //       cakes.add(Cake.fromJson(cake));
  //     });
  //     return cakes;
  //   } else {
  //     return [];
  //   }
  // }

  void onPageChanged(int index, CarouselPageChangedReason reason) {
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
  void _bannerVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 0) {
      if (mounted) {
        setState(() {
          banner_autoPlay = false;
        });
      }
    } else {
      setState(() {
        banner_autoPlay = true;
      });
    }
  }

  void onTapMore() {
    // 더보기 선택 시..
    // context.pushNamed(
    //   MoreCurationScreen.routeName,
    //   extra: {
    //     'title': '인기 Top20 케이크',
    //     'fetchCakes': null,
    //     'initailCakes': popularCakes,
    //   },
    // );
    context.pushNamed(InfinitePopularCakeScreen.routeName, extra: {
      'curation_id': 'popular',
      'curation_description': '인기 Top100 케이크',
    });

    ref.read(analyticsProvider).gaEvent('click_more_popular', {
      'curation_id': 'popular',
      'curation_description': '인기 Top100 케이크',
    });
  }

  Future<Map<String, dynamic>> fetchHomeCurations() async {
    final response = await ref.read(curationRepo).fetchCurations();
    return response;
  }

  void onTapSearch() {
    // 검색 아이콘 선택 시..
    context.pushNamed(SearchCakeInitailScreen.routeName);
  }

  void popUpTest() async {
    //TODO: 두번씩 호출되는거 어쩔거야..

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Column(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => launchUrlString(
                    'https://forms.gle/Y6SV3LvCMUvvi4xE8',
                    mode: LaunchMode.externalApplication,
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      clipBehavior: Clip.hardEdge,
                      width: MediaQuery.of(context).size.width - 55,
                      // height: 475,
                      child: Image.asset('assets/event/store_event.png')),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 27.5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () async {
                                // shared 값 변경
                                //TODO: shared 쓰는 방식 고치기, 값저장하는거 고치기
                                final sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.setBool('isShowPopUp', false);
                                // Navigator.pop(context);
                                if (!mounted) return;
                                context.pop();
                              },
                              child: Row(
                                children: [
                                  FaIcon(FontAwesomeIcons.circleCheck,
                                      size: 15, color: gray01),
                                  const SizedBox(width: 5),
                                  Text(
                                    '다시 보지 않기',
                                    style: TextStyle(
                                        color: gray01,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                          TextButton(
                              onPressed: () async {
                                // Navigator.pop(context);
                                // shared 값 변경
                                //TODO: shared 쓰는 방식 고치기, 값저장하는거 고치기
                                final sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.setBool('isShowPopUp', false);
                                // Navigator.pop(context);
                                if (!mounted) return;
                                context.pop();
                              },
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '닫기',
                                      style: TextStyle(
                                          color: gray01,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(width: 5),
                                    FaIcon(FontAwesomeIcons.circleXmark,
                                        size: 15, color: gray01)
                                  ])),
                        ])),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //TODO: 나중에 지우기
            GestureDetector(
              onTap: () {
                print('dd??');
                var token = ref.read(tokenProvider).value!.token;
                log(token.toString());
              },
              child: SvgPicture.asset(
                'assets/Kezzle.svg',
                width: 95,
                colorFilter: ColorFilter.mode(coral01, BlendMode.srcIn),
              ),
            ),
            GestureDetector(
              onTap: onTapSearch,
              child: FaIcon(FontAwesomeIcons.magnifyingGlass,
                  size: 23, color: gray08),
            ),
          ])),
      body: FutureBuilder<Map<String, dynamic>?>(
          future: fetchCurations,
          // future: _popupCompleter.future,
          builder: (context, snapshot) {
            if (
                // snapshot.hasData
                snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
              // WidgetsBinding.instance.addPostFrameCallback((_) {
              //   // 화면이 다 그려진 후에 실행되는 코드
              //   popUpTest();
              // });

              final rawData = snapshot.data;
              final aniversaryCuration = rawData != null
                  ? AniversaryCurationModel.fromJson(
                      snapshot.data!['anniversary'])
                  : null; //TODO: null 넘어오는 것 체크

              if (aniversaryCuration == null) {
                return const Center(
                  child: Text('데이터 로딩 실패'),
                );
              }

              final List<Cake> popularCakes = [];
              anniversaryId = aniversaryCuration.id;
              snapshot.data!['popular']['cakes'].forEach((cake) {
                popularCakes.add(Cake.fromJson(cake));
              });
              final List<CurationModel> curations = [];
              snapshot.data!['show'].forEach((curation) {
                curations.add(CurationModel.fromJson(curation));
              });

              return ListView(children: [
                const SizedBox(height: 8),
                VisibilityDetector(
                    key: const Key('carousel'),
                    onVisibilityChanged: _slideVisibilityChanged,
                    child: GestureDetector(
                      onTap: () => onTapSlide(aniversaryCuration),
                      child: Stack(children: [
                        CarouselSlider.builder(
                            carouselController: _carouselController,
                            // itemCount: slideItem.length,
                            itemCount: aniversaryCuration.imageUrls.length,
                            options: CarouselOptions(
                              onPageChanged: (index, reason) =>
                                  onPageChanged(index, reason),
                              reverse: false,
                              height: 340,
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
                                    GestureDetector(
                                        child: CachedNetworkImage(
                                      imageUrl: aniversaryCuration
                                          .imageUrls[index]
                                          .replaceFirst('https', 'http'),
                                      fit: BoxFit.cover,
                                      width: double.maxFinite,
                                    )),
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
                                    (_currentPage + 1),
                                height: 4,
                                color: coral01)),
                        Positioned(
                            left: 40,
                            bottom: 40,
                            child: IgnorePointer(
                                child: Text(
                                    // '특별한\n크리스마스를 위한 케이크\nD-8',
                                    '${aniversaryCuration.anniversaryTitle}\n${aniversaryCuration.dday}',
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w800,
                                        color: gray01)))),
                      ]),
                    )),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('인기 Top100 케이크',
                            style: TextStyle(
                                color: gray08,
                                fontSize: 18,
                                fontWeight: FontWeight.w600)),
                        GestureDetector(
                          onTap: () => onTapMore(),
                          child: Text('더보기',
                              style: TextStyle(
                                  color: gray05,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ]),
                ),
                const SizedBox(height: 16),
                SizedBox(
                    // width: MediaQuery.of(context).size.width,
                    height: 160,
                    child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        scrollDirection: Axis.horizontal,
                        // itemCount: 5,
                        itemCount: popularCakes.length,
                        itemBuilder: (context, index) {
                          return HomeCakeWidget(cakeData: popularCakes[index]);
                        })),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 20, top: 30),
                      child: Text(
                          // '상황별 BESddT',
                          curations[0].note,
                          style: TextStyle(
                              color: gray08,
                              fontSize: 18,
                              fontWeight: FontWeight.w600))),
                  const SizedBox(height: 16),
                  SizedBox(
                      height: 180, //이거 나중에 비율 화면에 맞게 조절해야할 거 같긴 함.
                      child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          // itemCount: 3,
                          itemCount: curations[0].curationCoverModelList.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            return CurationBoxWidget(
                              colors: colors[index % 4],
                              cover: curations[0].curationCoverModelList[index],
                            );
                          })),
                  Padding(
                      padding: const EdgeInsets.only(left: 20, top: 30),
                      child: Text(
                          // '받는 사람을 위한 dd케이크',
                          curations[1].note,
                          style: TextStyle(
                              color: gray08,
                              fontSize: 18,
                              fontWeight: FontWeight.w600))),
                  const SizedBox(height: 16),
                  SizedBox(
                      height: 180, //이거 나중에 비율 화면에 맞게 조절해야할 거 같긴 함.
                      child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          // itemCount: 3,
                          itemCount: curations[1].curationCoverModelList.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            return CurationBoxWidget(
                                // color: const Color(0xFFE8B8FF),
                                colors: colors[index % 4 + 4],
                                // colors: colors[index + 4],
                                cover:
                                    curations[1].curationCoverModelList[index]);
                          })),
                  // const SizedBox(height: 10),
                  // Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 10,
                  //     ),
                  //     child: Column(children: [
                  //       GestureDetector(
                  //         onTap: () {
                  //           // TODO: 이벤트 심기
                  //           launchUrlString(
                  //               'https://forms.gle/Y6SV3LvCMUvvi4xE8',
                  //               mode: LaunchMode.externalApplication);
                  //         },
                  //         child: Image.asset('assets/event/사장님배너.png',
                  //             width: double.infinity),
                  //       ),
                  //       const SizedBox(height: 12),
                  //       GestureDetector(
                  //           onTap: () {
                  //             // TODO: 이벤트 심기
                  //             launchUrlString(
                  //               'https://forms.gle/wztk59iVxkYPDhtL8',
                  //               mode: LaunchMode.externalApplication,
                  //             );
                  //           },
                  //           child: Image.asset('assets/event/스벅배너.png',
                  //               width: double.infinity)),
                  //       const SizedBox(height: 16),
                  //     ])),
                  Stack(children: [
                    VisibilityDetector(
                      key: const Key('banner'),
                      onVisibilityChanged: _bannerVisibilityChanged,
                      child: CarouselSlider(
                          carouselController: _bannerController,
                          options: CarouselOptions(
                            autoPlay: banner_autoPlay,
                            viewportFraction: 0.85,
                            // onPageChanged: (index, reason) => setState(() {
                            //   _currentBannerPage = index;
                            // }),
                          ),
                          //TODO: 이벤트 페이지 url 넣기
                          items: bannerImageList
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                        onTap: () => launchUrlString(
                                            bannerUrl[
                                                bannerImageList.indexOf(e)],
                                            mode:
                                                LaunchMode.externalApplication),
                                        child: Image.asset(e,
                                            width: double.infinity)),
                                  ))
                              .toList()),
                    ),
                    // Positioned(
                    //   bottom: 45,
                    //   // bottom: 0,
                    //   left: 0,
                    //   right: 0,
                    //   child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: bannerImageList.asMap().entries.map((e) {
                    //         return GestureDetector(
                    //             onTap: () =>
                    //                 _bannerController.animateToPage(e.key),
                    //             child: Container(
                    //                 width: 8,
                    //                 height: 8,
                    //                 margin: const EdgeInsets.symmetric(
                    //                     horizontal: 4),
                    //                 decoration: BoxDecoration(
                    //                   shape: BoxShape.circle,
                    //                   border: Border.all(
                    //                       color: _currentBannerPage == e.key
                    //                           ? coral01
                    //                           : coral04,
                    //                       width: 1),
                    //                   color: _currentBannerPage == e.key
                    //                       ? coral01
                    //                       : gray01,
                    //                 )));
                    //       }).toList()),
                    // )
                  ]),
                ]),
              ]);
            } else if (snapshot.hasError) {
              // 에러 있는 경우?
              return const Center(child: Text('에러'));
            } else {
              return const Center(child: CircularProgressIndicator());
              // return const Center(child: Text('에러'));
            }
          }),
    );
  }
}
