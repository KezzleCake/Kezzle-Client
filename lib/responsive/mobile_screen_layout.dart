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

  void _onTap(int index) {
    context.go('/${_tabNames[index]}');
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 탭 3개로 줄임
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: homeScreenItems[0],
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: homeScreenItems[3],
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: homeScreenItems[4],
          ),
          // Offstage(
          //   offstage: _selectedIndex != 3,
          //   child: homeScreenItems[3],
          // ),
          // Offstage(
          //   offstage: _selectedIndex != 4,
          //   child: homeScreenItems[4],
          // ),
        ],
      ),
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
          // BottomNavigationBarItem(
          //   icon: SvgPicture.asset(
          //     'assets/tab_icons/map.svg',
          //     colorFilter: ColorFilter.mode(
          //         _selectedIndex == 1 ? Colors.black : Colors.grey,
          //         BlendMode.srcIn),
          //   ),
          // ),
          // BottomNavigationBarItem(
          //   icon: SvgPicture.asset(
          //     'assets/tab_icons/search.svg',
          //     colorFilter: ColorFilter.mode(
          //         _selectedIndex == 2 ? Colors.black : Colors.grey,
          //         BlendMode.srcIn),
          //   ),
          // ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/tab_icons/like.svg',
              colorFilter: ColorFilter.mode(
                  _selectedIndex == 1 ? Colors.black : Colors.grey,
                  BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/tab_icons/profile.svg',
              colorFilter: ColorFilter.mode(
                  _selectedIndex == 2 ? Colors.black : Colors.grey,
                  BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}
