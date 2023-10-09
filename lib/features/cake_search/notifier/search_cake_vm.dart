import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/features/cake_search/notifier/search_keywords_notifier.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/cakes_repo.dart';

class SearchCakeViewModel extends AsyncNotifier<List<Cake>> {
  late final CakesRepo _repository = ref.read(cakesRepo);
  bool fetchMore = false;
  int nextPage = -1;
  SearchKeywordsNotifier get _searchKeywordsNotifier =>
      ref.read(searchKeywordsProvider.notifier);
  List<String> get _searchKeywords => ref.read(searchKeywordsProvider);

  @override
  FutureOr<List<Cake>> build() => [];

  Future<void> addSearch(String keyword, {void Function()? onSearch}) async {
    // print('refresh($keyword) 실행됨');

    final canSearch = _searchKeywordsNotifier.addKeyword(keyword);
    if (!canSearch) return;

    // await _search().then((_) => onSearch?.call());
    _search();
    onSearch?.call();
  }

  Future<void> deleteKeywordsWithReSearch(String keyword,
      {void Function()? changeSearchMode}) async {
    _searchKeywordsNotifier.deleteKeyword(keyword);

    // 키워드 리스트가 비어있으면 search 실행 안함
    if (_searchKeywords.isEmpty) {
      state = const AsyncValue.data([]);
      changeSearchMode?.call();
      return;
    }
    await _search();
  }

  Future<void> _search() async {
    state = const AsyncValue.loading();
    final cakes = await _getCakesAndUpdateScrollData(keywords: _searchKeywords);
    if (cakes == null) return;
    state = AsyncValue.data(cakes);
  }

  // 다음 페이지 요청
  Future<void> fetchNextPage() async {
    if (!fetchMore) return;

    print('추가 데이터 요청');
    fetchMore = false;
    final result = await _getCakesAndUpdateScrollData(
        keywords: _searchKeywords, page: nextPage);
    if (result == null) return;
    state = AsyncValue.data(state.asData!.value + result);
  }

  Future<List<Cake>?> _getCakesAndUpdateScrollData(
      {required List<String> keywords, int? page}) async {
    if (keywords.isEmpty) return null;

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
