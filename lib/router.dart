import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/authentication/login_screen.dart';
import 'package:kezzle/features/authentication/make_user_screen.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
import 'package:kezzle/features/onboarding/current_location_screen.dart';
import 'package:kezzle/features/profile/change_profile_screen.dart';
import 'package:kezzle/features/splash/splash_screen.dart';
import 'package:kezzle/responsive/mobile_screen_layout.dart';
import 'package:kezzle/screens/store/detail_store_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: Platform.isAndroid ? "/splash" : "/home",

    // initialLocation: "/splash",
    // initialLocation: "/current_location_screen",
    redirect: (context, state) {
      // 로그인 했는 지 확인하고 안했으면 로그인 화면으로 이동.
      final isLoggedIn = ref.watch(authRepo).isLoggedIn;
      if (!isLoggedIn && state.location == "/home") {
        if (state.location != "/login") {
          return LoginScreen.routeURL;
        }
      }
      // 로그인 했으면, 새 유저인지 확인하고 새 유저면 닉네임 만드는 화면으로 이동. if문 넣기
      // final isNewUser = ref.watch(authRepo).isNewUser;
      // if (isNewUser) {
      //   if (state.location != "/make_user") {
      //     return MakeUserScreen.routeURL;
      //   }
      // }
    },
    routes: [
      // 스플래시 화면 라우팅 설정
      GoRoute(
        name: SplashScreen.routeName,
        path: SplashScreen.routeURL,
        builder: (context, state) => const SplashScreen(),
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
      GoRoute(
        name: CurrentLocationScreen.routeName,
        path: CurrentLocationScreen.routeURL,
        builder: (context, state) => const CurrentLocationScreen(),
      ),
      // 스토어 상세 화면 라우팅 설정
      GoRoute(
        path: "/detail_store/:id",
        name: DetailStoreScreen.routeName,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return DetailStoreScreen(storeId: int.parse(id));
        },
      ),
    ],
  );
});
