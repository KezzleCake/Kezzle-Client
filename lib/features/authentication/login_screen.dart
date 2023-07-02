import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/authentication/make_user_screen.dart';
import 'widgets/auth_button.dart';

class LoginScreen extends StatelessWidget {
  // static const routeURL = '/login';
  static const routeURL = '/';
  static const routeName = 'login';

  const LoginScreen({super.key});

  void onTapBtn(BuildContext context) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => const MakeUserScreen(),
    //   ),
    // );
    // context.pushNamed(MakeUserScreen.routeName);
    context.pushNamed(MakeUserScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 100),
            const SizedBox(
              width: 185,
              child: Text(
                '환영합니다, 케즐에 가입하고 케이크 주문을 시작해보세요!',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            const Image(
                image: AssetImage('assets/kezzle_logo.png'), width: 240),
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const AuthButton(
                    text: 'Google로 계속하기',
                    icon: FaIcon(FontAwesomeIcons.google, size: 20),
                  ),
                  const SizedBox(height: 10),
                  const AuthButton(
                    text: 'Apple로 계속하기',
                    icon: FaIcon(
                      FontAwesomeIcons.apple,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const AuthButton(
                    text: '카카오로 계속하기',
                    icon: FaIcon(
                      FontAwesomeIcons.commentDots,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '개인정보처리방침',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(' | '),
                      Text(
                        ' 이용약관',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () => onTapBtn(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: Color(0xffFDDA81),
                      ),
                      child: const Text(
                        '나중에 가입하기',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
