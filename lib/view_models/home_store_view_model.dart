import 'dart:async';

// import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/home_stores_repo.dart';
import 'package:kezzle/view_models/search_setting_vm.dart';

class HomeStoreViewModel extends AsyncNotifier<List<HomeStoreModel>> {
  late final HomeStoresRepo _repository;
  // 더미 데이터!!
  List<HomeStoreModel> _homeStoreList = [
    HomeStoreModel(
      id: '1',
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
    HomeStoreModel(
      id: '2',
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
    HomeStoreModel(
      id: '3',
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
    HomeStoreModel(
      id: '4',
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
    _repository = ref.read(homeStoreRepo);

    // api 로부터 응답받는데 걸리는 시간을 2초로 가정
    await Future.delayed(const Duration(seconds: 2));
    // throw Exception("데이터 fetch 실패");

    // 일단 첫번째 페이지로 데이터 가져오기
    // _homeStoreList = await _fetchStores(page: null);

    return _homeStoreList;
  }

  Future<List<HomeStoreModel>> _fetchStores({int? page}) async {
    final result = await _repository.fetchStores(page: page);
    final List<HomeStoreModel> stores = [];
    // 받아온정보 map으로 각 스토어를 HomeStoreModel로 변환해서 리스트 만들기
    // final newList = [];
    return stores;
  }

  // 다음 페이지 요청
  Future<void> fetchNextPage() async {
    // 페이지별로 아이템이 몇개인지 모르겠네.. 페이지 요청을 어케하누!
    // 현재 리스트에 있는 아이템 개수로 담페이지 계산하구 요청할 수 있으려나?
    // if (_homeStoreList.length >8 ) {}
    // final nextPage = await _repository.fetchStores(page: 1);
    // final newList = [];
    // 더해진 리스트를 state에 넣어주기
    // state = AsyncValue.data([..._homeStoreList, ...newList]);
  }

  // 반경이나, 위치 변환시, 새로고침시에 새 스토어 리스트 가져와서 갱신해주는 메서드
  Future<void> refresh() async {
    // final lat = ref.watch(searchSettingViewModelProvider).latitude;
    // final lon = ref.watch(searchSettingViewModelProvider).longitude;
    // 데이터 새로 가져오고, 갱신
    // final stores = await _fetchStores(page: null);
    // _list = stores; -> 복사본 유지..
    await Future.delayed(const Duration(seconds: 2));
    // throw Exception("데이터 fetch 실패");
    print('되기는 하는거냐고..');
    // 아예 새로운 리스트로 갱신
    state = const AsyncValue.data([]);
  }
}

// notifier를 expose , 뷰모델 초기화.
final homeStoreProvider =
    AsyncNotifierProvider<HomeStoreViewModel, List<HomeStoreModel>>(
  () => HomeStoreViewModel(),
);
