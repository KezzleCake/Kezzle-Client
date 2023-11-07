import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/features/bookmark/view_models/bookmarked_store_vm.dart';
import 'package:kezzle/repo/stores_repo.dart';

class StoreViewModel extends AutoDisposeFamilyNotifier<bool?, String> {
  late final StoreRepo _storeRepo;
  late final _storeId;
  bool? like;

  @override
  bool? build(String storeId) {
    _storeId = storeId;
    _storeRepo = ref.read(storeRepo);
    return null;
  }

  bool init(bool liked) {
    if (like == null) {
      like = liked;
      state = like;
      return like!;
    }
    return like!;
  }

  void toggleLike(/*HomeStoreModel store*/) {
    // if (like == null) init(false);
    if (like! == true) {
      dislikeStore();
    } else {
      // likeStore(store);
      likeStore();
    }
  }

  // 스토어 좋아요
  Future<void> likeStore() async {
    // 현재 로그인한 사용자 정보 읽기
    // final user = ref.read(authRepo).user;
    // 스토어 좋아요 시, 스토어 아이디와 유저 정보를 넘겨준다.
    // 서버에 데이터 보내기

    // 일단 변경!
    like = true;
    state = like;

    // 그리고 후처리!
    final response = await _storeRepo.likeStore(_storeId);
    if (response == 'true') {
      ref.read(bookmarkedStoreProvider.notifier).refresh();
      return;
    } else {
      // 성공 못했으면 다시 바꾸기
      like = false;
      state = like;
      return;
    }
  }

  // 스토어 좋아요 취소
  Future<void> dislikeStore() async {
    // 일단변경
    like = false;
    state = like;

    // 그리고 후처리!
    final response = await _storeRepo.dislikeStore(_storeId);
    if (response!.statusCode == 200) {
      // 성공했으면
      ref.read(bookmarkedStoreProvider.notifier).refresh();
      return;
    } else {
      // 성공 못했으면 다시 바꾸기
      like = true;
      state = like;
      return;
    }
  }
}

final storeProvider =
    NotifierProvider.family.autoDispose<StoreViewModel, bool?, String>(
  () {
    return StoreViewModel();
  },
);
