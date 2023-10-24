import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/utils/colors.dart';
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
    'search_around',
    // 'map',
    // 'search',
    'favorite',
    'profile',
  ];
  // int _selectedIndex = 0;
  Color selectedColor = coral01;
  late int _selectedIndex = _tabNames.indexOf(widget.tab);

  void _onTap(int index) {
    context.go('/${_tabNames[index]}');
    // setState(() {
    //   _selectedIndex = index;
    // });
    _selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: homeScreenItems[0],
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: homeScreenItems[1],
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: homeScreenItems[2],
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: homeScreenItems[3],
          ),
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
            icon:
                // SvgPicture.asset(
                //   'assets/tab_icons/home.svg',
                //   colorFilter: ColorFilter.mode(
                //       _selectedIndex == 0 ? selectedColor : Colors.grey,
                //       BlendMode.srcIn),
                // ),
                FaIcon(
              FontAwesomeIcons.house,
              size: 24,
              color: _selectedIndex == 0 ? selectedColor : Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.locationDot,
              size: 24,
              color: _selectedIndex == 1 ? selectedColor : Colors.grey,
            ),
            // SvgPicture.asset(
            //   'assets/tab_icons/map.svg',
            //   colorFilter: ColorFilter.mode(
            //       _selectedIndex == 1 ? Colors.black : Colors.grey,
            //       BlendMode.srcIn),
            // ),
          ),
          // BottomNavigationBarItem(
          //   icon: SvgPicture.asset(
          //     'assets/tab_icons/search.svg',
          //     colorFilter: ColorFilter.mode(
          //         _selectedIndex == 2 ? Colors.black : Colors.grey,
          //         BlendMode.srcIn),
          //   ),
          // ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.solidHeart,
              size: 24,
              color: _selectedIndex == 2 ? selectedColor : Colors.grey,
            ),
            // SvgPicture.asset(
            //   'assets/tab_icons/like.svg',
            //   colorFilter: ColorFilter.mode(
            //       _selectedIndex == 2 ? selectedColor : Colors.grey,
            //       BlendMode.srcIn),
            // ),
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.solidCircleUser,
              size: 24,
              color: _selectedIndex == 3 ? selectedColor : Colors.grey,
            ),
            // SvgPicture.asset(
            //   'assets/tab_icons/profile.svg',
            //   colorFilter: ColorFilter.mode(
            //       _selectedIndex == 3 ? selectedColor : Colors.grey,
            //       BlendMode.srcIn),
            // ),
          ),
        ],
      ),
    );
  }
}
