import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kezzle/features/address_search/address_search_vm.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/view_models/search_setting_vm.dart';

class CurrentLocationScreen extends ConsumerStatefulWidget {
  static const routeURL = '/current_location_screen';
  static const routeName = 'current_location_screen';

  final double initial_lat;
  final double initial_lng;

  const CurrentLocationScreen({
    super.key,
    required this.initial_lat,
    required this.initial_lng,
  });

  @override
  CurrentLocationScreenState createState() => CurrentLocationScreenState();
}

class CurrentLocationScreenState extends ConsumerState<CurrentLocationScreen> {
  bool _isMoved = false;
  String currentLocation = '';

  GoogleMapController? _mapController;

  // 초기값은 받아와서 해야될거같은데 일단은 임의로 설정
  double latitude = 37.5612811;
  double longitude = 126.964338;
  // final CameraPosition _kGooglePlex = const CameraPosition(
  //   // 초기값은 받아와서 해야될거같은데 일단은 임의로 설정
  //   target: LatLng(37.5612811, 126.964338),
  //   zoom: 20,
  // );
  late final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(widget.initial_lat, widget.initial_lng),
    zoom: 20,
  );

  @override
  void initState() {
    super.initState();
  }

  void _onCameraIdle() async {
    // final GoogleMapController controller = _mapController!;
    print('_onCameraIdle');
    LatLngBounds visibleRegion = await _mapController!.getVisibleRegion();
    LatLng centerLatLng = LatLng(
      (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) / 2,
      (visibleRegion.northeast.longitude + visibleRegion.southwest.longitude) /
          2,
    );

    AddressSearchVM()
        .searchCurrentLocationGoogleMap(
            centerLatLng.longitude, centerLatLng.latitude)
        .then((value) {
      // print('구글 지도 api를 이용한 위도 경도로 주소 검색');
      // print(value);
      //도로명 주소가 있으면 도로명 주소를, 없으면 지번 주소 가져오기

      // print(value['results'][0]['formatted_address']);

      // 없을 수도 있을거 같으니까 예외처리 해줘야될듯?
      currentLocation = value['results'][0]['formatted_address'];
      List<String> searchedAddress = currentLocation.split(' ');
      // 0, 1번 인덱스 값(대한민국, 서울특별시 ) 제외하고 다시 ' '로 join
      currentLocation = searchedAddress
          .sublist(2, searchedAddress.length)
          .join(' ')
          .toString();

      latitude = centerLatLng.latitude;
      longitude = centerLatLng.longitude;
      _isMoved = false;

      setState(() {});
    });
  }

  void _onTapCurrentLocationButton() async {
    await _mapController!
        .animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  void onTapSetLocationButton(BuildContext context) {
    // 설정 누르면? 위도, 경도, 주소명 저장하고 pop하기.
    ref
        .read(searchSettingViewModelProvider.notifier)
        .setAddress(currentLocation);
    ref.read(searchSettingViewModelProvider.notifier).setLatitude(latitude);
    ref.read(searchSettingViewModelProvider.notifier).setLongitude(longitude);
    //Navigator.pop(context, currentLocation);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('현재 위치로 설정')),
        bottomNavigationBar: BottomAppBar(
            height: 140,
            elevation: 0,
            color: Colors.white,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      // padding: const EdgeInsets.only(bottom: 10),
                      // color: Colors.yellow,
                      child: Text(currentLocation,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: gray06,
                              fontWeight: FontWeight.w700))),
                  IgnorePointer(
                      ignoring: _isMoved,
                      child: GestureDetector(
                        onTap: () => {onTapSetLocationButton(context)},
                        child: Container(
                            height: 55,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: _isMoved ? gray04 : coral01,
                                borderRadius: BorderRadius.circular(28)),
                            child: Text('이 위치로 주소설정',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: gray01,
                                    fontWeight: FontWeight.w700))),
                      )),
                ])),
        body: Stack(alignment: Alignment.center, children: [
          GoogleMap(
              myLocationButtonEnabled: false,
              // myLocationEnabled: true,
              onCameraMove: (position) {
                _isMoved = true;
                setState(() {});
              },
              onMapCreated: (controller) {
                _mapController = controller;
              },
              zoomControlsEnabled: false,
              initialCameraPosition: _kGooglePlex,
              onCameraIdle: _onCameraIdle),
          Container(
            width: 20,
            height: 10,
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.horizontal(
                    left: Radius.elliptical(10, 5),
                    right: Radius.elliptical(10, 5))),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: _isMoved ? 40 : 25),
            child: FaIcon(FontAwesomeIcons.locationDot,
                color: _isMoved ? coral01.withOpacity(0.8) : coral01),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 20, right: 20),
                  child: GestureDetector(
                    onTap: _onTapCurrentLocationButton,
                    child: Container(
                      alignment: Alignment.center,
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: gray04, width: 1)),
                      child:
                          FaIcon(FontAwesomeIcons.crosshairs, color: coral01),
                    ),
                  ))),
        ]));
  }
}
