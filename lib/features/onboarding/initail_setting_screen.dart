import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';
import 'package:kezzle/responsive/mobile_screen_layout.dart';
import 'package:kezzle/utils/colors.dart';
// import 'package:kezzle/widgets/calendar_widget.dart';
import 'package:kezzle/widgets/distance_setting_widget.dart';
import 'package:kezzle/widgets/location_setting_widget.dart';
// import 'package:kezzle/widgets/my_divider_widget.dart';
// import 'package:kezzle/widgets/time_setting_widget.dart';

class InitialSettingSreen extends StatefulWidget {
  // static const routeURL = '/initial_setting';
  static const routeName = 'initial_setting';
  const InitialSettingSreen({super.key});

  @override
  State<InitialSettingSreen> createState() => _InitialSettingSreenState();
}

class _InitialSettingSreenState extends State<InitialSettingSreen> {
  // String _selectedDate =
  //     DateFormat('yyyy/MM/dd').format(DateTime.now()).toString();
  // DateTime _selectedTime = DateTime.now();

  bool _isSearced = false;
  int _selectedDistance = 5;

  void _onTapLocation(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return const LocationSettingWidget();
        });
  }

  void _onTapDistance(BuildContext context) async {
    final result = await showModalBottomSheet<int>(
        context: context,
        builder: (context) {
          return DistanceSettingWidget(initialValue: _selectedDistance);
        });
    print('result: ' + result.toString());
    setState(() {
      _selectedDistance = result!;
    });
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

  void _onTapStart(BuildContext context) {
    context
        .goNamed(MobileScreenLayout.routeName, pathParameters: {'tab': 'home'});
  }

  @override
  Widget build(BuildContext context) {
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
                child: GestureDetector(
                    onTap: () => _onTapStart(context),
                    child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: coral01,
                            borderRadius: BorderRadius.circular(28)),
                        child: Text('시작하기',
                            style: TextStyle(
                                fontSize: 16,
                                color: gray01,
                                fontWeight: FontWeight.w700))))),
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
                      const TextSpan(text: '와 '),
                      TextSpan(
                          text: '이동가능 거리', style: TextStyle(color: coral01)),
                      const TextSpan(text: '를 설정해주세요'),
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
                                          color: _isSearced ? gray06 : gray04)),
                                ])))),
                const SizedBox(width: 12),
                GestureDetector(
                    onTap: () => _onTapDistance(context),
                    child: Container(
                        padding: const EdgeInsets.all(16),
                        height: 53,
                        width: MediaQuery.of(context).size.width * 130 / 390,
                        // 130, 이거는 비율로 맞춰야 될 듯.
                        decoration: BoxDecoration(
                            color: gray01,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: gray03,
                            )),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Text('${_selectedDistance}km',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: gray06,
                                      ))),
                              FaIcon(FontAwesomeIcons.chevronDown,
                                  size: 10, color: gray05),
                            ]))),
              ]),
              const SizedBox(height: 10),
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                const FaIcon(FontAwesomeIcons.locationCrosshairs, size: 18),
                const SizedBox(width: 6),
                Text('현재 위치로 설정',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: gray06)),
                const SizedBox(width: 6),
                FaIcon(FontAwesomeIcons.chevronRight, size: 10, color: gray05),
              ]),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '인왕산힐스테이트아파트',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: gray08,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: coral01,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Text("도로명",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "서울 서대문구 통일로 34길 46 인왕산 힐스테이트아파트",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: gray06,
                              ),
                              // overflow: TextOverflow.ellipsis,
                              // 문장 길이(도로명 주소) 길어지면 ... 처리하는거 넣어야 함.
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  FaIcon(
                    FontAwesomeIcons.check,
                    size: 26,
                    color: coral01,
                  ),
                ],
              )
            ])),

        // const SizedBox(height: 20),
        // Container(
        //     width: double.infinity,
        //     height: 300,
        //     color: gray03,
        //     child: const Center(child: Text('지도'))),
      ]),
    );
  }
}
