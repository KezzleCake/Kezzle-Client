import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kezzle/screens/store/introduce_store_tabview.dart';
import 'package:kezzle/screens/store/store_location_screen.dart';
// import 'package:kezzle/screens/store/store_price_tabview.dart';
// import 'package:kezzle/screens/store/store_review_screen.dart';
import 'package:kezzle/utils/colors.dart';

final tabs = [
  // '가격',
  '케이크',
  '가게 소개',
  '상세 위치',
  // '리뷰',
];

class DetailStoreScreen extends StatelessWidget {
  static const routeURL = '/detail_store';
  static const routeName = 'detail_store';
  final int storeId;

  const DetailStoreScreen({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('스토어'), actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/share.svg'),
          ),
        ]),
        body: DefaultTabController(
            length: tabs.length,
            child: Column(children: [
              _defaultStoreInfo(),
              _tabBar(),
              Expanded(child: _tabBarView()),
            ])));
  }

  Widget _tabBar() => TabBar(
      splashFactory: NoSplash.splashFactory,
      labelColor: coral01,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      unselectedLabelColor: gray05,
      unselectedLabelStyle:
          const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      indicator: BoxDecoration(
          border: Border(bottom: BorderSide(color: coral01, width: 2))),
      tabs: [for (var tab in tabs) Tab(text: tab)]);

  Widget _tabBarView() =>
      TabBarView(physics: const NeverScrollableScrollPhysics(), children: [
        // const StorePrice(),
        StoreCakes(),
        const IntroduceStore(),
        StoreLocation(),
        // StoreReview(),
      ]);

  Widget _defaultStoreInfo() => Padding(
      padding: const EdgeInsets.all(20),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const CircleAvatar(
            radius: 63 / 2,
            backgroundImage: AssetImage('assets/heart_cake.png')),
        const SizedBox(width: 8),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('블리스 케이크',
              style: TextStyle(
                fontSize: 16,
                color: gray08,
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(height: 3),
          Row(children: [
            FaIcon(FontAwesomeIcons.solidStar, size: 14, color: orange01),
            const SizedBox(width: 3),
            Text('4.5(100+)',
                style: TextStyle(
                  fontSize: 12,
                  color: gray07,
                  fontWeight: FontWeight.w600,
                )),
          ]),
          const SizedBox(height: 8),
          Text('블리스 케이크 만의 무드를 담은 케이크로 소중한 날을 더욱 특별하게 만들어드려요 :)',
              maxLines: 2,
              overflow: TextOverflow.clip,
              style: TextStyle(
                  fontSize: 12, color: gray06, fontWeight: FontWeight.w400)),
          const SizedBox(height: 16),
          const Row(children: [
            FaIcon(FontAwesomeIcons.instagram),
            SizedBox(width: 13),
            FaIcon(FontAwesomeIcons.comment),
          ]),
        ])),
        Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Column(children: [
              SvgPicture.asset('assets/icons/like=on.svg'),
              Text('55',
                  style: TextStyle(
                      fontSize: 12,
                      color: coral01,
                      fontWeight: FontWeight.w600)),
            ])),
      ]));
}

class StoreCakes extends StatefulWidget {
  StoreCakes({super.key});

  @override
  State<StoreCakes> createState() => _StoreCakesState();
}

class _StoreCakesState extends State<StoreCakes> {
  bool isLike = false;
  // int selectedKeywordIndex = 0;
  // final List<String> keywords = [
  //   '전체',
  //   '생일',
  //   '커플',
  //   '아이',
  //   '기념일',
  //   '기타',
  //   '곰돌이',
  //   '레터링',
  //   '꽃',
  // ];

  //버튼 누르면 선택된 인덱스를 바꾸는 함수
  // void onTapKeyword(int index) {
  //   setState(() {
  //     selectedKeywordIndex = index;
  //   });
  // }

  void onTapLike() {
    setState(() {
      isLike = !isLike;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // const SizedBox(height: 30),
      // SizedBox(
      //     height: 30,
      //     child: ListView.separated(
      //         itemCount: keywords.length,
      //         padding: const EdgeInsets.symmetric(horizontal: 20),
      //         scrollDirection: Axis.horizontal,
      //         separatorBuilder: (context, index) => const SizedBox(width: 8),
      //         itemBuilder: (context, index) => GestureDetector(
      //               //누르면 선택된 인덱스를 바꾸는 함수
      //               onTap: () => onTapKeyword(index),
      //               child: AnimatedContainer(
      //                   duration: const Duration(milliseconds: 100),
      //                   alignment: Alignment.center,
      //                   padding: const EdgeInsets.symmetric(
      //                       vertical: 4, horizontal: 10),
      //                   decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(16),
      //                       color: index == selectedKeywordIndex
      //                           ? coral01
      //                           : coral04),
      //                   child: Text(keywords[index],
      //                       style: TextStyle(
      //                           fontSize: 14,
      //                           color: index == selectedKeywordIndex
      //                               ? Colors.white
      //                               : coral01,
      //                           fontWeight: FontWeight.w600))),
      //             ))),
      // const SizedBox(height: 16),
      Flexible(
          child: GridView.builder(
        itemCount: 20,
        padding: const EdgeInsets.only(
          top: 16,
          left: 20,
          right: 20,
          bottom: 40,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), boxShadow: [shadow01]),
            clipBehavior: Clip.hardEdge,
            child: Stack(alignment: Alignment.bottomRight, children: [
              Image.asset('assets/heart_cake.png', fit: BoxFit.cover),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: onTapLike,
                    child: Stack(children: [
                      isLike
                          ? SvgPicture.asset('assets/icons/like=on_in.svg')
                          : SvgPicture.asset('assets/icons/like=off_in.svg'),
                      SvgPicture.asset('assets/icons/like=off.svg',
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcATop,
                          )),
                    ]),
                  )),
            ])),
      )),
    ]);
  }
}
