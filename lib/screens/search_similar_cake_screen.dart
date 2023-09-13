// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:kezzle/features/analytics/analytics.dart';
// import 'package:kezzle/similar_cake.dart';
// import 'package:kezzle/utils/colors.dart';
// import 'package:kezzle/view_models/search_setting_vm.dart';
// import 'package:kezzle/widgets/distance_setting_widget.dart';
// import 'package:kezzle/widgets/location_setting_widget.dart';
// import 'package:kezzle/widgets/similar_cake_widget.dart';

// import 'dart:ui' as ui;

// class SearchSimilarCakeScreen extends ConsumerStatefulWidget {
//   const SearchSimilarCakeScreen({super.key});

//   @override
//   SearchSimilarCakeScreenState createState() => SearchSimilarCakeScreenState();
// }

// class SearchSimilarCakeScreenState
//     extends ConsumerState<SearchSimilarCakeScreen> {
//   late PageController _pageController;
//   List<SimilarCake> similarCakeList = [];
//   int currentIndex = 0;
//   late final CameraPosition _kGooglePlex = const CameraPosition(
//     target: LatLng(37.5612811, 126.964338),
//     zoom: 16,
//   );
//   GoogleMapController? _mapController;
//   bool cameraMove = false;

//   BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
//   // BitmapDescriptor markerIcon2 = BitmapDescriptor.defaultMarker;

//   Set<Marker> markers = Set();

//   void addCustomIcon() {
//     BitmapDescriptor.fromAssetImage(
//             const ImageConfiguration(
//                 // size: Size(10, 10),
//                 ),
//             'assets/icons/marker_icon.png')
//         .then((icon) {
//       setState(() {
//         markerIcon = icon;
//       });
//     });
//   }

//   // void setCustomMapPin() async {
//   //   Uint8List icon =
//   //       await getBytesFromAsset('assets/icons/marker_icon.png', 20);
//   //   setState(() {
//   //     markerIcon2 = BitmapDescriptor.fromBytes(icon);
//   //   });
//   // }

//   Future<Uint8List> getBytesFromAsset(String path, int width) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//         targetWidth: width);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
//   }

//   @override
//   void initState() {
//     super.initState();
//     addCustomIcon();
//     similarCakeList = rawData
//         .map(
//           (data) => SimilarCake(
//             imageUrl: data['imageUrl'],
//             id: data['id'],
//             index: data['index'],
//             lat: data['lat'],
//             lng: data['lng'],
//           ),
//         )
//         .toList();
//     _pageController =
//         PageController(viewportFraction: 0.50, initialPage: currentIndex);

// // 사용자 지정 마커 추가
//     Marker customMarker1 = Marker(
//       markerId: const MarkerId('1'),
//       position: LatLng(similarCakeList[0].lat, similarCakeList[0].lng),
//       // 마커 아이디 값에 따라 pageview 이동
//       onTap: () {
//         _pageController.animateToPage(0,
//             duration: const Duration(milliseconds: 350),
//             curve: Curves.easeInOut);
//       },
//       // infoWindow: InfoWindow(
//       //   title: '본비케이크',
//       //   snippet: '서울 강남구 역삼동',
//       // ),
//       // onTap: ,
//       //icon 변경
//       // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//       // icon: markerIcon2,
//       icon: markerIcon,
//     );
//     Marker customMarker2 = Marker(
//       // 마커 아이디 값에 따라 pageview 이동
//       onTap: () {
//         _pageController.animateToPage(1,
//             duration: const Duration(milliseconds: 350),
//             curve: Curves.easeInOut);
//       },
//       markerId: const MarkerId('2'),
//       position: LatLng(similarCakeList[1].lat, similarCakeList[1].lng),
//       //icon 변경
//       // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//       icon: markerIcon,
//     );
//     Marker customMarker3 = Marker(
//       onTap: () {
//         // 마커 아이디 값에 따라 pageview 이동
//         _pageController.animateToPage(2,
//             duration: const Duration(milliseconds: 350),
//             curve: Curves.easeInOut);
//       },
//       markerId: const MarkerId('3'),
//       position: LatLng(similarCakeList[2].lat, similarCakeList[2].lng),
//       // icon 변경
//       // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//       icon: markerIcon,
//     );
//     // // 마커 목록에 마커 추가
//     markers.add(customMarker1);
//     markers.add(customMarker2);
//     markers.add(customMarker3);
//   }

//   void _onTapLocation(BuildContext context) {
//     // 위치 설정 버튼 누르는지 체크
//     ref
//         .read(analyticsProvider)
//         .gaEvent('btn_location_setting', {'location': 'location'});

//     showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         builder: (context) {
//           // return const CalendarWidget();
//           return const LocationSettingWidget();
//         });
//   }

//   void _onTapDistance(BuildContext context) {
//     showModalBottomSheet<int>(
//         context: context,
//         builder: (context) {
//           return DistanceSettingWidget(
//               initialValue: ref.watch(searchSettingViewModelProvider).radius);
//         });
//   }

//   void onPageChanged(int index) {
//     setState(() {
//       currentIndex = index;
//       //index에 맞는 마커로 카메라 이동
//       // 카메라가 움직이고 있지 않으면 이동. 카메라가 움직이고 있으면 이동하지 않음
//       if (!cameraMove) {
//         _mapController!
//             .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//           target:
//               LatLng(similarCakeList[index].lat, similarCakeList[index].lng),
//           zoom: 16,
//         )));
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: GestureDetector(
//               onTap: () => _onTapLocation(context),
//               child: Row(mainAxisSize: MainAxisSize.min, children: [
//                 Text(ref.watch(searchSettingViewModelProvider).address,
//                     style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: gray08)),
//                 SvgPicture.asset('assets/icons/arrow-down.svg',
//                     colorFilter: ColorFilter.mode(gray07, BlendMode.srcIn)),
//                 GestureDetector(
//                     onTap: () => _onTapDistance(context),
//                     child: Row(children: [
//                       Text(
//                           '${ref.watch(searchSettingViewModelProvider).radius}km',
//                           style: const TextStyle(
//                               fontSize: 14, fontWeight: FontWeight.w600)),
//                       SvgPicture.asset('assets/icons/arrow-down.svg',
//                           colorFilter:
//                               ColorFilter.mode(gray07, BlendMode.srcIn)),
//                     ])),
//               ])),
//         ),
//         bottomNavigationBar: BottomAppBar(
//           color: Colors.white,
//           shadowColor: Colors.transparent,
//           elevation: 0,
//           child: GestureDetector(
//               child: Container(
//                   width: 100,
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                       color: coral01, borderRadius: BorderRadius.circular(28)),
//                   child: Text('케이크 상세보기',
//                       style: TextStyle(
//                           fontSize: 16,
//                           color: gray01,
//                           fontWeight: FontWeight.w700)))),
//         ),
//         body: Stack(children: [
//           GoogleMap(
//             onCameraMove: (position) {
//               setState(() {
//                 cameraMove = true;
//               });
//             },
//             onCameraIdle: () {
//               setState(() {
//                 cameraMove = false;
//               });
//             },
//             initialCameraPosition: _kGooglePlex,
//             myLocationButtonEnabled: false,
//             markers: markers,
//             onMapCreated: (controller) {
//               _mapController = controller;
//             },
//             // markers:
//             // {
//             //   Marker(
//             //     markerId: const MarkerId("marker1"),
//             //     position: const LatLng(37.5608754, 126.963693),
//             //     draggable: true,
//             //     onDragEnd: (value) {
//             //       // value is the new position
//             //     },
//             //     icon: BitmapDescriptor.fromBytes(markerIcon2),
//             //   ),
//             // },
//           ),
//           Align(
//             alignment: Alignment.topCenter,
//             child: Container(
//                 margin: const EdgeInsets.only(top: 16),
//                 padding: const EdgeInsets.all(16),
//                 width: MediaQuery.of(context).size.width - 40,
//                 height: (MediaQuery.of(context).size.width - 40) * 142 / 350,
//                 decoration: BoxDecoration(
//                     boxShadow: [shadow01],
//                     borderRadius: BorderRadius.circular(16),
//                     color: Colors.white),
//                 child: Row(mainAxisSize: MainAxisSize.min, children: [
//                   ClipRRect(
//                       borderRadius: BorderRadius.circular(16),
//                       child: Image.asset('assets/heart_cake.png',
//                           fit: BoxFit.cover)),
//                   const SizedBox(width: 8),
//                   Column(
//                       // mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Text('본비케이크',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                                 color: gray08)),
//                         Text('서울 강남구 역삼동',
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                                 color: gray05)),
//                         SizedBox(
//                           width: (MediaQuery.of(context).size.width - 40) -
//                               (MediaQuery.of(context).size.width - 40) *
//                                   142 /
//                                   350 -
//                               8,
//                           child: Text(
//                               '초코 제누아주: 가나슈필링\n바닐라 제누아즈: 버터크림 + 딸기잼필링\n당근케익(건포도 + 크렌베리 + 호두): 크랜베리',
//                               // softWrap: true,
//                               maxLines: 3,
//                               textAlign: TextAlign.left,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: gray08)),
//                         ),
//                       ]),
//                 ])),
//           ),
//           Positioned(
//             bottom: 0,
//             child: SizedBox(
//                 height: MediaQuery.of(context).size.width * 0.50,
//                 width: MediaQuery.of(context).size.width,
//                 child: PageView.builder(
//                     controller: _pageController,
//                     itemCount: similarCakeList.length,
//                     // onPageChanged: (index) {
//                     //   setState(() {
//                     //     currentIndex = index;
//                     //   });
//                     // },
//                     onPageChanged: onPageChanged,
//                     itemBuilder: (context, index) {
//                       var scale = currentIndex == index ? 1.0 : 0.85;
//                       return TweenAnimationBuilder(
//                           curve: Curves.ease,
//                           duration: const Duration(milliseconds: 350),
//                           tween: Tween<double>(begin: scale, end: scale),
//                           child: SimilarCakeWidget(
//                               similarCake: similarCakeList[index]),
//                           builder: (context, value, child) {
//                             return Transform.scale(scale: value, child: child);
//                           });
//                     })),
//           ),
//         ]));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kezzle/features/analytics/analytics.dart';
import 'package:kezzle/similar_cake.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/utils/exhibition_marker.dart';
import 'package:kezzle/view_models/search_setting_vm.dart';
import 'package:kezzle/widgets/distance_setting_widget.dart';
import 'package:kezzle/widgets/location_setting_widget.dart';
import 'package:kezzle/widgets/similar_cake_widget.dart';

import 'dart:ui' as ui;

class SearchSimilarCakeScreen extends ConsumerStatefulWidget {
  const SearchSimilarCakeScreen({super.key});

  @override
  SearchSimilarCakeScreenState createState() => SearchSimilarCakeScreenState();
}

class SearchSimilarCakeScreenState
    extends ConsumerState<SearchSimilarCakeScreen> {
  late PageController _pageController;
  List<SimilarCake> similarCakeList = [];
  int currentIndex = 0;
  late final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.5612811, 126.964338),
    zoom: 16,
  );
  GoogleMapController? _mapController;
  bool cameraMove = false;

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  // BitmapDescriptor markerIcon2 = BitmapDescriptor.defaultMarker;

  Set<Marker> markers = Set();

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(
                // size: Size(10, 10),
                ),
            'assets/icons/marker_icon.png')
        .then((icon) {
      setState(() {
        markerIcon = icon;
      });
    });
  }

  // void setCustomMapPin() async {
  //   Uint8List icon =
  //       await getBytesFromAsset('assets/icons/marker_icon.png', 20);
  //   setState(() {
  //     markerIcon2 = BitmapDescriptor.fromBytes(icon);
  //   });
  // }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    super.initState();
    addCustomIcon();
    similarCakeList = rawData
        .map(
          (data) => SimilarCake(
            imageUrl: data['imageUrl'],
            id: data['id'],
            index: data['index'],
            lat: data['lat'],
            lng: data['lng'],
          ),
        )
        .toList();
    _pageController =
        PageController(viewportFraction: 0.50, initialPage: currentIndex);

// 사용자 지정 마커 추가
    Marker customMarker1 = Marker(
      markerId: const MarkerId('1'),
      position: LatLng(similarCakeList[0].lat, similarCakeList[0].lng),
      // 마커 아이디 값에 따라 pageview 이동
      onTap: () {
        _pageController.animateToPage(0,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut);
      },
      // infoWindow: InfoWindow(
      //   title: '본비케이크',
      //   snippet: '서울 강남구 역삼동',
      // ),
      // onTap: ,
      //icon 변경
      // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      // icon: markerIcon2,
      icon: markerIcon,
    );
    Marker customMarker2 = Marker(
      // 마커 아이디 값에 따라 pageview 이동
      onTap: () {
        _pageController.animateToPage(1,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut);
      },
      markerId: const MarkerId('2'),
      position: LatLng(similarCakeList[1].lat, similarCakeList[1].lng),
      //icon 변경
      // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      icon: markerIcon,
    );
    Marker customMarker3 = Marker(
      onTap: () {
        // 마커 아이디 값에 따라 pageview 이동
        _pageController.animateToPage(2,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut);
      },
      markerId: const MarkerId('3'),
      position: LatLng(similarCakeList[2].lat, similarCakeList[2].lng),
      // icon 변경
      // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      icon: markerIcon,
    );
    // // 마커 목록에 마커 추가
    markers.add(customMarker1);
    markers.add(customMarker2);
    markers.add(customMarker3);
  }

  void _onTapLocation(BuildContext context) {
    // 위치 설정 버튼 누르는지 체크
    ref
        .read(analyticsProvider)
        .gaEvent('btn_location_setting', {'location': 'location'});

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          // return const CalendarWidget();
          return const LocationSettingWidget();
        });
  }

  void _onTapDistance(BuildContext context) {
    showModalBottomSheet<int>(
        context: context,
        builder: (context) {
          return DistanceSettingWidget(
              initialValue: ref.watch(searchSettingViewModelProvider).radius);
        });
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
      //index에 맞는 마커로 카메라 이동
      // 카메라가 움직이고 있지 않으면 이동. 카메라가 움직이고 있으면 이동하지 않음
      if (!cameraMove) {
        _mapController!
            .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(similarCakeList[index].lat, similarCakeList[index].lng),
          zoom: 16,
        )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: GestureDetector(
              onTap: () => _onTapLocation(context),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(ref.watch(searchSettingViewModelProvider).address,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: gray08)),
                SvgPicture.asset('assets/icons/arrow-down.svg',
                    colorFilter: ColorFilter.mode(gray07, BlendMode.srcIn)),
                GestureDetector(
                    onTap: () => _onTapDistance(context),
                    child: Row(children: [
                      Text(
                          '${ref.watch(searchSettingViewModelProvider).radius}km',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                      SvgPicture.asset('assets/icons/arrow-down.svg',
                          colorFilter:
                              ColorFilter.mode(gray07, BlendMode.srcIn)),
                    ])),
              ])),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shadowColor: Colors.transparent,
          elevation: 0,
          child: GestureDetector(
              child: Container(
                  width: 100,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: coral01, borderRadius: BorderRadius.circular(28)),
                  child: Text('케이크 상세보기',
                      style: TextStyle(
                          fontSize: 16,
                          color: gray01,
                          fontWeight: FontWeight.w700)))),
        ),
        body: Stack(children: [
          ExhibitionMarker(type: MarkerType.exhibitionMarker, onFinishRendering: (globalKey, type) {
            // print('globalKey: $globalKey, type: $type');
            
          },),
          GoogleMap(
            onCameraMove: (position) {
              setState(() {
                cameraMove = true;
              });
            },
            onCameraIdle: () {
              setState(() {
                cameraMove = false;
              });
            },
            initialCameraPosition: _kGooglePlex,
            myLocationButtonEnabled: false,
            markers: markers,
            onMapCreated: (controller) {
              _mapController = controller;
            },
            // markers:
            // {
            //   Marker(
            //     markerId: const MarkerId("marker1"),
            //     position: const LatLng(37.5608754, 126.963693),
            //     draggable: true,
            //     onDragEnd: (value) {
            //       // value is the new position
            //     },
            //     icon: BitmapDescriptor.fromBytes(markerIcon2),
            //   ),
            // },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width - 40,
                height: (MediaQuery.of(context).size.width - 40) * 142 / 350,
                decoration: BoxDecoration(
                    boxShadow: [shadow01],
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset('assets/heart_cake.png',
                          fit: BoxFit.cover)),
                  const SizedBox(width: 8),
                  Column(
                      // mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('본비케이크',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: gray08)),
                        Text('서울 강남구 역삼동',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: gray05)),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width - 40) -
                              (MediaQuery.of(context).size.width - 40) *
                                  142 /
                                  350 -
                              8,
                          child: Text(
                              '초코 제누아주: 가나슈필링\n바닐라 제누아즈: 버터크림 + 딸기잼필링\n당근케익(건포도 + 크렌베리 + 호두): 크랜베리',
                              // softWrap: true,
                              maxLines: 3,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: gray08)),
                        ),
                      ]),
                ])),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.50,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                    controller: _pageController,
                    itemCount: similarCakeList.length,
                    // onPageChanged: (index) {
                    //   setState(() {
                    //     currentIndex = index;
                    //   });
                    // },
                    onPageChanged: onPageChanged,
                    itemBuilder: (context, index) {
                      var scale = currentIndex == index ? 1.0 : 0.85;
                      return TweenAnimationBuilder(
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 350),
                          tween: Tween<double>(begin: scale, end: scale),
                          child: SimilarCakeWidget(
                              similarCake: similarCakeList[index]),
                          builder: (context, value, child) {
                            return Transform.scale(scale: value, child: child);
                          });
                    })),
          ),
        ]));
  }
}
