import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kezzle/features/cake_search/search_cake_initial_screen.dart';
import 'package:kezzle/screens/more_curation_screen.dart';
import 'package:kezzle/screens/search_similar_cake_screen.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/widgets/curation_box_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CurationHomeScreen extends StatefulWidget {
  const CurationHomeScreen({super.key});

  @override
  State<CurationHomeScreen> createState() => _CurationHomeScreenState();
}

class _CurationHomeScreenState
    extends State<CurationHomeScreen> /*with SingleTickerProviderStateMixin*/ {
  final CarouselController _carouselController = CarouselController();

  // 상단 슬라이드에 들어갈 사진과 텍스트
  final List<String> slideItem = [
    'assets/heart_cake.png',
    'assets/smile_cake.png',
    'assets/heart_cake.png',
  ];
  // 현재 슬라이드 페이지
  int _currentPage = 0;
  // 자동 슬라이드 여부
  bool autoPlay = false;

  void slideTapped() {
    // 슬라이드 이미지 선택 시..
  }

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

  void onTapTop10Cake() {
    // 상단 Top10 케이크 선택 시..
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const SearchSimilarCakeScreen()));
  }

  void onTapMore() {
    // 더보기 선택 시..
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MoreCurationScreen()));
  }

  void onTapSearch() {
    // 검색 아이콘 선택 시..
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const SearchCakeInitailScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset('assets/Kezzle.svg', width: 96),
                  GestureDetector(
                    onTap: onTapSearch,
                    child: SvgPicture.asset(
                      'assets/tab_icons/search.svg',
                      width: 26,
                      colorFilter:
                          const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                    ),
                  ),
                ])),
        body: ListView(children: [
          VisibilityDetector(
              key: const Key('carousel'),
              onVisibilityChanged: _slideVisibilityChanged,
              child: Stack(children: [
                CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: slideItem.length,
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
                                child: Image(
                                    // height: 340,
                                    image: AssetImage(slideItem[index]),
                                    width: double.maxFinite,
                                    // width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover)),
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
                                      ]),
                                )),
                          ]);
                    }),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: MediaQuery.of(context).size.width /
                          slideItem.length *
                          (_currentPage + 1),
                      height: 4,
                      color: coral01),
                ),
                Positioned(
                  left: 40,
                  bottom: 40,
                  child: Text('특별한\n크리스마스를 위한 케이크\nD-8',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: gray01)),
                ),
              ])),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('인기 Top20 케이크',
                      style: TextStyle(
                          color: gray08,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                  GestureDetector(
                    onTap: onTapMore,
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
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: onTapTop10Cake,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [shadow01],
                      ),
                      child: Image.asset('assets/heart_cake.png'),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 30),
            child: Text('상황별 BEST',
                style: TextStyle(
                    color: gray08, fontSize: 18, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 16),
          SizedBox(
              height: 180, //이거 나중에 비율 화면에 맞게 조절해야할 거 같긴 함.
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    return const CurationBoxWidget(
                        imageUrl: 'assets/heart_cake.png',
                        title: '일년에 하나 뿐인\n생일을 축하하며',
                        color: Color(0xffFFB8B8));
                  })),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 30),
            child: Text('받는 사람을 위한 케이크',
                style: TextStyle(
                    color: gray08, fontSize: 18, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 16),
          SizedBox(
              height: 180, //이거 나중에 비율 화면에 맞게 조절해야할 거 같긴 함.
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    return const CurationBoxWidget(
                        imageUrl: 'assets/heart_cake.png',
                        title: '꿈과 판타지가\n가득한 자녀에게',
                        color: Color(0xffFFB8B8));
                  })),
          const SizedBox(height: 30),
        ]));
  }
}
