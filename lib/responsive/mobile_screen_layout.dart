import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  // static const routeURL = '/mobile_screen_layout';
  static const routeName = 'mobile_screen_layout';
  final String tab;

  const MobileScreenLayout({super.key, required this.tab});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  final List<String> _tabNames = [
    'home',
    'map',
    'search',
    'favorite',
    'profile',
  ];
  // int _selectedIndex = 0;
  late int _selectedIndex = _tabNames.indexOf(widget.tab);

  //  탭 나타내는거 그지같음 수정해야될 듯.
  //int _page = 0;
  //late PageController pageController;
  void _onTap(int index) {
    context.go('/${_tabNames[index]}');
    setState(() {
      _selectedIndex = index;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   pageController = PageController();
  //   setState(() {});
  // }

  // void navigationTapped(int page) {
  //   pageController.jumpToPage(page);
  // }

  // @override
  // void dispose() {
  //   pageController.dispose();
  //   super.dispose();
  // }

  // void onPageChanged(int page) {
  //   setState(() {
  //     _page = page;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //다른 탭 갔다와도 상태 유지하도록 하려면? Offstage, Stack 이용해보자. -> State를 유지하는 Navigation.
      //탭에서 PageView는 그다지 유용하진 않은 듯?
      // body: PageView(
      //   children: homeScreenItems,
      //   physics: const NeverScrollableScrollPhysics(),
      //   controller: pageController,
      //   onPageChanged: onPageChanged,
      // ),
      body: homeScreenItems[_selectedIndex],

      //다른 탭으로 바꿔야징.
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/tab_icons/home.svg',
              colorFilter: ColorFilter.mode(
                  _selectedIndex == 0 ? Colors.black : Colors.grey,
                  BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/tab_icons/map.svg',
              colorFilter: ColorFilter.mode(
                  _selectedIndex == 1 ? Colors.black : Colors.grey,
                  BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/tab_icons/search.svg',
              colorFilter: ColorFilter.mode(
                  _selectedIndex == 2 ? Colors.black : Colors.grey,
                  BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/tab_icons/like.svg',
              colorFilter: ColorFilter.mode(
                  _selectedIndex == 3 ? Colors.black : Colors.grey,
                  BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/tab_icons/profile.svg',
              colorFilter: ColorFilter.mode(
                  _selectedIndex == 4 ? Colors.black : Colors.grey,
                  BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}
