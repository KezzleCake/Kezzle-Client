import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/cakes_repo.dart';
import 'package:kezzle/view_models/id_token_provider.dart';
import 'package:kezzle/view_models/search_setting_vm.dart';

class HomeCakeViewModel extends AsyncNotifier<List<Cake>> {
  late final CakesRepo _repository;
  List<Cake> _cakeList = [];

  @override
  FutureOr<List<Cake>> build() async {
    _repository = ref.read(cakesRepo);

    // 일단 첫번째 페이지로 데이터 가져오기
    final cakes = await _fetchCakes(page: null);
    _cakeList = cakes;

    return _cakeList;
  }

  Future<List<Cake>> _fetchCakes({int? page}) async {
    // 위도, 경도, 토큰 가져와서 api 요청
    final lat = ref.read(searchSettingViewModelProvider).latitude;
    final lng = ref.read(searchSettingViewModelProvider).longitude;
    final token = await ref.read(tokenProvider.notifier).getIdToken();

    final List<dynamic>? result = await _repository.fetchCakes(
      token: token,
      lat: lat,
      lng: lng,
      page: page,
    );
    // print(result);
    // 받아온정보 map으로 각 스토어를 CakeModel로 변환해서 리스트 만들기
    if (result == null) {
      return [];
    } else {
      final List<Cake> cakes = result.map((e) => Cake.fromJson(e)).toList();
      return cakes;
    }
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
    state = const AsyncValue.loading();
    // 데이터 새로 가져오고, 갱신
    final cakes = await _fetchCakes(page: null);
    // 복사본 유지
    _cakeList = cakes;
    // 아예 새로운 리스트로 갱신
    state = AsyncValue.data(_cakeList);
  }
}

// notifier를 expose , 뷰모델 초기화.
final homeCakeProvider = AsyncNotifierProvider<HomeCakeViewModel, List<Cake>>(
  () => HomeCakeViewModel(),
);
