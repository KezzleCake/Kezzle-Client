import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/cakes_repo.dart';
import 'package:kezzle/view_models/search_setting_vm.dart';
// import 'package:kezzle/view_models/id_token_provider.dart';
// import 'package:kezzle/view_models/search_setting_vm.dart';

class HomeCakeViewModel extends AutoDisposeAsyncNotifier<List<Cake>> {
  // late final CakesRepo _repository;
  CakesRepo? _repository;
  List<Cake> _cakeList = [];
  bool fetchMore = false;

  @override
  FutureOr<List<Cake>> build() async {
    // 이거 위도경도 바뀌면 재실행 되는건지 확인하기
    _repository = ref.read(cakesRepo);

    // 일단 첫번째 페이지로 데이터 가져오기
    final cakes = await _fetchCakes(afterId: null);
    _cakeList = cakes;

    return _cakeList;
  }

  Future<List<Cake>> _fetchCakes({String? afterId}) async {
    final lat = ref.watch(searchSettingViewModelProvider).latitude;
    final lon = ref.watch(searchSettingViewModelProvider).longitude;
    final radius = ref.watch(searchSettingViewModelProvider).radius;

    if (lat == 0.0 && lon == 0.0) {
      return [];
    }

    final Map<String, dynamic>? result = await _repository!.fetchCakes(
      dist: radius,
      lat: lat,
      lng: lon,
      afterId: afterId,
      count: 18,
    );

    if (result == null) {
      return [];
    } else {
      final List<Cake> fetchedCakes = [];

      result['cakes'].forEach((cake) {
        fetchedCakes.add(Cake.fromJson(cake));
      });
      fetchMore = result['hasMore'] as bool;
      return fetchedCakes;
      // return [];
    }
  }

  // 다음 페이지 요청
  Future<void> fetchNextPage() async {
    if (fetchMore == true) {
      fetchMore = false;
      List<Cake> newCakesList = [];

      final result = await _fetchCakes(afterId: _cakeList.last.cursor);
      // final result = await _fetchCakes(afterId: _cakeList.last.id);

      newCakesList = result;
      _cakeList = [..._cakeList, ...newCakesList];
      state = AsyncValue.data(_cakeList);
    } else {
      return;
    }
  }

  // 반경이나, 위치 변환시, 새로고침시에 새 스토어 리스트 가져와서 갱신해주는 메서드
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    // 데이터 새로 가져오고, 갱신
    final cakes = await _fetchCakes(afterId: null);
    // 복사본 유지
    _cakeList = cakes;
    // 아예 새로운 리스트로 갱신
    state = AsyncValue.data(_cakeList);
  }
}

// notifier를 expose , 뷰모델 초기화.
final homeCakeProvider =
    AsyncNotifierProvider.autoDispose<HomeCakeViewModel, List<Cake>>(
  () => HomeCakeViewModel(),
  dependencies: [searchSettingViewModelProvider],
);
