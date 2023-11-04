import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
import 'package:kezzle/features/profile/change_profile_screen.dart';
import 'package:kezzle/features/profile/view_models/profile_vm.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/utils/shared_preference_provider.dart';
import 'package:kezzle/view_models/id_token_provider.dart';

class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({super.key});

  @override
  UserScreenState createState() => UserScreenState();
}

class UserScreenState extends ConsumerState<UserScreen> {
  void onTapNickName(BuildContext context) {
    //프로필 수정 화면으로 이동
    context.pushNamed(ChangeProfileScreen.routeName);
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // print('initUser');
  // }

  // 로그아웃 버튼
  void onTapLogout(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          // 나중에 동작 함수도 같이 파라미터로 넣어줘야할 듯
          return AlertBottomSheet(
              content: '정말 로그아웃 하시겠어요?',
              cancelText: '취소',
              confirmText: '로그아웃',
              // 그냥 나오기
              onTapCancel: () => context.pop(),
              // 로그아웃 시키기
              onTapConfirm: () {
                // print('로그아웃');
                ref.read(sharedPreferenceRepo).setBool('onboarding', true);
                ref.read(sharedPreferenceRepo).setBool('isShowPopUp', true);

                ref.read(authRepo).signOut();
                ref.read(tokenProvider.notifier).resetToken();
                context.go("/");
              });
        });
  }

  void onTapWithdrawal(BuildContext context) {
    //회원탈퇴
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          // 나중에 동작 함수도 같이 파라미터로 넣어줘야할 듯
          return AlertBottomSheet(
            content: '정말 회원탈퇴 하시겠어요?',
            cancelText: '탈퇴하기',
            confirmText: '계속 유지할게요',
            onTapCancel: () {
              ref.read(sharedPreferenceRepo).setBool('onboarding', true);
              ref.read(sharedPreferenceRepo).setBool('isShowPopUp', true);

              ref.read(profileProvider.notifier).deleteProfile();
              ref.read(tokenProvider.notifier).resetToken();
              context.go("/authorization_check_screen");
            },
            onTapConfirm: () => context.pop(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(profileProvider).when(
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => Center(child: CircularProgressIndicator(color: coral01)),
        data: (data) => Scaffold(
            appBar: AppBar(
              title: const Text('마이페이지'),
              elevation: 0,
              // actions: [
              //   IconButton(
              //     onPressed: () {
              //       ref
              //           .read(analyticsProvider)
              //           .gaEvent('testEvent', {'params': 'testparams'});
              //     },
              //     icon: const FaIcon(FontAwesomeIcons.bell, size: 24),
              //   ),
              // ],
            ),
            body: Column(children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () => onTapNickName(context),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: coral01),
                                    children: [
                                  TextSpan(text: data.nickname),
                                  TextSpan(
                                      text: '님',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: gray08)),
                                ])),
                            // const SizedBox(width: 15),
                            Container(
                              padding: const EdgeInsets.only(left: 15),
                              child: FaIcon(FontAwesomeIcons.chevronRight,
                                  size: 15, color: gray05),
                            ),
                          ]),
                        ),
                        const SizedBox(height: 10),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(
                                  data.oathProvider == 'google.com'
                                      ? FontAwesomeIcons.google
                                      : FontAwesomeIcons.apple,
                                  size: 14),
                              const SizedBox(width: 8),
                              Text(data.email,
                                  style: TextStyle(
                                      color: gray05,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)),
                            ]),
                        // const SizedBox(height: 30),
                        // const Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //     children: [
                        //       ProfileOptionWidget(
                        //           title: '주문내역', iconPath: 'assets/icons/order.svg'),
                        //       ProfileOptionWidget(
                        //           title: '리뷰', iconPath: 'assets/icons/review.svg'),
                        //       ProfileOptionWidget(
                        //           title: '쿠폰', iconPath: 'assets/icons/coupon.svg'),
                        //     ]),
                      ])),
              // const MyDivider(),
              // ListTile(
              //   // horizontalTitleGap: 30,
              //   contentPadding: const EdgeInsets.symmetric(horizontal: 20),

              //   title: Text(
              //     '휴대폰 번호 변경',
              //     style: TextStyle(
              //       fontSize: 14,
              //       fontWeight: FontWeight.w600,
              //       color: gray07,
              //     ),
              //   ),
              //   trailing: Container(
              //     padding: const EdgeInsets.all(8),
              //     child: FaIcon(
              //       FontAwesomeIcons.chevronRight,
              //       size: 15,
              //       color: gray05,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    GestureDetector(
                      onTap: () => onTapLogout(context),
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 8),
                          child: Text('로그아웃',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: gray05))),
                    ),
                    GestureDetector(
                      onTap: () => onTapWithdrawal(context),
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 8),
                          child: Text('회원탈퇴',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: gray05))),
                    ),
                  ])),
            ])));
    // return Scaffold(
    //     appBar: AppBar(title: const Text('마이페이지'), elevation: 0, actions: [
    //       IconButton(
    //         onPressed: () {},
    //         icon: const FaIcon(FontAwesomeIcons.bell, size: 24),
    //       ),
    //     ]),
    //     body: Column(children: [
    //       Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 20),
    //           child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 const SizedBox(height: 20),
    //                 InkWell(
    //                   onTap: () => onTapNickName(context),
    //                   child: Row(mainAxisSize: MainAxisSize.min, children: [
    //                     RichText(
    //                         text: TextSpan(
    //                             style: TextStyle(
    //                                 fontSize: 18,
    //                                 fontWeight: FontWeight.w600,
    //                                 color: coral01),
    //                             children: [
    //                           const TextSpan(text: '보나'),
    //                           TextSpan(
    //                               text: '님',
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                   color: gray08)),
    //                         ])),
    //                     // const SizedBox(width: 15),
    //                     Container(
    //                       padding: const EdgeInsets.only(left: 15),
    //                       child: FaIcon(FontAwesomeIcons.chevronRight,
    //                           size: 15, color: gray05),
    //                     ),
    //                   ]),
    //                 ),
    //                 const SizedBox(height: 10),
    //                 Row(children: [
    //                   const FaIcon(FontAwesomeIcons.apple, size: 14),
    //                   const SizedBox(width: 8),
    //                   Text(ref.read(authRepo).user?.email ?? '',
    //                       style: TextStyle(
    //                           color: gray05,
    //                           fontSize: 12,
    //                           fontWeight: FontWeight.w400)),
    //                 ]),
    //                 // const SizedBox(height: 30),
    //                 // const Row(
    //                 //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                 //     children: [
    //                 //       ProfileOptionWidget(
    //                 //           title: '주문내역', iconPath: 'assets/icons/order.svg'),
    //                 //       ProfileOptionWidget(
    //                 //           title: '리뷰', iconPath: 'assets/icons/review.svg'),
    //                 //       ProfileOptionWidget(
    //                 //           title: '쿠폰', iconPath: 'assets/icons/coupon.svg'),
    //                 //     ]),
    //               ])),
    //       // const MyDivider(),
    //       // ListTile(
    //       //   // horizontalTitleGap: 30,
    //       //   contentPadding: const EdgeInsets.symmetric(horizontal: 20),

    //       //   title: Text(
    //       //     '휴대폰 번호 변경',
    //       //     style: TextStyle(
    //       //       fontSize: 14,
    //       //       fontWeight: FontWeight.w600,
    //       //       color: gray07,
    //       //     ),
    //       //   ),
    //       //   trailing: Container(
    //       //     padding: const EdgeInsets.all(8),
    //       //     child: FaIcon(
    //       //       FontAwesomeIcons.chevronRight,
    //       //       size: 15,
    //       //       color: gray05,
    //       //     ),
    //       //   ),
    //       // ),
    //       const SizedBox(height: 20),
    //       Padding(
    //           padding: const EdgeInsets.only(right: 20),
    //           child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
    //             GestureDetector(
    //               onTap: () => onTapLogout(context),
    //               child: Container(
    //                   padding: const EdgeInsets.symmetric(
    //                       vertical: 6, horizontal: 8),
    //                   child: Text('로그아웃',
    //                       style: TextStyle(
    //                           fontSize: 12,
    //                           fontWeight: FontWeight.w600,
    //                           color: gray05))),
    //             ),
    //             GestureDetector(
    //               onTap: () => onTapWithdrawal(context),
    //               child: Container(
    //                   padding: const EdgeInsets.symmetric(
    //                       vertical: 6, horizontal: 8),
    //                   child: Text('회원탈퇴',
    //                       style: TextStyle(
    //                           fontSize: 12,
    //                           fontWeight: FontWeight.w600,
    //                           color: gray05))),
    //             ),
    //           ])),
    //     ]));
    //   return Scaffold(
    //     // backgroundColor: Colors.white,
    //     body: SafeArea(
    //       child: Column(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.only(
    //               left: 20,
    //               right: 20,
    //               top: 15,
    //               bottom: 3,
    //             ),
    //             child: Row(
    //               children: [
    //                 Column(
    //                   mainAxisSize: MainAxisSize.min,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       'KLH 님',
    //                       style: TextStyle(
    //                           fontSize: 24, fontWeight: FontWeight.bold),
    //                     ),
    //                     Text(
    //                       'zzle@gmail.com',
    //                       style: TextStyle(
    //                         fontSize: 16,
    //                         color: Colors.grey[600],
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //                 Expanded(
    //                   child: SizedBox(),
    //                 ),
    //                 Stack(
    //                   clipBehavior: Clip.none,
    //                   children: [
    //                     FaIcon(
    //                       FontAwesomeIcons.bell,
    //                       size: 32,
    //                     ),
    //                     Positioned(
    //                       //포지션 좀 더 잘 하고, 아예 아이콘 만들어도 괜찮을 듯. png라 비침.
    //                       right: -5,
    //                       top: -5,
    //                       child: FaIcon(FontAwesomeIcons.circleExclamation,
    //                           color: Color(0xFFFF5C00), size: 20),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Divider(
    //             color: Colors.black,
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.symmetric(
    //               horizontal: 20,
    //               vertical: 15,
    //             ),
    //             child: Column(
    //               children: [
    //                 Container(
    //                   width: 380,
    //                   padding: EdgeInsets.symmetric(
    //                     vertical: 20,
    //                   ),
    //                   decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     boxShadow: [
    //                       BoxShadow(
    //                         color: Colors.grey.withOpacity(0.5),
    //                         blurRadius: 10,
    //                         // offset: Offset(0, 3),
    //                       ),
    //                     ],
    //                     // border: Border.all(color: Colors.grey),
    //                   ),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: [
    //                       Column(
    //                         children: [
    //                           FaIcon(
    //                             FontAwesomeIcons.penToSquare,
    //                             size: 32,
    //                           ),
    //                           Text('주문내역'),
    //                         ],
    //                       ),
    //                       GestureDetector(
    //                         onTap: () => onTapReview(context),
    //                         child: Column(
    //                           children: [
    //                             FaIcon(
    //                               FontAwesomeIcons.comment,
    //                               size: 32,
    //                             ),
    //                             Text('후기'),
    //                           ],
    //                         ),
    //                       ),
    //                       Column(
    //                         children: [
    //                           FaIcon(
    //                             FontAwesomeIcons.penToSquare,
    //                             size: 32,
    //                           ),
    //                           Text('쿠폰'),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 Container(
    //                   decoration: BoxDecoration(
    //                     border: Border.all(color: Colors.grey.withOpacity(0.5)),
    //                     borderRadius: BorderRadius.circular(15),
    //                   ),
    //                   child: Column(
    //                     mainAxisSize: MainAxisSize.min,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                     children: [
    //                       Padding(
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: Row(
    //                           children: [
    //                             Text(
    //                               '닉네임',
    //                               style: TextStyle(
    //                                 fontSize: 16,
    //                               ),
    //                             ),
    //                             Expanded(child: Container()),
    //                             Text('KHL'),
    //                             FaIcon(
    //                               FontAwesomeIcons.angleRight,
    //                               size: 20,
    //                               color: Colors.grey,
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       Container(
    //                         height: 1,
    //                         color: Colors.grey.withOpacity(0.5),
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: Row(
    //                           children: [
    //                             Text(
    //                               '이메일',
    //                               style: TextStyle(
    //                                 fontSize: 16,
    //                               ),
    //                             ),
    //                             Expanded(child: Container()),
    //                             Text('zzle@gmail.com'),
    //                           ],
    //                         ),
    //                       ),
    //                       Container(
    //                         height: 1,
    //                         color: Colors.grey.withOpacity(0.5),
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: Row(
    //                           children: [
    //                             Text(
    //                               '휴대폰 번호 변경',
    //                               style: TextStyle(
    //                                 fontSize: 16,
    //                               ),
    //                             ),
    //                             Expanded(child: Container()),
    //                             FaIcon(
    //                               FontAwesomeIcons.angleRight,
    //                               size: 20,
    //                               color: Colors.grey,
    //                             ),
    //                           ],
    //                         ),
    //                       ),

    //                       //ListTile이 나은가? 근데 패딩 조절이 안되네. 아니면 ListView를 써보는 것도 괜찮을 듯. 컬럼으로 쌓지 말고. -> verticalPadding을 쓰면 되나? 시도해보자

    //                       // ListTile(
    //                       //   contentPadding: EdgeInsets.symmetric(
    //                       //     horizontal: 8,
    //                       //     vertical: -5,
    //                       //   ),
    //                       //   title: Text(
    //                       //     '이메일',
    //                       //     style: TextStyle(
    //                       //       fontSize: 16,
    //                       //     ),
    //                       //   ),
    //                       //   trailing: Text(
    //                       //     'zzle@gmail.com',
    //                       //     style: TextStyle(
    //                       //       fontSize: 14,
    //                       //     ),
    //                       //   ),
    //                       // ),
    //                       // Container(
    //                       //   height: 1,
    //                       //   color: Colors.grey.withOpacity(0.5),
    //                       // ),
    //                       // ListTile(
    //                       //   contentPadding: EdgeInsets.symmetric(
    //                       //     horizontal: 8,
    //                       //     vertical: 1,
    //                       //   ),
    //                       //   title: Text(
    //                       //     '휴대폰 번호 변경',
    //                       //     style: TextStyle(
    //                       //       fontSize: 16,
    //                       //     ),
    //                       //   ),
    //                       //   trailing: FaIcon(
    //                       //     FontAwesomeIcons.angleRight,
    //                       //     size: 20,
    //                       //     color: Colors.grey,
    //                       //   ),
    //                       // ),
    //                     ],
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 Container(
    //                   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    //                   decoration: BoxDecoration(
    //                     border: Border.all(
    //                       color: Colors.grey.withOpacity(0.5),
    //                     ),
    //                     borderRadius: BorderRadius.circular(15),
    //                   ),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text(
    //                         '로그인 기기 관리',
    //                         style: TextStyle(fontSize: 16),
    //                       ),
    //                       FaIcon(
    //                         FontAwesomeIcons.angleRight,
    //                         size: 20,
    //                         color: Colors.grey,
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 Container(
    //                   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    //                   decoration: BoxDecoration(
    //                     border: Border.all(
    //                       color: Colors.grey.withOpacity(0.5),
    //                     ),
    //                     borderRadius: BorderRadius.circular(15),
    //                   ),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text('연동된 소셜 계정', style: TextStyle(fontSize: 16)),
    //                       FaIcon(
    //                         FontAwesomeIcons.google,
    //                         size: 20,
    //                         color: Colors.grey,
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 10,
    //                 ),
    //                 IntrinsicHeight(
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.end,
    //                     children: [
    //                       Text(
    //                         '로그아웃',
    //                         style:
    //                             TextStyle(fontSize: 14, color: Colors.grey[700]),
    //                       ),
    //                       SizedBox(
    //                         width: 5,
    //                       ),
    //                       VerticalDivider(
    //                         color: Colors.black,
    //                         thickness: 1,
    //                         width: 1,
    //                       ),
    //                       SizedBox(
    //                         width: 5,
    //                       ),
    //                       Text(
    //                         '회원탈퇴',
    //                         style:
    //                             TextStyle(fontSize: 14, color: Colors.grey[700]),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }
  }
}

class AlertBottomSheet extends StatelessWidget {
  final String content;
  final String cancelText;
  final String confirmText;
  final Function? onTapCancel;
  final Function? onTapConfirm;

  const AlertBottomSheet({
    super.key,
    required this.content,
    required this.cancelText,
    required this.confirmText,
    this.onTapCancel,
    this.onTapConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        height: 243,
        width: double.infinity,
        child: Column(children: [
          const SizedBox(height: 54),
          Text(content,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, color: gray08)),
          const SizedBox(height: 56),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                GestureDetector(
                  onTap: onTapCancel as void Function()?,
                  child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 3,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          color: gray03,
                          borderRadius: BorderRadius.circular(28)),
                      child: Text(cancelText,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: gray05))),
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: GestureDetector(
                  onTap: onTapConfirm as void Function()?,
                  child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          color: coral01,
                          borderRadius: BorderRadius.circular(28)),
                      child: Text(confirmText,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white))),
                )),
              ])),
        ]));
  }
}

class ProfileOptionWidget extends StatelessWidget {
  final String title;
  final String iconPath;

  const ProfileOptionWidget({
    super.key,
    required this.title,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(iconPath),
        const SizedBox(height: 2),
        Text(title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: gray06,
            )),
      ],
    );
  }
}
