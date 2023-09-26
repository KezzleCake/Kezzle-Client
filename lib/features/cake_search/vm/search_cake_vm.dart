import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/cakes_repo.dart';

class SearchCakeViewModel extends AsyncNotifier<List<Cake>> {
  late final CakesRepo _repository = ref.read(cakesRepo);
  bool fetchMore = false;
  int nextPage = -1;

  @override
  FutureOr<List<Cake>> build() {
    // print('SearchCakeViewModel build() 실행됨');
    return [];
  }

  Future<void> search({required List<String> keywords}) async {
    print('refresh($keywords) 실행됨');

    state = const AsyncValue.loading();
    final cakes = await _getCakes(keywords: keywords);
    state = AsyncValue.data(cakes);
  }

  // 다음 페이지 요청
  Future<void> fetchNextPage({required List<String> keywords}) async {
    if (!fetchMore) return;

    print('추가 데이터 요청');
    fetchMore = false;
    final result = await _getCakes(keywords: keywords, page: nextPage);
    // state = AsyncValue.data(state.asData!.value + result);
    state = AsyncValue.data([...state.asData!.value, ...result]);
  }

  Future<List<Cake>> _getCakes(
      {required List<String> keywords, int? page}) async {
    final result = await _repository.searchCakes(
      keywords: keywords,
      page: page,
    );
    if (result == null) return [];

    fetchMore = result.hasMore;
    nextPage = result.nextPage;
    return result.cakes;
  }
}

final searchCakeViewModelProvider =
    AsyncNotifierProvider<SearchCakeViewModel, List<Cake>>(
        () => SearchCakeViewModel());
