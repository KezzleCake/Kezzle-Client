import 'package:flutter/material.dart';
import 'package:kezzle/features/bookmark/bookmark_screen.dart';
import 'package:kezzle/features/profile/user_screen.dart';
// import 'package:kezzle/features/store_search/search_store_screen.dart';
import 'package:kezzle/screens/curation_home_screen.dart';
import 'package:kezzle/screens/final_home_screen.dart';
import 'package:kezzle/screens/home_screen.dart';
// import 'package:kezzle/features/cake_search/search_cake_initial_screen.dart';

List<Widget> homeScreenItems = [
  // const HomeScreen(),
  // const CurationHomeScreen(),
  const FinalHomeScreen(),
  // const SearchStore(),
  const SearchAroundScreen(),
  // Placeholder(),
  // const SearchCakeInitailScreen(),
  BookmarkScreen(),
  const UserScreen(),
];
