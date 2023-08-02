import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
import 'package:kezzle/features/authentication/make_user_screen.dart';
// import 'package:kezzle/screens/home_screen.dart';
import 'package:kezzle/utils/colors.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeURL = '/'; // 처음 앱 키면 나오게 하려고 임시로 수정
  static const routeName = 'login';

  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  void onTapBtn(BuildContext context) {
    context.pushNamed(MakeUserScreen.routeName);
  }

  void onTapGoogleBtn() {
    ref.read(authRepo).signInWithGoogle().then((value) {
      print(value);
      // 로그인하고, 새 유저면 MakeUserScreen으로, 기존 유저면 HomeScreen으로
      // if (ref.read(authRepo).isNewUser) {
      //   context.go(MakeUserScreen.routeURL);
      // } else {
      //   context.go('/home');
      // }
      context.pushNamed(MakeUserScreen.routeName);
    });
  }

  void onTapAppleBtn() {
    // print('apple');
    ref.read(authRepo).signInWithApple().then((value) {
      print(value);
      // 로그인하고, 새 유저면 MakeUserScreen으로, 기존 유저면 HomeScreen으로
      if (ref.read(authRepo).isNewUser) {
        // context.pushNamed(MakeUserScreen.routeName);
        context.go(MakeUserScreen.routeURL);
      } else {
        context.go('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/splash_icons/logo.svg'),
            const SizedBox(height: 98),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                  onTap: () => onTapGoogleBtn(),
                  child: Container(
                    width: 52,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: gray04, width: 1)),
                    child: SvgPicture.asset('assets/icons/Google.svg'),
                  )),
              if (Platform.isIOS) ...[
                const SizedBox(width: 20),
                GestureDetector(
                    onTap: () => onTapAppleBtn(),
                    child: Container(
                        width: 52,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: const FaIcon(FontAwesomeIcons.apple,
                            color: Colors.white, size: 23))),
              ]
            ]),
            const SizedBox(height: 20),
            SizedBox(
                width: 221,
                height: 18,
                child: Stack(alignment: Alignment.center, children: [
                  const Divider(),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.white,
                      child: Text("또는",
                          style: TextStyle(
                              color: gray05,
                              fontSize: 12,
                              fontWeight: FontWeight.w600))),
                ])),
            const SizedBox(height: 40),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                alignment: Alignment.center,
                width: 102,
                height: 30,
                child: Text('개인정보처리방침',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: gray05)),
              ),
              const SizedBox(width: 10),
              Container(
                alignment: Alignment.center,
                width: 58,
                height: 30,
                child: Text('이용약관',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: gray05)),
              ),
            ]),
          ]),
    ));
  }
}
