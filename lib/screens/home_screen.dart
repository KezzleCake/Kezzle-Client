import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kezzle/screens/detail_cake_screen.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/widgets/calendar_widget.dart';
import 'package:kezzle/widgets/curation_box_widget.dart';
import 'package:kezzle/widgets/location_setting_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final CarouselController _carouselController = CarouselController();

  // 상단 슬라이드에 들어갈 사진과, 글귀
  final List<String> slideItem = [
    'assets/heart_cake.png',
    'assets/smile_cake.png',
    'assets/heart_cake.png',
  ];
  int _currentPage = 0;

  bool autoplay = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void imageTapped(BuildContext context, String imageUrl) {
    //print('image tapped');
    //이미지 상세보기 화면으로 이동
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailCakeScreen(imageUrl: imageUrl),
      ),
    );
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentPage = index;
    });
  }

  // 슬라이드가 보이는지 안보이는지 체크 (보이면 자동재생, 안보이면 멈춤)
  void _slideVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 0) {
      setState(() {
        autoplay = false;
      });
    } else {
      setState(() {
        autoplay = true;
      });
    }
  }

  void _onTapLocation(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          // return const CalendarWidget();
          return const LocationSettingWidget();
        });
  }

  void _onTapPickUpDate(BuildContext context) async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (context) {
        return const CalendarWidget();
      },
    );
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Row(children: [
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {},
                child: GestureDetector(
                  onTap: () => _onTapLocation(context),
                  child: Row(children: [
                    Text('서울 강남구 테헤란로',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: gray08)),
                    SvgPicture.asset('assets/icons/arrow-down.svg',
                        colorFilter: ColorFilter.mode(gray07, BlendMode.srcIn))
                  ]),
                ),
              ),
              Row(children: [
                const Text('2km',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                SvgPicture.asset('assets/icons/arrow-down.svg',
                    colorFilter: ColorFilter.mode(gray07, BlendMode.srcIn)),
              ]),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () => _onTapPickUpDate(context),
                child: Row(children: [
                  SvgPicture.asset('assets/icons/calendar.svg',
                      width: 14,
                      colorFilter: ColorFilter.mode(coral01, BlendMode.srcIn)),
                  const SizedBox(width: 3),
                  Text('1.1 (월) ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: gray06)),
                  // Text('오후 1:01',
                  //     style: TextStyle(
                  //         fontSize: 12, fontWeight: FontWeight.w600, color: gray06)),
                ]),
              ),
              Text('오후 1:01',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: gray06)),
            ]),
          ),
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
                    autoPlay: autoplay,
                    autoPlayInterval: const Duration(seconds: 2),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return Stack(alignment: Alignment.bottomCenter, children: [
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
                      Positioned(
                        left: 40,
                        bottom: 40,
                        child: Text('특별한\n크리스마스를 위한 케이크\nD-8',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                color: gray01)),
                      ),
                    ]);
                  },
                ),
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
              ]),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: '김혜연',
                      style: TextStyle(
                          fontFamily: 'Pretendard',
                          color: coral01,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                  TextSpan(
                      text: '님을 위한 추천 케이크',
                      style: TextStyle(
                          fontFamily: 'Pretendard',
                          color: gray08,
                          fontSize: 18,
                          fontWeight: FontWeight.w600))
                ]),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 160,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return RecommedBoxWidget(
                    imageUrl: 'assets/heart_cake.png',
                    onTap: () => imageTapped(context, 'assets/heart_cake.png'),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('인기 Top10 케이크',
                        style: TextStyle(
                            color: gray08,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                    Text('더보기',
                        style: TextStyle(
                            color: gray05,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
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
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return RecommedBoxWidget(
                      imageUrl: 'assets/heart_cake.png',
                      onTap: () =>
                          imageTapped(context, 'assets/heart_cake.png'),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 40),
              child: Text('상황별 BEST',
                  style: TextStyle(
                      color: gray08,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
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
            const SizedBox(height: 40),
          ]),
        ),
        // ModalBarrier(
        //   color: Colors.black.withOpacity(0.5),
        //   dismissible: true,
        // ),
      ],
    );
  }
}

class RecommedBoxWidget extends StatelessWidget {
  final String imageUrl;
  final Function onTap;

  const RecommedBoxWidget({
    super.key,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [shadow01],
      ),
      child: Stack(children: [
        GestureDetector(
            onTap: () => onTap(),
            child: Image(
                image: AssetImage(
              imageUrl,
            ))),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
              padding: const EdgeInsets.all(12),
              child: Stack(children: [
                SvgPicture.asset('assets/icons/like=off_in.svg',
                    width: 24,
                    colorFilter: ColorFilter.mode(gray05, BlendMode.srcIn)),
                SvgPicture.asset('assets/icons/like=off.svg',
                    width: 24,
                    colorFilter: ColorFilter.mode(gray01, BlendMode.srcIn)),
              ])),
        ),
      ]),
    );
  }
}
