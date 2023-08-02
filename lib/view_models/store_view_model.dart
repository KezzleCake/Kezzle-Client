import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
import 'package:kezzle/repo/home_stores_repo.dart';

class StoreViewModel extends FamilyAsyncNotifier<void, String> {
  late final HomeStoresRepo _repository;
  late final _storeId;
  // like를 expose 시켜야할거같은데 ... 초기값은 그러면 어떻게 받아오지?
  // bool _liked = false;

  @override
  FutureOr<void> build(String storeId) {
    // 이건 언제 되는건가요
    print('a스토어 빌드');
    _storeId = storeId;
    _repository = ref.read(homeStoreRepo);
  }

  // 스토어 좋아요
  Future<void> likeStore() async {
    // 현재 로그인한 사용자 정보 읽기
    final user = ref.read(authRepo).user;
    // 스토어 좋아요 시, 스토어 아이디와 유저 정보를 넘겨준다.
    await _repository.likeStore(_storeId, user!);
  }

  // 스토어 좋아요 취소
  Future<void> dislikeStore() async {
    // 현재 로그인한 사용자 정보 읽기
    final user = ref.read(authRepo).user;
    // 스토어 좋아요 시, 스토어 아이디와 유저 정보를 넘겨준다.
    await _repository.dislikeStore(_storeId, user!);
  }
}

final storeProvider =
    AsyncNotifierProvider.family<StoreViewModel, void, String>(
  () => StoreViewModel(),
);
