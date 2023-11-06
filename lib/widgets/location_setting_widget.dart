import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:kezzle/features/address_search/address_search_vm.dart';
import 'package:kezzle/features/onboarding/current_location_screen.dart';
import 'package:kezzle/features/onboarding/current_location_service.dart';
import 'package:kezzle/models/address_model.dart';
import 'package:kezzle/utils/colors.dart';
import 'package:kezzle/view_models/search_setting_vm.dart';
import 'package:kezzle/view_models/searched_address_view_model.dart';

class LocationSettingWidget extends ConsumerStatefulWidget {
  const LocationSettingWidget({
    super.key,
  });

  @override
  LocationSettingWidgetState createState() => LocationSettingWidgetState();
}

class LocationSettingWidgetState extends ConsumerState<LocationSettingWidget> {
  final TextEditingController _textfiledController = TextEditingController();
  bool _isSearched = false;
  FocusNode myFocusNode = FocusNode();
  bool _isFocused = false;

  // List<String> historySearchedList = [
  //   '서울 강남구 테헤란로',
  //   '경기 파주시 경의로 997-15',
  //   '서울 동작구 상도로 47가길 28',
  //   '서울 서초구 서초대로 65길 13-10',
  // ];
  // List<String> searchedList = [
  //   '경기 파주시 10004번길',
  //   '경기 파주시 경의로',
  //   '경기 파주시 경의로1240번길',
  //   '경기 파주시 경의로 983 한소망교회',
  //   '경기 파주시 경의로 982',
  //   '경기 파주시 경의로 982-2',
  // ];

  // 사용자가 주소를 검색한 기록
  // List<AddressModel> historySearchedList = [
  //   AddressModel(
  //       latitude: 37.7065276,
  //       longitude: 126.758759,
  //       address: "경기 파주시 경의로 997-15"),
  //   AddressModel(
  //       latitude: 37.7065276,
  //       longitude: 126.758759,
  //       address: "경기 파주시 경의로 997-15"),
  //   AddressModel(
  //       latitude: 37.7065276,
  //       longitude: 126.758759,
  //       address: "경기 파주시 경의로 997-15"),
  // ];
  List<AddressModel> searchedList = [];
  List<AddressModel> historySearchedList = [];

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        // 포커스가 설정된 경우에 대한 동작 수행
        print('포커스 설정');
        setState(() {
          _isFocused = true;
        });
      } else {
        // 포커스가 해제된 경우에 대한 동작 수행
        print('포커스 해제');
        setState(() {
          _isFocused = false;
        });
      }
    });
    _textfiledController.addListener(() {
      // 텍스트필드의 값이 변경될 때마다 호출
      if (_textfiledController.text.isEmpty) {
        // 텍스트필드의 값이 비어있는 경우
        setState(() {
          _isSearched = false;
        });
      }
    });
    Future.delayed(Duration.zero, () {
      // print(ref
      //     .watch(searchedHistoryAddressVMProvider)
      //     .searchedHistoryAddressList
      //     .length);
      for (int i = ref
                  .watch(searchedHistoryAddressVMProvider)
                  .searchedHistoryAddressList
                  .length -
              1;
          i >= 0;
          i--) {
        String result = ref
            .watch(searchedHistoryAddressVMProvider)
            .searchedHistoryAddressList[i];
        List<String> resultSplit = result.split(',');
        historySearchedList.add(AddressModel(
          latitude: double.parse(resultSplit[1]),
          longitude: double.parse(resultSplit[0]),
          address: resultSplit[2],
        ));
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _textfiledController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  void onSubmitted(String value) {
    _isSearched = true;
    // print('onSubmitted: $value');

    // 검색 결과 가져오기
    AddressSearchVM().searchAddress(value).then((value) {
      // print('검색결과\n');
      // print(value);

      //검색된 주소 리스트 변경
      searchedList = [];
      // print(value['documents'].length);

      for (int i = 0; i < value['documents'].length; i++) {
        // if (value['documents'][i]['road_address'] == null) {
        //   break;
        // }
        if (value['documents'][i]['address_name'] == null) {
          break;
        }
        // searchedList.add(value['documents'][i]['road_address']['address_name']);
        // searchedList.add(value['documents'][i]['address_name']);
        searchedList.add(AddressModel(
            latitude: double.parse(value['documents'][i]['y']),
            longitude: double.parse(value['documents'][i]['x']),
            address: value['documents'][i]['address_name']));
      }
      setState(() {});
    });
  }

  void onTapAddress(int index) {
    // print('onTapAddress');
    // Navigator.pop(context);
    // pop하면서 주소값 전달
    // Navigator.pop(context, address);

    // 검색된 주소를 클릭한 경우, 검색 기록에 추가하기 -> 이미 검색된 주소면 추가하지 않아야하는데 어케함 조졌다.
    if (_isSearched) {
      ref
          .read(searchedHistoryAddressVMProvider.notifier)
          .addSearchedHistoryAddress(searchedList[index]);
    }
    // 설정 위치 바꾸기
    ref.read(searchSettingViewModelProvider.notifier).setAddress(_isSearched
        ? searchedList[index].address
        : historySearchedList[index].address);
    //설정 경도 바꾸기
    ref.read(searchSettingViewModelProvider.notifier).setLongitude(_isSearched
        ? searchedList[index].longitude
        : historySearchedList[index].longitude);
    // 설정 위도 바꾸기
    ref.read(searchSettingViewModelProvider.notifier).setLatitude(_isSearched
        ? searchedList[index].latitude
        : historySearchedList[index].latitude);

    //위도, 경도, 반경을 토대로 케이크 리스트 갱신 요청

    context.pop();
  }

  void onTapCurrentLocation() async {
    // 위치 권한 확인 후, 위치 받아오고 받아온 위치 전달해서 화면 이동
    final Position? currentPosition =
        await CurrentLocationService().getCurrentLocation();
    // print('currentPosition: ' + currentPosition.toString());
    if (!mounted) return;
    if (currentPosition != null) {
      context.pop();

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
    // print('onTapCurrentLocation');
    // context.pushNamed(CurrentLocationScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(

            // height: 453,
            // height: 470,
            height: MediaQuery.of(context).size.height * 0.55,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
                padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CupertinoSearchTextField(
                          onSubmitted: (value) => onSubmitted(value),
                          focusNode: myFocusNode,
                          suffixInsets: const EdgeInsets.only(right: 12),
                          prefixInsets: const EdgeInsets.only(left: 16),
                          prefixIcon:
                              SvgPicture.asset('assets/icons/search_bar.svg'),
                          decoration: BoxDecoration(
                              color: gray01,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: _isFocused ? orange01 : gray03)),
                          controller: _textfiledController,
                          // placeholder: '지번, 도로명, 건물명으로 검색',
                          placeholder: '도로명으로 검색',
                          placeholderStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: gray04),
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 16, right: 16, left: 6),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: gray06)),
                      const SizedBox(height: 24),
                      InkWell(
                          // 색 없애기
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () => onTapCurrentLocation(),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Text('현재 위치로 설정',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: gray06)),
                            const SizedBox(width: 8),
                            FaIcon(FontAwesomeIcons.locationDot,
                                color: orange01, size: 12)
                          ])),
                      const SizedBox(height: 24),
                      Text(_isSearched ? '검색 결과' : '검색 기록',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: gray06)),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.32,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _isSearched
                                ? searchedList.length
                                : historySearchedList.length,
                            // : historySearchedList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  onTapAddress(index);
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Text(
                                        _isSearched
                                            ? searchedList[index].address
                                            : historySearchedList[index]
                                                .address,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: gray05))),
                              );
                            }),
                      ),
                    ]))));
  }
}
