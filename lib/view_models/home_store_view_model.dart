import 'dart:async';

// import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/models/home_store_model.dart';

class HomeStoreViewModel extends AsyncNotifier<List<HomeStoreModel>> {
  // 더미 데이터!!
  List<HomeStoreModel> _homeStoreList = [
    HomeStoreModel(
      name: '본비케이크',
      thumbnail: 'assets/heart_cake.png',
      address: '서울 강남구 역삼동',
      distance: '0.3km',
      iamges: [
        'assets/heart_cake.png',
        'assets/heart_cake.png',
        'assets/heart_cake.png',
      ],
      like: true,
    ),
  ];

  @override
  FutureOr<List<HomeStoreModel>> build() async {
    // api 로부터 응답받는데 걸리는 시간을 2초로 가정
    await Future.delayed(const Duration(seconds: 2));
    // throw Exception("데이터 fetch 실패");

    return _homeStoreList;
  }

  // 반경이나, 위치 변환시, 새로고침시에 새 스토어 리스트 가져와서 갱신해주는 메서드 필요할 듯
  Future<void> refresh(
      {required int radius,
      required double latitude,
      required double longitude}) async {
    // 데이터 새로 가져오고, 갱신
    // 로딩 상태 표시
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 2));
    // throw Exception("데이터 fetch 실패");
    print('되기는 하는거냐고..');
    state = const AsyncValue.data([]);
  }
}

// notifier를 expose , 뷰모델 초기화.
final homeStoreProvider =
    AsyncNotifierProvider<HomeStoreViewModel, List<HomeStoreModel>>(
  () => HomeStoreViewModel(),
);
