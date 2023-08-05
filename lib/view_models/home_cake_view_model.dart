import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/models/cake_model.dart';
import 'package:kezzle/repo/cakes_repo.dart';
import 'package:kezzle/view_models/search_setting_vm.dart';

class HomeCakeViewModel extends AsyncNotifier<List<CakeModel>> {
  late final CakesRepo _repository;

  // 더미 데이터!!
  List<CakeModel> _cakeList = [
    CakeModel(
      id: '1',
      url: 'assets/heart_cake.png',
      storeId: '1',
      liked: true,
    ),
    CakeModel(
      id: '2',
      url: 'assets/smile_cake.png',
      storeId: '2',
      liked: true,
    ),
    CakeModel(
      id: '3',
      url: 'assets/heart_cake.png',
      storeId: '3',
      liked: true,
    ),
  ];

  @override
  FutureOr<List<CakeModel>> build() async {
    _repository = ref.read(cakesRepo);
    // api 응답 3초로 가정
    await Future.delayed(const Duration(seconds: 3));
    // final lat = ref.read(searchSettingViewModelProvider).latitude;
    // final lng = ref.read(searchSettingViewModelProvider).longitude;

    // 일단 첫번째 페이지로 데이터 가져오기
    // _cakeList = await _fetchCakes(page: null);

    return _cakeList;
  }

  Future<List<CakeModel>> _fetchCakes({int? page}) async {
    final result = await _repository.fetchCakes(page: page);
    final List<CakeModel> cakes = [];
    // 받아온정보 map으로 각 스토어를 CakeModel로 변환해서 리스트 만들기
    // final newList = [];
    return cakes;
  }

  // 다음 페이지 요청
  Future<void> fetchNextPage() async {
    // if (_cakeList.length >8 ) {}
    // final nextPage = await _repository.fetchCakes(page: 1);
    // final newList = [];
    // 더해진 리스트를 state에 넣어주기
    // state = AsyncValue.data([..._cakeList, ...newList]);
  }

  // 반경이나, 위치 변환시, 새로고침시에 새 스토어 리스트 가져와서 갱신해주는 메서드
  Future<void> refresh() async {
    // final lat = ref.read(searchSettingViewModelProvider).latitude;
    // final lon = ref.read(searchSettingViewModelProvider).longitude;
    // 데이터 새로 가져오고, 갱신
    // final cakes = await _fetchCakes(page: null);
    // _list = cakes; -> 복사본 유지..
    await Future.delayed(const Duration(seconds: 2));
    // throw Exception("데이터 fetch 실패");

    // 아예 새로운 리스트로 갱신
    state = const AsyncValue.data([]);
  }
}

// notifier를 expose , 뷰모델 초기화.
final homeCakeProvider =
    AsyncNotifierProvider<HomeCakeViewModel, List<CakeModel>>(
  () => HomeCakeViewModel(),
);
