import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/repo/current_keyword_repo.dart';

class RecentKeywordRecordNotifier extends Notifier<List<String>> {
  final CurrentKeywordRepository _repository;

  RecentKeywordRecordNotifier(this._repository);

  List<String> get _currentKeywordsAtRepository =>
      _repository.getCurrentKeywords();

  @override
  List<String> build() {
    return _currentKeywordsAtRepository;
  }

  void recordKeyword(String keyword) {
    if (state.contains(keyword)) _deleteKeyword(keyword);
    _addCurrentKeyword(keyword);
  }

  void _addCurrentKeyword(String keyword) {
    final modifiedKeywords = _currentKeywordsAtRepository..insert(0, keyword);
    if (modifiedKeywords.length > 5) modifiedKeywords.removeLast();

    _repository.setCurrentKeyword(modifiedKeywords);
    state = modifiedKeywords;
  }

  void _deleteKeyword(String keyword) {
    final modifiedKeywords = _currentKeywordsAtRepository..remove(keyword);
    _repository.setCurrentKeyword(modifiedKeywords);
    state = modifiedKeywords;
  }

  // 사용자가 키워드 검색한 내용 전부 삭제
  void deleteAllRecentKeyword() {
    _repository.setCurrentKeyword([]);
    state = [];
  }
}

final recentKeywordRecordProvider =
    NotifierProvider<RecentKeywordRecordNotifier, List<String>>(
  () => throw UnimplementedError(),
);
