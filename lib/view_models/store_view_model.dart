import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
// import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
import 'package:kezzle/features/bookmark/view_models/bookmarked_store_vm.dart';
// import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/stores_repo.dart';
import 'package:kezzle/view_models/id_token_provider.dart';

class StoreViewModel extends FamilyNotifier<bool?, String> {
  late final StoreRepo _storeRepo;
  late final _storeId;
  bool? like;
  // like를 expose 시켜야할거같은데 ... 초기값은 그러면 어떻게 받아오지?
  // bool _liked = false;

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
    if (like! == true) {
      dislikeStore();
    } else {
      // likeStore(store);
      likeStore();
    }
  }

  // 스토어 좋아요
  Future<void> likeStore(/*HomeStoreModel store*/) async {
    // 현재 로그인한 사용자 정보 읽기
    // final user = ref.read(authRepo).user;
    // 스토어 좋아요 시, 스토어 아이디와 유저 정보를 넘겨준다.
    // 서버에 데이터 보내기

    String token = await ref.read(tokenProvider.notifier).getIdToken();

    final response = await _storeRepo.likeStore(_storeId, token);
    if (response == 'true') {
      like = true;
      state = like;
      // 북마크 리스트에 넣어주기
      // ref.read(bookmarkedStoreProvider.notifier).addBookmarkedStore(store);
      ref.read(bookmarkedStoreProvider.notifier).refresh();
    } else {
      return;
    }
  }

  // 스토어 좋아요 취소
  Future<void> dislikeStore() async {
    // 현재 로그인한 사용자 정보 읽기
    // final user = ref.read(authRepo).user;
    // 스토어 좋아요 취소 시, 스토어 아이디와 유저 정보를 넘겨준다.
    // 서버에 데이터 보내기
    String token = await ref.read(tokenProvider.notifier).getIdToken();

    final response = await _storeRepo.dislikeStore(_storeId, token);
    if (response!.statusCode == 200) {
      like = false;
      state = like;
      // // 북마크 리스트에서 빼주기
      // ref
      //     .read(bookmarkedStoreProvider.notifier)
      //     .deleteBookmarkedStore(_storeId);
      ref.read(bookmarkedStoreProvider.notifier).refresh();
    } else {
      return;
    }
  }

  // Future<void> toggleLike() async {
  //   if (_liked) {
  //     await dislikeStore();
  //   } else {
  //     await likeStore();
  //   }
  // }
}

final storeProvider = NotifierProvider.family<StoreViewModel, bool?, String>(
  () {
    return StoreViewModel();
  },
  dependencies: [authState],
);
// final storeProvider = NotifierProvider.family<StoreViewModel, bool, String>(
//   () {
//     // ref.watch(bookmarkedStoreProvider);
//     return StoreViewModel();
//   },
// );
