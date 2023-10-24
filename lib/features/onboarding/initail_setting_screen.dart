import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
// import 'package:go_router/go_router.dart';
// import 'package:kezzle/features/address_search/address_search_vm.dart';
import 'package:kezzle/features/onboarding/current_location_screen.dart';
import 'package:kezzle/features/onboarding/current_location_service.dart';
import 'package:kezzle/features/profile/repos/user_repo.dart';
// import 'package:kezzle/features/profile/view_models/profile_vm.dart';
// import 'package:kezzle/features/onboarding/current_location_vm.dart';
// import 'package:intl/intl.dart';
// import 'package:kezzle/responsive/mobile_screen_layout.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/view_models/search_setting_vm.dart';
// import 'package:kezzle/widgets/calendar_widget.dart';
import 'package:kezzle/widgets/distance_setting_widget.dart';
import 'package:kezzle/widgets/location_setting_widget.dart';

import '../../responsive/mobile_screen_layout.dart';
// import 'package:kezzle/widgets/my_divider_widget.dart';
// import 'package:kezzle/widgets/time_setting_widget.dart';

class InitialSettingSreen extends ConsumerStatefulWidget {
  // static const routeURL = '/initial_setting';
  static const routeName = 'initial_setting';

  final String _nickname;
  const InitialSettingSreen({super.key, required String nickname})
      : _nickname = nickname;

  @override
  InitialSettingSreenState createState() => InitialSettingSreenState();
}

class InitialSettingSreenState extends ConsumerState<InitialSettingSreen> {
  // String _selectedDate =
  //     DateFormat('yyyy/MM/dd').format(DateTime.now()).toString();
  // DateTime _selectedTime = DateTime.now();

  // bool _isSearced = false;
  // int _selectedDistance = 5;
  // String _selectedLocation = '';

  void _onTapLocation(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return const LocationSettingWidget();
        });
    // print('result: ' + result.toString());
    // if (result != null) {
    //   setState(() {
    //     _selectedLocation = result.toString();
    //   });
    // }
  }

  void _onTapDistance(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return DistanceSettingWidget(
              initialValue: ref.watch(searchSettingViewModelProvider).radius);
        });
  }

  void _onTapCurrentLocation() async {
    // 위치 권한 확인 후, 위치 받아오고 받아온 위치 전달해서 화면 이동
    final Position? currentPosition =
        await CurrentLocationService().getCurrentLocation();
    // print('currentPosition: ' + currentPosition.toString());
    if (!mounted) return;
    if (currentPosition != null) {
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => CurrentLocationScreen(
      //           initial_lat: currentPosition.latitude,
      //           initial_lng: currentPosition.longitude,
      //         )));
      context.pushNamed(CurrentLocationScreen.routeName, extra: {
        'lat': currentPosition.latitude,
        'lng': currentPosition.longitude,
      });
    }

    // context.pushNamed(CurrentLocationScreen.routeName);
  }

  // void _onTapPickUpDate(BuildContext context) async {
  //   final result = await showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return const CalendarWidget();
  //     },
  //   );
  //   print('result: ' + result.toString());
  //   if (result != null) {
  //     setState(() {
  //       _selectedDate = DateFormat('yyyy/MM/dd').format(result).toString();
  //     });
  //   }
  // }

  // void _onTapPickUpTime(BuildContext context) async {
  //   final result = await showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         // return const CalendarWidget();
  //         return const TimeSettingWidget();
  //       });
  //   print('result: ' + result.toString());
  //   if (result != null) {
  //     setState(() {
  //       _selectedTime = result;
  //     });
  //   }
  // }

  // '다음에' 버튼 누를 때
  // void _onTapSkip(BuildContext context) {
  //   context
  //       .goNamed(MobileScreenLayout.routeName, pathParameters: {'tab': 'home'});
  // }

  // 시작하기 버튼 누를 시
  void _onTapStart(String nickname) async {
    print(nickname);
    // 회원가입 나중에 하기로 온 사람
    if (nickname.isEmpty) {
      print('회원가입 안함');
      context.goNamed(MobileScreenLayout.routeName,
          pathParameters: {'tab': 'home'});
    } else {
      User user = ref.read(authRepo).user!;
      print(user);
      final response =
          await ref.read(userRepo).createProfile(widget._nickname, user);
      if (response != null) {
        if (!mounted) return;
        context.goNamed(MobileScreenLayout.routeName,
            pathParameters: {'tab': 'home'});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget._nickname);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
          color: gray01,
          elevation: 0,
          child: Row(children: [
            // GestureDetector(
            //     onTap: () => _onTapSkip(context),
            //     child: Container(
            //         width: MediaQuery.of(context).size.width * 120 / 390,
            //         alignment: Alignment.center,
            //         padding: const EdgeInsets.all(16),
            //         decoration: BoxDecoration(
            //             color: gray03, borderRadius: BorderRadius.circular(28)),
            //         child: Text('다음에',
            //             style: TextStyle(
            //                 fontSize: 16,
            //                 color: gray05,
            //                 fontWeight: FontWeight.w700)))),
            // const SizedBox(width: 10),
            Expanded(
                child: IgnorePointer(
              ignoring:
                  ref.watch(searchSettingViewModelProvider).address.isEmpty,
              child: GestureDetector(
                  onTap: () => _onTapStart(widget._nickname),
                  child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: ref
                                  .watch(searchSettingViewModelProvider)
                                  .address
                                  .isNotEmpty
                              ? coral01
                              : gray03,
                          borderRadius: BorderRadius.circular(28)),
                      child: Text('시작하기',
                          style: TextStyle(
                              fontSize: 16,
                              color: gray01,
                              fontWeight: FontWeight.w700)))),
            )),
          ])),
      appBar: AppBar(title: const Text('케이크 픽업 설정')),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // const SizedBox(height: 34),
        // Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     child:
        //         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //       Text('픽업 시간',
        //           style: TextStyle(
        //               fontSize: 16,
        //               fontWeight: FontWeight.w600,
        //               color: gray08)),
        //       const SizedBox(height: 12),
        //       Row(children: [
        //         Expanded(
        //             child: GestureDetector(
        //                 onTap: () => _onTapPickUpDate(context),
        //                 child: Container(
        //                     padding: const EdgeInsets.all(16),
        //                     height: 53,
        //                     decoration: BoxDecoration(
        //                         color: gray01,
        //                         borderRadius: BorderRadius.circular(30),
        //                         border: Border.all(
        //                           color: gray03,
        //                         )),
        //                     child: Row(
        //                         crossAxisAlignment: CrossAxisAlignment.center,
        //                         children: [
        //                           SvgPicture.asset('assets/icons/calendar.svg',
        //                               width: 15,
        //                               height: 15,
        //                               colorFilter: ColorFilter.mode(
        //                                   gray05, BlendMode.srcIn)),
        //                           const SizedBox(width: 6),
        //                           Text(_selectedDate,
        //                               style: TextStyle(
        //                                   fontSize: 14,
        //                                   fontWeight: FontWeight.w600,
        //                                   color: gray06)),
        //                         ])))),
        //         const SizedBox(width: 12),
        //         GestureDetector(
        //             onTap: () => _onTapPickUpTime(context),
        //             child: Container(
        //                 padding: const EdgeInsets.all(16),
        //                 height: 53,
        //                 width: MediaQuery.of(context).size.width * 130 / 390,
        //                 decoration: BoxDecoration(
        //                     color: gray01,
        //                     borderRadius: BorderRadius.circular(30),
        //                     border: Border.all(color: gray03)),
        //                 child: Row(
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     children: [
        //                       SvgPicture.asset('assets/icons/clock.svg',
        //                           width: 15,
        //                           height: 15,
        //                           colorFilter: ColorFilter.mode(
        //                               gray05, BlendMode.srcIn)),
        //                       const SizedBox(width: 6),
        //                       Text('오후 01:00',
        //                           style: TextStyle(
        //                               fontSize: 14,
        //                               fontWeight: FontWeight.w600,
        //                               color: gray06)),
        //                     ]))),
        //       ]),
        //     ])),
        // const MyDivider(),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Text('픽업 장소',
              //     style: TextStyle(
              //         fontSize: 16,
              //         fontWeight: FontWeight.w600,
              //         color: gray08)),
              // const SizedBox(height: 12),
              const SizedBox(height: 25),
              RichText(
                text: TextSpan(
                    text: '케이크를 픽업하기 위해\n',
                    style: TextStyle(
                        height: 1.5,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: gray08),
                    children: [
                      TextSpan(
                          text: '출발할 장소', style: TextStyle(color: coral01)),
                      const TextSpan(text: '를 선택해주세요'),
                      // TextSpan(
                      //     text: '이동가능 거리', style: TextStyle(color: coral01)),
                      // const TextSpan(text: '를 설정해주세요'),
                    ]),
              ),
              const SizedBox(height: 30),
              Row(children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () => _onTapLocation(context),
                        child: Container(
                            padding: const EdgeInsets.all(16),
                            height: 53,
                            decoration: BoxDecoration(
                              color: gray01,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: gray03),
                            ),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      'assets/icons/search_bar.svg',
                                      width: 15,
                                      height: 15,
                                      colorFilter: ColorFilter.mode(
                                          gray05, BlendMode.srcIn)),
                                  const SizedBox(width: 6),
                                  Text('장소를 검색해주세요.',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: gray05)),
                                ])))),
                const SizedBox(width: 12),
                // GestureDetector(
                //     onTap: () => _onTapDistance(context),
                //     child: Container(
                //         padding: const EdgeInsets.all(16),
                //         height: 53,
                //         width: MediaQuery.of(context).size.width * 130 / 390,
                //         // 130, 이거는 비율로 맞춰야 될 듯.
                //         decoration: BoxDecoration(
                //             color: gray01,
                //             borderRadius: BorderRadius.circular(30),
                //             border: Border.all(
                //               color: gray03,
                //             )),
                //         child: Row(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               Expanded(
                //                   child: Text(
                //                       '${ref.watch(searchSettingViewModelProvider).radius}km',
                //                       style: TextStyle(
                //                         fontSize: 14,
                //                         fontWeight: FontWeight.w600,
                //                         color: gray06,
                //                       ))),
                //               FaIcon(FontAwesomeIcons.chevronDown,
                //                   size: 10, color: gray05),
                //             ]))),
              ]),
              const SizedBox(height: 18),
              GestureDetector(
                onTap: () => _onTapCurrentLocation(),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 3),
                        child: FaIcon(FontAwesomeIcons.locationCrosshairs,
                            size: 18),
                      ),
                      const SizedBox(width: 6),
                      Text('현재 위치로 설정',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: gray06)),
                      const SizedBox(width: 6),
                      FaIcon(FontAwesomeIcons.chevronRight,
                          size: 10, color: gray05),
                    ]),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ref.watch(searchSettingViewModelProvider).address,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: gray08,
                            )),
                        // const SizedBox(height: 3),
                        // Row(
                        //   children: [
                        //     Container(
                        //       padding: const EdgeInsets.all(4),
                        //       decoration: BoxDecoration(
                        //         color: coral01,
                        //         borderRadius: BorderRadius.circular(15),
                        //       ),
                        //       child: const Text("도로명",
                        //           style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: 12,
                        //               fontWeight: FontWeight.w600)),
                        //     ),
                        //     const SizedBox(width: 6),
                        //     Text(
                        //       "서울 서대문구 통일로 34길 46 인왕산 힐스테이트아파트",
                        //       style: TextStyle(
                        //         fontSize: 12,
                        //         fontWeight: FontWeight.w500,
                        //         color: gray06,
                        //       ),
                        //       // overflow: TextOverflow.ellipsis,
                        //       // 문장 길이(도로명 주소) 길어지면 ... 처리하는거 넣어야 함.
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                  ref.watch(searchSettingViewModelProvider).address.isNotEmpty
                      ? FaIcon(
                          FontAwesomeIcons.check,
                          size: 26,
                          color: coral01,
                        )
                      : Container(),
                ],
              )
            ])),
      ]),
    );
  }
}
