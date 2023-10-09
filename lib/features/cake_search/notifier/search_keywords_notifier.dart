import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchKeywordsNotifier extends Notifier<List<String>> {
  @override
  List<String> build() => [];

  /// return : canSearch
  bool addKeyword(String keyword) {
    final canSearch = !state.contains(keyword);
    if (canSearch) state.insert(0, keyword);
    return canSearch;
  }

  void deleteKeyword(String keyword) {
    state.remove(keyword);
  }

  void clear() {
    state.clear();
  }
}

final searchKeywordsProvider =
    NotifierProvider<SearchKeywordsNotifier, List<String>>(
        () => SearchKeywordsNotifier());
