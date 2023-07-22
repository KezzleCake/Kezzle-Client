import 'package:go_router/go_router.dart';
import 'package:kezzle/features/authentication/login_screen.dart';
import 'package:kezzle/features/authentication/make_user_screen.dart';
import 'package:kezzle/features/profile/change_profile_screen.dart';
import 'package:kezzle/features/splash/splash_screen.dart';
import 'package:kezzle/responsive/mobile_screen_layout.dart';

final router = GoRouter(
  initialLocation: "/home",
  // initialLocation: "/splash",

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
  ],
);
