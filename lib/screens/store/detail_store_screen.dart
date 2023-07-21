import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kezzle/screens/store/introduce_store_tabview.dart';
import 'package:kezzle/screens/store/store_location_screen.dart';
import 'package:kezzle/screens/store/store_price_tabview.dart';
import 'package:kezzle/screens/store/store_review_screen.dart';
import 'package:kezzle/utils/colors.dart';

final tabs = ['가격', '가게 소개', '상세 위치', '리뷰'];

class DetailStoreScreen extends StatelessWidget {
  const DetailStoreScreen({super.key});

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
        const StorePrice(),
        const IntroduceStore(),
        const StoreLocation(),
        StoreReview(),
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
