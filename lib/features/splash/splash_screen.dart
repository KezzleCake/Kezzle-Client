import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerWidget {
  static const routeURL = '/splash';
  static const routeName = 'splash';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Timer(Duration(seconds: 2), () {
      // context.go('/home'); // '/home' 경로로 이동
      // ref.watch(routerProvider);
      context.go('/authorization_check_screen');
    });
    // 다른 기종에서도 중앙에 위치하게 하려면 어떻게 해야되지... 기준점을 잘 잡는게 중요할 거같음.
    return SvgPicture.asset('assets/splash_screen.svg', fit: BoxFit.cover);
    // return Scaffold(
    //     backgroundColor: coral01,
    //     body: Center(
    //         child: Stack(
    //       alignment: Alignment.center,
    //       children: [
    //         Positioned(
    //             top: 196,
    //             left: -18,
    //             child:
    //                 SvgPicture.asset('assets/splash_icons/splash_cake1.svg')),
    //         Positioned(
    //             top: 334,
    //             child: SvgPicture.asset('assets/splash_icons/text-logo.svg')),
    //         const Positioned(
    //             top: 422,
    //             child: Text(
    //               '소중한 날을 더 소중하게\n즐겁고 간편한 케이크 주문',
    //               style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.w700),
    //             )),
    //         Positioned(
    //             top: 520,
    //             left: 70,
    //             child:
    //                 SvgPicture.asset('assets/splash_icons/splash_cake2.svg')),
    //         Positioned(
    //             top: 583,
    //             left: 228,
    //             child:
    //                 SvgPicture.asset('assets/splash_icons/splash_cake3.svg')),
    //       ],
    //     )));
  }
}
