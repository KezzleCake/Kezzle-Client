import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/repo/current_keyword_repo.dart';

class CurrentKeywordVM extends Notifier<List<String>> {
  final CurrentKeywordRepository _repository;

  CurrentKeywordVM(this._repository);

  // 사용자가 키워드 검색한 내용 추가
  void addCurrentKeyword(String keyword) {
    // 기존에 저장된 키워드 목록을 불러옴
    final List<String> currentKeywordList = _repository.getCurrentKeyword();

    // 기존에 저장된 키워드 목록에 새로운 키워드를 추가
    // currentKeywordList.add(keyword);
    // if (currentKeywordList.length > 5) {
    // }

    // 기존에 저장된 키워드 목록에 새로운 키워드를 추가
    currentKeywordList.insert(0, keyword);
    if (currentKeywordList.length > 5) {
      currentKeywordList.removeLast();
    }

    _repository.setCurrentKeyword(currentKeywordList);

    state = currentKeywordList;
    print('키워드들 확인');
    print(currentKeywordList);
  }

  // 사용자가 키워드 검색한 내용 전부 삭제
  void deleteAllRecentKeyword() {
    _repository.setCurrentKeyword([]);
    state = [];
  }

  void deleteKeyword(String keyword) {
    final List<String> currentKeywordList = _repository.getCurrentKeyword();
    currentKeywordList.remove(keyword);
    _repository.setCurrentKeyword(currentKeywordList);
    state = currentKeywordList;
  }

  @override
  List<String> build() {
    return _repository.getCurrentKeyword();
  }
}

final currentKeywordVMProvider =
    NotifierProvider<CurrentKeywordVM, List<String>>(
  () => throw UnimplementedError(),
);
