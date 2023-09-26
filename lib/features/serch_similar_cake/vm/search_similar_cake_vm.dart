import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/models/similar_cake_model.dart';
import 'package:kezzle/repo/cakes_repo.dart';
import 'package:kezzle/view_models/search_setting_vm.dart';

class SearchSimilarCakeVM
    extends AutoDisposeFamilyAsyncNotifier<List<SimilarCake>, String> {
  late CakesRepo _cakesRepository;
  late String _cakeId;
  List<SimilarCake> _similarCakeList = [
    //더미 데이터
    // SimilarCake(
    //   id: '0',
    //   index: 0,
    //   imageUrl: 'assets/heart_cake.png',
    //   lat: 37.5612811,
    //   lng: 126.964338,
    // ),
    // SimilarCake(
    //   id: '1',
    //   index: 1,
    //   imageUrl: 'assets/heart_cake.png',
    //   lat: 37.5628941,
    //   lng: 126.965141,
    // ),
  ];

  @override
  FutureOr<List<SimilarCake>> build(String arg) async {
    // print('e다시 되는거니?');
    _cakeId = arg;
    _cakesRepository = ref.read(cakesRepo);

    
    // 유사 케이크 가져오기
    final fetcedCakes = await _fetchSimilarCakes();
    _similarCakeList = fetcedCakes;
    // await Future.delayed(const Duration(seconds: 2));

    return _similarCakeList;
  }

  Future<List<SimilarCake>> _fetchSimilarCakes() async {
    // 위도, 경도, 반경 가져와서 api 요청
    final lat = ref.watch(searchSettingViewModelProvider).latitude;
    final lon = ref.watch(searchSettingViewModelProvider).longitude;
    final dist = ref.watch(searchSettingViewModelProvider).radius;

    final Map<String, dynamic>? result =
        await _cakesRepository.fetchSimilarCakes(
      cakeId: _cakeId,
      lat: lat,
      lng: lon,
      dist: dist * 1000,
    );
    if (result == null) {
      return [];
    } else {
      final List<SimilarCake> fetchedCakes = [];

      result['cakes'].forEach((cake) {
        fetchedCakes.add(SimilarCake.fromJson(cake));
      });
      return fetchedCakes;
    }
  }
}

final similarCakeProvider = AsyncNotifierProvider.family
    .autoDispose<SearchSimilarCakeVM, List<SimilarCake>, String>(
  () => SearchSimilarCakeVM(),
  dependencies: [searchSettingViewModelProvider],
);
