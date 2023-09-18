import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/cakes_repo.dart';

class SearchCakeViewModel extends AsyncNotifier<List<Cake>> {
  late final CakesRepo _repository;
  List<Cake> _cakes = [];

  @override
  FutureOr<List<Cake>> build() async {
    _repository = ref.read(cakesRepo);
    print('SearchCakeViewModel build() 실행됨');

    return _cakes;
  }

  Future<void> refresh({required List<String> keywords}) async {
    print('refresh() 실행됨');
    state = const AsyncValue.loading();
    final cakes = await _fetchCakes(keywords: keywords);
    _cakes = cakes;
    state = AsyncValue.data(_cakes);
  }

  Future<List<Cake>> _fetchCakes({required List<String> keywords}) async {
    final Map<String, dynamic>? result = await _repository.searchCakes(
      keywords: keywords,
    );

    if (result == null) {
      return [];
    } else {
      final List<Cake> fetchedCakes = [];

      result['cakes'].forEach((cake) {
        fetchedCakes.add(Cake.fromJson(cake));
      });
      return fetchedCakes;
    }
  }
}

final searchCakeViewModelProvider =
    AsyncNotifierProvider<SearchCakeViewModel, List<Cake>>(
  () => SearchCakeViewModel(),
);
