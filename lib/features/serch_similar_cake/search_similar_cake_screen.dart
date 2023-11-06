import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kezzle/features/analytics/analytics.dart';
import 'package:kezzle/features/bookmark/bookmark_screen.dart';
import 'package:kezzle/features/serch_similar_cake/vm/search_similar_cake_vm.dart';
import 'package:kezzle/models/detail_store_model.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/models/similar_cake_model.dart';
import 'package:kezzle/repo/stores_repo.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/utils/exhibition_marker.dart';
import 'package:kezzle/view_models/search_setting_vm.dart';
import 'package:kezzle/widgets/distance_setting_widget.dart';
import 'package:kezzle/widgets/location_setting_widget.dart';
import 'package:kezzle/widgets/similar_cake_widget.dart';

import 'dart:ui' as ui;

class SearchSimilarCakeScreen extends ConsumerStatefulWidget {
  static const routeName = '/search_similar_cake';
  static const routeUrl = '/search_similar_cake/:cakeId';

  final Cake originalCake;
  final PageController pageController = PageController(
    viewportFraction: 0.50,
    initialPage: 0,
  );
  SearchSimilarCakeScreen({super.key, required this.originalCake});

  @override
  SearchSimilarCakeScreenState createState() => SearchSimilarCakeScreenState();
}

class SearchSimilarCakeScreenState
    extends ConsumerState<SearchSimilarCakeScreen> {
  // late PageController _pageController;
  // List<SimilarCake> similarCakeList = [];
  // int currentIndex = 0;
  // late final CameraPosition _kGooglePlex = const CameraPosition(
  //   target: LatLng(37.5612811, 126.964338),
  //   zoom: 16,
  // );
  // GoogleMapController? _mapController;
  // bool cameraMove = false;
  @override
  void dispose() {
    widget.pageController.dispose();
    // print('dispose');
    super.dispose();
  }

  void _onTapLocation(BuildContext context) {
    // 위치 설정 버튼 누르는지 체크
    ref.read(analyticsProvider).gaEvent('btn_location_setting', {});

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          // return const CalendarWidget();
          return const LocationSettingWidget();
        });
  }

  void _onTapDistance(BuildContext context) {
    // ref
    //     .read(analyticsProvider)
    //     .gaEvent('btn_radius_setting', {'radius': ref.read()});

    showModalBottomSheet<int>(
        context: context,
        builder: (context) {
          return DistanceSettingWidget(
              initialValue: ref.watch(searchSettingViewModelProvider).radius);
        });
  }

  Future<DetailStoreModel?> fetchStore() async {
    //스토어 정보 가져오기
    // final double lat = ref.watch(searchSettingViewModelProvider).latitude;
    // final double lng = ref.watch(searchSettingViewModelProvider).longitude;
    final response = await ref.read(storeRepo).fetchDetailStore(
        storeId: widget.originalCake.ownerStoreId /*, lat: lat, lng: lng*/);
    if (response != null) {
      // print(response);
      // response를 DetailStoreModel로 변환
      final fetched = DetailStoreModel.fromJson(response);
      // print(fetched);
      return fetched;
    }
    return null;
  }

  void onTapOriginalCake() {
    context.push(
        "/detail_cake/${widget.originalCake.id}/${widget.originalCake.ownerStoreId}");

    ref.read(analyticsProvider).gaEvent('click_original_cake', {
      'cake_id': widget.originalCake.id,
      'cake_store_id': widget.originalCake.ownerStoreId
    });
  }

  // void onTapDetailCake() {
  //   // 현재 페이지뷰의 케이크 정보를 가지고 상세페이지로 이동
  //   // print(widget.pageController.page);
  //   //page가 소수점이 0.5이상이면 반올림, 아니면 내림
  //   int page = widget.pageController.page!.round();
  //   // print(ref
  //   //     .read(similarCakeProvider(widget.originalCake.id))
  //   //     .value![page]
  //   //     .ownerStoreName);
  //   SimilarCake cake =
  //       ref.read(similarCakeProvider(widget.originalCake.id)).value![page];

  //   context.push("/detail_cake/${cake.id}/${cake.ownerStoreId}");

  //   ref.read(analyticsProvider).gaEvent('click_detail_similar_cake', {
  //     'cake_id': cake.id,
  //     'cake_store_id': cake.ownerStoreId,
  //     'cake_store_name': cake.ownerStoreName,
  //     'original_cake_id': widget.originalCake.id,
  //     'original_cake_store_id': widget.originalCake.ownerStoreId,
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          titleSpacing: 0,
          // centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                highlightColor: Colors.transparent, // 눌린 상태에서 물결 효과 비활성화
                splashColor: Colors.transparent,
                onTap: () => _onTapLocation(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          // 주소가 없으면 '위치를 설정해주세요' 로
                          ref
                                  .watch(searchSettingViewModelProvider)
                                  .address
                                  .isEmpty
                              ? '위치를 설정해주세요'
                              :
                              // 15글자 넘어가면 끝에 ... 로
                              ref
                                          .watch(searchSettingViewModelProvider)
                                          .address
                                          .length >
                                      16
                                  ? '${ref.watch(searchSettingViewModelProvider).address.substring(0, 14)}...'
                                  : ref
                                      .watch(searchSettingViewModelProvider)
                                      .address,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: gray08)),
                      Padding(
                          padding: Platform.isAndroid
                              ? const EdgeInsets.only(top: 2.0)
                              : const EdgeInsets.all(0),
                          child: SvgPicture.asset('assets/icons/arrow-down.svg',
                              colorFilter:
                                  ColorFilter.mode(gray07, BlendMode.srcIn))),
                    ],
                  ),
                ),
              ),

              InkWell(
                  highlightColor: Colors.transparent, // 눌린 상태에서 물결 효과 비활성화
                  splashColor: Colors.transparent,
                  onTap: () {
                    _onTapDistance(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: Platform.isAndroid
                                ? const EdgeInsets.only(top: 2.0)
                                : const EdgeInsets.all(0),
                            child: Text(
                                '${ref.watch(searchSettingViewModelProvider).radius}km',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                          ),
                          Padding(
                            padding: Platform.isAndroid
                                ? const EdgeInsets.only(top: 2.0)
                                : const EdgeInsets.all(0),
                            child: SvgPicture.asset(
                                'assets/icons/arrow-down.svg',
                                colorFilter:
                                    ColorFilter.mode(gray07, BlendMode.srcIn)),
                          ),
                        ]),
                  )),
              //         ])),
              Text('내 검색 결과',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: gray08)),
            ],
          ),
        ),
        // bottomNavigationBar: BottomAppBar(
        //   color: Colors.white,
        //   shadowColor: Colors.transparent,
        //   elevation: 0,
        //   child: IgnorePointer(
        //     ignoring: ref
        //             .watch(similarCakeProvider(widget.originalCake.id))
        //             .isLoading ||
        //         ref
        //             .watch(similarCakeProvider(widget.originalCake.id))
        //             .value!
        //             .isEmpty,
        //     child: GestureDetector(
        //         onTap: onTapDetailCake,
        //         child: Container(
        //             width: 100,
        //             alignment: Alignment.center,
        //             padding: const EdgeInsets.all(16),
        //             decoration: BoxDecoration(
        //               color: ref
        //                           .watch(similarCakeProvider(
        //                               widget.originalCake.id))
        //                           .isLoading ||
        //                       ref
        //                           .watch(similarCakeProvider(
        //                               widget.originalCake.id))
        //                           .value!
        //                           .isEmpty
        //                   ? gray03
        //                   : coral01,
        //               borderRadius: BorderRadius.circular(28),
        //             ),
        //             child: Text('케이크 상세보기',
        //                 style: TextStyle(
        //                     fontSize: 16,
        //                     color: gray01,
        //                     fontWeight: FontWeight.w700)))),
        //   ),
        // ),
        body: Stack(children: [
          MapScreen(
              originalCake: widget.originalCake,
              cakeId: widget.originalCake.id,
              pageController: widget.pageController),
          FutureBuilder<DetailStoreModel?>(
              future: fetchStore(),
              builder: (context, data) {
                if (data.hasData) {
                  DetailStoreModel? store = data.data;
                  return Align(
                      alignment: Alignment.topCenter,
                      child: GestureDetector(
                        onTap: onTapOriginalCake,
                        child: Container(
                            margin: const EdgeInsets.only(top: 16),
                            padding: const EdgeInsets.all(16),
                            width: MediaQuery.of(context).size.width - 40,
                            height: (MediaQuery.of(context).size.width - 40) *
                                142 /
                                350,
                            decoration: BoxDecoration(
                                boxShadow: [shadow01],
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white),
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              AspectRatio(
                                  aspectRatio: 1,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      // child: Image.asset('assets/heart_cake.png',
                                      //     fit: BoxFit.cover),
                                      child: CachedNetworkImage(
                                          imageUrl: widget
                                              .originalCake.image.s3Url
                                              .replaceFirst("https", "http"),
                                          fit: BoxFit.cover))),
                              const SizedBox(width: 8),
                              Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: (MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40) -
                                          (MediaQuery.of(context).size.width -
                                                  40) *
                                              142 /
                                              350 -
                                          8,
                                      child: Text(store!.name,
                                          // '본비케이크',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: gray08)),
                                    ),
                                    SizedBox(
                                        width: (MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                40) -
                                            (MediaQuery.of(context).size.width -
                                                    40) *
                                                142 /
                                                350 -
                                            8,
                                        child: Text(
                                            // '서울 강남구 역삼동',
                                            store.address,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: gray05))),
                                    SizedBox(
                                        width: (MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                40) -
                                            (MediaQuery.of(context).size.width -
                                                    40) *
                                                142 /
                                                350 -
                                            8,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3),
                                          child: Text(
                                              // '초코 제누아주: 가나슈필링\n바닐라 제누아즈: 버터크림 + 딸기잼필링\n당근케익(건포도 + 크렌베리 + 호두): 크랜베리',
                                              // softWrap: true,
                                              store.taste.join('\n'),
                                              maxLines: 3,
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: gray08)),
                                        )),
                                  ]),
                            ])),
                      ));
                }
                // else {
                //   return const SizedBox();
                // }
                else if (data.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                      body: Center(
                          child: CircularProgressIndicator(color: coral01)));
                } else {
                  return const Scaffold(
                      body: Center(child: Text('오류가 발생했습니다.')));
                }
              }),
        ]));
  }
}

class MapScreen extends ConsumerStatefulWidget {
  final String cakeId;
  final PageController pageController;
  final Cake originalCake;
  const MapScreen(
      {super.key,
      required this.cakeId,
      required this.pageController,
      required this.originalCake});

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends ConsumerState<MapScreen> {
  // late PageController _pageController;
  int currentIndex = 0;
  GoogleMapController? _mapController;
  CameraPosition? cameraPosition;
  bool cameraMove = false;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  List<SimilarCake> similarCakeList = [];
  bool markerLoading = true;

  void onTapSimilarCake(int index) {
    context.push(
        "/detail_cake/${similarCakeList[index].id}/${similarCakeList[index].ownerStoreId}");

    ref.read(analyticsProvider).gaEvent('click_detail_similar_cake', {
      'cake_id': similarCakeList[index].id,
      'cake_store_id': similarCakeList[index].ownerStoreId,
      'cake_store_name': similarCakeList[index].ownerStoreName,
      'original_cake_id': widget.originalCake.id,
      'original_cake_store_id': widget.originalCake.ownerStoreId,
    });
  }

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
    // _pageController =
    //     PageController(viewportFraction: 0.50, initialPage: currentIndex);
  }

  void onPageChanged(int index) async {
    double zoomLevel = await _mapController!.getZoomLevel();
    setState(() {
      currentIndex = index;
      //index에 맞는 마커로 카메라 이동
      // 카메라가 움직이고 있지 않으면 이동. 카메라가 움직이고 있으면 이동하지 않음
      // double zoomLevel = await _mapController.getZoomLevel();
      if (!cameraMove) {
        _mapController!
            .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(similarCakeList[index].ownerStoreLatitude,
              similarCakeList[index].ownerStoreLongitude),
          // zoom: 16,
          // zoom: _mapController!.getZoomLevel(),
          zoom: zoomLevel,
        )));
      }
    });
  }

  Future<BitmapDescriptor?> convertWidgetToPNG(GlobalKey globalKey) async {
    RenderObject? boundary = globalKey.currentContext?.findRenderObject();

    if (boundary != null && boundary is RenderRepaintBoundary) {
      ui.Image image = await boundary.toImage(pixelRatio: 3);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();

      if (pngBytes != null) {
        return BitmapDescriptor.fromBytes(pngBytes);
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    // print('??');
    // 반경이나, 위도 경도 변경되면 실행되는 리스너
    // ref.listen(searchSettingViewModelProvider, (previous, next) {
    //   if (previous != next) {
    //     ref.read(similarCakeProvider(widget.cakeId).notifier).refresh();
    //   }
    // });

    return Stack(children: [
      ExhibitionMarker(
          type: MarkerType.exhibitionMarker,
          onFinishRendering: (globalKey, type) {
            convertWidgetToPNG(globalKey).then((icon) {
              // print('icon!!');
              setState(() {
                markerIcon = icon!;
                markerLoading = false;
              });
            });
          }),
      Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height),
      markerLoading
          ? Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(color: coral01))
          : ref.watch(similarCakeProvider(widget.cakeId)).when(loading: () {
              return Center(child: CircularProgressIndicator(color: coral01));
            }, error: (error, stackTrace) {
              //에러 메시지 출력
              // 자세한 에러메시지 출력
              print(stackTrace);
              print(error);

              return const Center(child: Text('에러가 발생했습니다.'));
            }, data: (cakes) {
              similarCakeList = cakes;
              return Stack(
                children: [
                  cakes.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(
                              top: (MediaQuery.of(context).size.width - 40) *
                                  142 /
                                  350),
                          child: const Center(
                            child: NoItemScreen(
                                text:
                                    '설정 위치의 반경 내, 비슷한 케이크를 제공하는\n스토어를 찾을 수 없습니다.'),
                            // Text('해당 반경 내, 비슷한 케이크를 제공하는 스토어를 찾을 수 없습니다.'),
                          ),
                        )
                      // const Text('해당 반경 내, 비슷한 케이크를 제공하는 스토어를 찾을 수 없습니다.')
                      : GoogleMap(
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
                          // 초반 카메라 포지션을 cake[0]의 lng, lat로 설정
                          initialCameraPosition: CameraPosition(
                              target: LatLng(cakes[0].ownerStoreLatitude,
                                  cakes[0].ownerStoreLongitude),
                              zoom: 16),
                          myLocationButtonEnabled: false,
                          onMapCreated: (controller) {
                            _mapController = controller;
                          },
                          markers: {
                            for (var cake in cakes)
                              Marker(
                                infoWindow: InfoWindow(
                                    title: cake.ownerStoreName,
                                    snippet: cake.ownerStoreAddress),
                                onTap: () {
                                  widget.pageController.animateToPage(
                                      cakes.indexOf(cake),
                                      duration:
                                          const Duration(milliseconds: 350),
                                      curve: Curves.easeInOut);
                                },
                                markerId: MarkerId(cake.id.toString()),
                                position: LatLng(cake.ownerStoreLatitude,
                                    cake.ownerStoreLongitude),
                                icon: markerIcon,
                              ),
                          },
                        ),
                  Positioned(
                    bottom: 30,
                    child: SizedBox(
                        height: MediaQuery.of(context).size.width * 0.64,
                        width: MediaQuery.of(context).size.width,
                        child: PageView.builder(
                            controller: widget.pageController,
                            itemCount: cakes.length,
                            onPageChanged: onPageChanged,
                            itemBuilder: (context, index) {
                              var scale = currentIndex == index ? 1.0 : 0.85;
                              return TweenAnimationBuilder(
                                  curve: Curves.ease,
                                  duration: const Duration(milliseconds: 350),
                                  tween:
                                      Tween<double>(begin: scale, end: scale),
                                  child: GestureDetector(
                                    onTap: () => onTapSimilarCake(index),
                                    child: SimilarCakeWidget(
                                        // onTapSimilarCake:
                                        //     onTapSimilarCake(index),
                                        similarCake: cakes[index]),
                                  ),
                                  builder: (context, value, child) {
                                    return Transform.scale(
                                        scale: value, child: child);
                                  });
                            })),
                  ),
                ],
              );
            })
    ]);
  }
}
