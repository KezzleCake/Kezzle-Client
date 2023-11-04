import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/authentication/login_screen.dart';
import 'package:kezzle/features/authentication/make_user_screen.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
import 'package:kezzle/features/onboarding/onboarding_screen.dart';
import 'package:kezzle/features/profile/repos/user_repo.dart';
import 'package:kezzle/responsive/mobile_screen_layout.dart';
import 'package:kezzle/utils/shared_preference_provider.dart';
// import 'package:kezzle/screens/home_screen.dart';
// import 'package:kezzle/utils/colors.dart';

class AuthorizationCheckScreen extends ConsumerStatefulWidget {
  static const routeURL = '/authorization_check_screen';
  static const routeName = 'AuthorizationCheckScreen';

  const AuthorizationCheckScreen({super.key});

  @override
  AuthorizationCheckScreenState createState() =>
      AuthorizationCheckScreenState();
}

class AuthorizationCheckScreenState
    extends ConsumerState<AuthorizationCheckScreen> {
  // 여기에서 DB에서 사용자 정보를 가져오는 비동기 함수 -> 사용자 정보를 확인하고 권한 반환.
  Future<String> _getUserAuthorization() async {
    // const String _firebaseLogin = 'login firebase';

    // userRepo에서 사용자 정보 가져오기
    final User? user = ref.watch(authRepo).user;
    // 파이어베이스 로그인도 안된 유저이면? -> 로그인 화면으로 이동
    if (user == null) {
      return 'login firebase';
    } else {
      // 파이어베이스 로그인한 유저이면? -> DB에 사용자 정보가 있는지 확인
      final response = await ref.read(userRepo).fetchProfile(user);
      if (response == null) {
        // db에 정보가 없고 -> 로그인 화면으로 이동하자..
        return 'login firebase';
      } else {
        // db에 정보가 있으면 -> role 확인
        // 'isAdmin', 'isBuyer', 'isSeller'

        List<String> roles = response['roles'].cast<String>();

        if (roles.contains('isBuyer')) {
          // role이 유저이면 -> 유저 홈화면으로 이동
          return 'home';
        } else if (roles.contains('isSeller')) {
          // role이 관리자이면 -> 관리자 홈화면으로 이동
          return 'make user';
        } else {
          return 'make user';
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: _getUserAuthorization(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // 사용자 정보가 있으면
            // 사용자 정보를 저장하고
            // 홈 화면으로 이동
            if (snapshot.data == 'login firebase') {
              // return const Text('로그인 화면으로 이동');
              // return const LoginScreen();
              ref.read(sharedPreferenceRepo).getBool('onbording').then((value) {
                value != false
                    ? context.go(OnboardingScreen.routeURL)
                    : context.go(LoginScreen.routeURL);
              });
              // return    const OnboardingScreen();
              return const Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              ));
            } else if (snapshot.data == 'make user') {
              // return const Text('유저 정보 만들기 화면으로 이동');
              return const MakeUserScreen();
              // return const OnboardingScreen();
            } else if (snapshot.data == 'home') {
              return const MobileScreenLayout(tab: 'home');
            } else {
              return const Text('판매자 정보 만들기 화면으로 이동');
            }
          } else if (snapshot.hasError) {
            // 사용자 정보가 없으면
            // 로그인 화면으로 이동
            return const Text('사용자 정보 없음');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          } else {
            // 사용자 정보를 가져오는 중이면
            // 로딩 화면 표시
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          }
        });
  }
}
