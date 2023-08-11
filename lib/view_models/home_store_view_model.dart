import 'dart:async';

// import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/stores_repo.dart';
import 'package:kezzle/view_models/search_setting_vm.dart';

class HomeStoreViewModel extends AsyncNotifier<List<HomeStoreModel>> {
  StoreRepo? _storeRepo;
  // AuthRepo? _authRepo;
  List<HomeStoreModel> _homeStoreList = [];
  bool fetchMore = false;

  @override
  FutureOr<List<HomeStoreModel>> build() async {
    // print('ddddddddddddddd');
    _storeRepo = ref.read(storeRepo);
    // _authRepo = ref.read(authRepo);

    // 처음 데이터는 1페이지로 가져오기
    // List<HomeStoreModel> stores = [];
    final stores = await _fetchStores(
      afterDistance: null,
    );
    // final response = await _fetchStores(page: null);
    _homeStoreList = stores;
    // 일단 첫번째 페이지로 데이터 가져오기
    // _homeStoreList = await _fetchStores(page: null);

    // ref.listen(searchSettingViewModelProvider, (previous, next) {
    //   // print(previous!.radius);
    //   // print(next!.radius);
    //   print('이거되냐?');
    //   if (previous != next) {
    //     // ref.read(homeStoreProvider.notifier).refresh();
    //     refresh();
    //   }
    // });

    // 처음 빌드때 가져와야될듯
    // fetchMore = true;
    return _homeStoreList;
  }

  Future<List<HomeStoreModel>> _fetchStores({double? afterDistance}) async {
    // 위도, 경도, 유저 가져와서 api 요청
    final lat = ref.watch(searchSettingViewModelProvider).latitude;
    final lon = ref.watch(searchSettingViewModelProvider).longitude;

    final Map<String, dynamic>? result = await _storeRepo!.fetchStores(
      lat: lat,
      lng: lon,
      count: 8,
      afterDistance: afterDistance,
    );
    // print(result);
    if (result == null) {
      return [];
    } else {
      // print(result['stores']);
      // final List<HomeStoreModel> fetchedStores = result['stores']
      //     .map((e) => HomeStoreModel.fromJson(e))
      //     .toList() as List<HomeStoreModel>;

      // final List<HomeStoreModel> fetchedStores = result['stores'].map(
      //   (e) {
      //     print('스토어 출력');
      //     print(e);
      //     return HomeStoreModel.fromJson(e);
      //   },
      // ).toList();
      final List<HomeStoreModel> fetchedStores = [];
      result['stores'].forEach((e) {
        // print(e);
        fetchedStores.add(HomeStoreModel.fromJson(e));
      });
      fetchMore = result['hasMore'] as bool;
      print(fetchMore);

      return fetchedStores;
    }
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

    // 더 가져올것이 있다면 일단 false로 재요청 못하게 막아두고, 요청받아서
    // 그 결과에 따라 f/t 바꾸기
    if (fetchMore == true) {
      fetchMore = false;
      // await Future.delayed(Duration(seconds: 2));
      List<HomeStoreModel> newHomeStoreList = [];

      final result = await _fetchStores(
        afterDistance: _homeStoreList.last.distance,
      );
      // print(_homeStoreList.last.name);
      newHomeStoreList = result;
      // for (int i = 0; i < newHomeStoreList.length; i++) {
      //   print(newHomeStoreList[i].name);
      // }
      _homeStoreList = [..._homeStoreList, ...newHomeStoreList];
      state = AsyncValue.data(_homeStoreList);
      // 가져온 걸로 t/f 맞춰서 넣기 -> 이게 맞나?
      // fetchMore = true;
    } else {
      return;
    }
  }

  // 반경이나, 위치 변환시, 새로고침시에 새 스토어 리스트 가져와서 갱신해주는 메서드
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    // 데이터 새로 가져오고, 갱신
    final fetchedStores = await _fetchStores(
      afterDistance: null,
    );
    // 복사본 유지
    _homeStoreList = fetchedStores;
    // 아예 새로운 리스트로 갱신
    state = AsyncValue.data(_homeStoreList);
  }
}

// notifier를 expose , 뷰모델 초기화.
final homeStoreProvider =
    AsyncNotifierProvider<HomeStoreViewModel, List<HomeStoreModel>>(
  () => HomeStoreViewModel(),
  dependencies: [searchSettingViewModelProvider, authState],
);
