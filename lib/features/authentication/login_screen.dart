import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
import 'package:kezzle/features/authentication/make_user_screen.dart';
import 'package:kezzle/features/profile/repos/user_repo.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/view_models/id_token_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeURL = '/'; // 처음 앱 키면 나오게 하려고 임시로 수정
  static const routeName = 'login';

  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  bool? isLoading;

  void onTapBtn(BuildContext context) {
    context.pushNamed(MakeUserScreen.routeName);
  }

  void onTapGoogleBtn() async {
    ref.read(authRepo).signInWithGoogle().then((value) async {
      if (value == null) {
        return;
      }
      setState(() {
        isLoading = true;
      });

      ref.read(tokenProvider.notifier).getIdToken(newtoken: true);
      User user = ref.read(authRepo).user!;
      final response = await ref.read(userRepo).fetchProfile(user);
      if (!mounted) return;
      if (response == null) {
        context.pushNamed(MakeUserScreen.routeName);
      } else {
        context.go('/home');
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  void onTapAppleBtn() async {
    ref.read(authRepo).signInWithApple().then((value) async {
      setState(() {
        isLoading = true;
      });

      ref.read(tokenProvider.notifier).getIdToken(newtoken: true);
      User user = ref.read(authRepo).user!;
      final response = await ref.read(userRepo).fetchProfile(user);
      if (!mounted) return;
      if (response == null) {
        context.pushNamed(MakeUserScreen.routeName);
      } else {
        context.go('/home');
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  // void onTapLaterSign() {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //         builder: (context) => const InitialSettingSreen(nickname: '')),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showDialogFunction(context);
    // });
  }

  // void showDialogFunction(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           GestureDetector(
  //             onTap: () => launchUrlString(
  //                 'https://forms.gle/YR9EnmqK9t9SbAXX8',
  //                 mode: LaunchMode.externalApplication),
  //             child: Container(
  //                 decoration:
  //                     BoxDecoration(borderRadius: BorderRadius.circular(20)),
  //                 clipBehavior: Clip.hardEdge,
  //                 width: MediaQuery.of(context).size.width - 55,
  //                 // height: 475,
  //                 child: Image.asset('assets/event/가입이벤트.png')),
  //           ),
  //           const SizedBox(height: 20),
  //           GestureDetector(
  //             onTap: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Container(
  //               alignment: Alignment.center,
  //               padding: const EdgeInsets.symmetric(vertical: 10),
  //               width: MediaQuery.of(context).size.width - 55,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(30),
  //                 color: coral01,
  //               ),
  //               child: DefaultTextStyle(
  //                 style: TextStyle(
  //                     color: gray01, fontSize: 16, fontWeight: FontWeight.w700),
  //                 child: const Text(
  //                   '닫기',
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //       //  AlertDialog(
  //       //   elevation: 0,
  //       //   backgroundColor: Colors.transparent,
  //       //   content: Container(
  //       //       // height: MediaQuery.of(context).size.height * 0.6,
  //       //       width: MediaQuery.of(context).size.width * 0.3,
  //       //       decoration: BoxDecoration(
  //       //         borderRadius: BorderRadius.circular(10),
  //       //       ),
  //       //       clipBehavior: Clip.hardEdge,
  //       //       child: SingleChildScrollView(
  //       //         child: GestureDetector(
  //       //           onTap: () => launchUrlString(
  //       //               'https://forms.gle/YR9EnmqK9t9SbAXX8',
  //       //               mode: LaunchMode.externalApplication),
  //       //           child: Image.asset(
  //       //             'assets/event/가입이벤트.png',
  //       //             fit: BoxFit.cover,
  //       //           ),
  //       //         ),
  //       //       )),
  //       //   actions: <Widget>[
  //       //     GestureDetector(
  //       //       onTap: () {
  //       //         Navigator.of(context).pop();
  //       //       },
  //       //       child: Container(
  //       //           padding: const EdgeInsets.symmetric(vertical: 10),
  //       //           width: MediaQuery.of(context).size.width * 0.95,
  //       //           decoration: BoxDecoration(
  //       //             borderRadius: BorderRadius.circular(30),
  //       //             color: coral01,
  //       //           ),
  //       //           child: Text('닫기',
  //       //               textAlign: TextAlign.center,
  //       //               style: TextStyle(
  //       //                   color: gray01,
  //       //                   fontSize: 16,
  //       //                   fontWeight: FontWeight.w700))),
  //       //     ),
  //       //   ],
  //       // );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading != null
            ? isLoading == true
                ? Center(child: CircularProgressIndicator(color: coral01))
                : Container()
            : Center(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    GestureDetector(
                        // onTap: () => showDialogFunction(context),
                        child:
                            SvgPicture.asset('assets/splash_icons/logo.svg')),
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
                                  border:
                                      Border.all(color: Colors.black, width: 1),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.white,
                              child: Text("또는",
                                  style: TextStyle(
                                      color: gray05,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600))),
                        ])),
                    // const SizedBox(height: 20),
                    // GestureDetector(
                    //   onTap: onTapLaterSign,
                    //   child: Container(
                    //       width: 280,
                    //       padding: const EdgeInsets.all(16),
                    //       decoration: BoxDecoration(
                    //           border: Border.all(color: coral01, width: 1),
                    //           borderRadius: BorderRadius.circular(28)),
                    //       child: Text('나중에 가입하기',
                    //           textAlign: TextAlign.center,
                    //           style: TextStyle(
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.w600,
                    //               color: coral01))),
                    // ),
                    const SizedBox(height: 40),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      GestureDetector(
                        onTap: () {
                          launchUrlString(
                              'https://sites.google.com/view/kezzle-privacy-policy/%ED%99%88');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 102,
                          height: 30,
                          child: Text('개인정보처리방침',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: gray05)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                          onTap: () {
                            launchUrlString(
                                'https://drive.google.com/file/d/1jUHzvH-6RB-DTRFmQkNsGG2URpcTj9FN/view');
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 58,
                            height: 30,
                            child: Text('이용약관',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: gray05)),
                          )),
                    ]),
                  ])));
  }
}
