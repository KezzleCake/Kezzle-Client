import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/authentication/login_screen.dart';
import 'package:kezzle/features/authentication/make_user_screen.dart';
import 'package:kezzle/features/cake_search/search_cake_initial_screen.dart';
import 'package:kezzle/features/onboarding/current_location_screen.dart';
// import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
// import 'package:kezzle/features/onboarding/current_location_screen.dart';
// import 'package:kezzle/features/onboarding/initail_setting_screen.dart';
import 'package:kezzle/features/profile/change_profile_screen.dart';
import 'package:kezzle/features/serch_similar_cake/search_similar_cake_screen.dart';
// import 'package:kezzle/features/profile/repos/user_repo.dart';
import 'package:kezzle/features/splash/splash_screen.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/responsive/mobile_screen_layout.dart';
import 'package:kezzle/screens/authorization_check_screen.dart';
import 'package:kezzle/screens/detail_cake_screen.dart';
import 'package:kezzle/screens/more_curation_screen.dart';
import 'package:kezzle/screens/store/detail_store_screen.dart';

import 'features/onboarding/initail_setting_screen.dart';

// final dbExistProvider = StateProvider<bool>((ref) {
//   return false;
// });

final routerProvider = Provider((ref) {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  return GoRouter(
    observers: [FirebaseAnalyticsObserver(analytics: analytics)],
    // initialLocation: Platform.isAndroid ? "/splash" : "/home",
    initialLocation:
        Platform.isAndroid ? "/splash" : "/authorization_check_screen",

    // initialLocation: "/splash",
    // initialLocation: "/current_location_screen",
    // redirect: (context, state) async {
    //   // 로그인 했는 지 확인하고 안했으면 로그인 화면으로 이동.
    //   final isLoggedIn = ref.watch(authRepo).isLoggedIn;
    //   // 파이어베이스도 로그인도 안됐으면 로그인 화면으로
    //   if (!isLoggedIn && state.location == "/home") {
    //     if (state.location != "/login") {
    //       return LoginScreen.routeURL;
    //     }
    //   } else {
    //     if (ref.watch(dbExistProvider) == false) {
    //       print('프로필 정보 없음');
    //       // 로그인 됐으면 프로필 정보 가져오기
    //       final User user = ref.watch(authRepo).user!;
    //       final response = await ref.read(authRepo).fetchProfile(user);
    //       if (response != null) {
    //         ref.watch(dbExistProvider.notifier).state = true;
    //       }
    //       if (response == null && state.location == "/home" && isLoggedIn) {
    //         if (state.location != "/make_user") {
    //           return MakeUserScreen.routeURL;
    //         }
    //       }
    //     }
    //   }
    // if (ref.watch(dbExistsProvider) == false) {
    //   print('프로필 정보 없음');
    //   // 로그인 됐으면 프로필 정보 가져오기
    //   final User user = ref.watch(authRepo).user!;
    //   final response = await ref.read(authRepo).fetchProfile(user);
    //   if (response != null) {
    //     ref.read(dbExistsProvider.notifier).state = true;
    //   }
    //   if (response == null && state.location == "/home" && isLoggedIn) {
    //     if (state.location != "/make_user") {
    //       return MakeUserScreen.routeURL;
    //     }
    //   }
    // }
    // }
    // // 로그인 됐으면 프로필 정보 가져오기
    // final User user = ref.watch(authRepo).user!;
    // final response = await ref.read(authRepo).fetchProfile(user);
    // // 이거 계속 요청하는거 너무 비효율적이다..ㅠㅠ
    // print('로그인 후 프로필 정보');
    // print(response);
    // if (response == null && state.location == "/home" && isLoggedIn) {
    //   if (state.location != "/make_user") {
    //     return MakeUserScreen.routeURL;
    //   }
    // }
    // return null;
    // },
    routes: [
      // 스플래시 화면 라우팅 설정
      GoRoute(
        name: SplashScreen.routeName,
        path: SplashScreen.routeURL,
        builder: (context, state) => const SplashScreen(),
      ),
      // 권한 설정 화면 라우팅 설정
      GoRoute(
        name: AuthorizationCheckScreen.routeName,
        path: AuthorizationCheckScreen.routeURL,
        builder: (context, state) => const AuthorizationCheckScreen(),
      ),
      // 로그인 화면 라우팅 설정
      GoRoute(
        name: LoginScreen.routeName,
        path: LoginScreen.routeURL,
        builder: (context, state) => const LoginScreen(),
      ),
      // 회원가입 화면 라우팅 설정
      GoRoute(
        name: MakeUserScreen.routeName,
        path: MakeUserScreen.routeURL,
        builder: (context, state) => const MakeUserScreen(),
      ),
      // initial_setting 화면 라우팅 설정
      GoRoute(
        path: "/initial_setting/:nickname",
        name: InitialSettingSreen.routeName,
        builder: (context, state) {
          final String? nickname = state.pathParameters['nickname'];
          return InitialSettingSreen(nickname: nickname ?? '');
        },
      ),
      // 홈 화면 라우팅 설정
      GoRoute(
        path: "/:tab(home|map|search|favorite|profile)",
        name: MobileScreenLayout.routeName,
        builder: (context, state) {
          // final tab = state.params['tab']!;
          final tab = state.pathParameters['tab']!;
          return MobileScreenLayout(tab: tab);
        },
      ),
      // 프로필 수정 화면 라우팅 설정
      GoRoute(
        name: ChangeProfileScreen.routeName,
        path: ChangeProfileScreen.routeURL,
        builder: (context, state) => const ChangeProfileScreen(),
      ),
      //현재위치로 설정 화면 라우팅 설정
      // GoRoute(
      //   name: CurrentLocationScreen.routeName,
      //   path: CurrentLocationScreen.routeURL,
      //   builder: (context, state) => const CurrentLocationScreen(),
      // ),
      // 스토어 상세 화면 라우팅 설정
      GoRoute(
        path: "/detail_store/:id",
        name: DetailStoreScreen.routeName,
        builder: (context, state) {
          final String id = state.pathParameters['id']!;
          return DetailStoreScreen(storeId: id);
        },
      ),
      // 케이크 상세 화면 라우팅 설정
      GoRoute(
        path: "/detail_cake/:id/:store_id",
        name: DetailCakeScreen.routeName,
        builder: (context, state) {
          final String id = state.pathParameters['id']!;
          final String storeId = state.pathParameters['store_id']!;
          return DetailCakeScreen(cakeId: id, storeId: storeId);
        },
      ),
      // 비슷한 케이크 찾기 화면 라우팅 설정
      GoRoute(
        path: "/search_similar_cake",
        name: SearchSimilarCakeScreen.routeName,
        builder: (context, state) {
          Cake cake = state.extra as Cake;
          return SearchSimilarCakeScreen(
            originalCake: cake,
          );
        },
      ),
      // 큐레이션 더보기 화면 라우팅 설정
      GoRoute(
        path: "/more_curation",
        name: MoreCurationScreen.routeName,
        builder: (context, state) {
          Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          // final String title = state.pathParameters['title']!;
          return MoreCurationScreen(
            title: args['title'] as String,
            // fetchCakes는 안 올 수도 있음
            fetchCakes: args['fetchCakes'] as Function?,
            initailCakes: args['initailCakes'] as List<Cake>?,
          );
        },
      ),
      //케이크 검색 화면 라우팅 설정
      GoRoute(
        path: "/search_cake",
        name: SearchCakeInitailScreen.routeName,
        builder: (context, state) {
          return const SearchCakeInitailScreen();
        },
      ),
      // 위치 설정 화면 라우팅 설정
      GoRoute(
        path: CurrentLocationScreen.routeURL,
        name: CurrentLocationScreen.routeName,
        builder: (context, state) {
          Map<String, double> args = state.extra as Map<String, double>;
          return CurrentLocationScreen(
            initial_lat: args['lat']!,
            initial_lng: args['lng']!,
          );
        },
      ),
    ],
  );
});
