// 스토어 모델명 그냥 바꿀까..?
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/cakes_repo.dart';
import 'package:kezzle/view_models/id_token_provider.dart';

class BookmarkedCakeViewModel extends AsyncNotifier<List<Cake>> {
  late final CakesRepo _cakeRepo;
  late final AuthRepo _authRepository;

  // 더미 데이터!!
  late List<Cake> _bookmarkedCakeList;

  @override
  FutureOr<List<Cake>> build() async {
    _cakeRepo = ref.read(cakesRepo);
    _authRepository = ref.read(authRepo);

    // 사용자가 찜한 케이크목록 가져오기
    final result = await _fetchBookmarkedCakes(page: null);
    _bookmarkedCakeList = result;
    return _bookmarkedCakeList;
  }

  // 좋아요한 케이크 목록 가져오는 메서드
  Future<List<Cake>> _fetchBookmarkedCakes({int? page}) async {
    final User user = _authRepository.user!;
    final String token = await ref.read(tokenProvider.notifier).getIdToken();

    final List<dynamic>? result = await _cakeRepo.fetchBookmarkedCakes(
      token: token,
      user: user,
    );
    // print(result);
    if (result == null) {
      return [];
    } else {
      final List<Cake> fetchedBookmarkedCakes =
          result.map((e) => Cake.fromJson(e)).toList();
      return fetchedBookmarkedCakes;
    }
  }

  // 좋아요 정보 바뀌면 새로 가져와야됨.
  // refresh 함수 만들어주자.
  Future<void> refresh() async {
    // 데이터 새로 가져오고, 갱신
    // 사용자가 찜한 케이크 목록 가져오기
    final cakes = await _fetchBookmarkedCakes(page: null);
    // 복사본 유지
    _bookmarkedCakeList = cakes;
    // 아예 새로운 리스트로 갱신
    state = AsyncValue.data(_bookmarkedCakeList);
  }
}

// notifier를 expose , 뷰모델 초기화.
final bookmarkedCakeProvider =
    AsyncNotifierProvider<BookmarkedCakeViewModel, List<Cake>>(
  () => BookmarkedCakeViewModel(),
);
