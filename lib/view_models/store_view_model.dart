import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
import 'package:kezzle/features/bookmark/view_models/bookmarked_store_vm.dart';
// import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/stores_repo.dart';
import 'package:kezzle/view_models/id_token_provider.dart';

class StoreViewModel extends FamilyAsyncNotifier<bool?, String> {
  late final StoreRepo _storeRepo;
  late final _storeId;
  bool? _liked;
  // like를 expose 시켜야할거같은데 ... 초기값은 그러면 어떻게 받아오지?
  // bool _liked = false;

  @override
  FutureOr<bool?> build(storeId) async {
    // print('이게 뭔데 대체');
    // print(ref.watch(bookmarkedStoreProvider).value);
    _storeId = storeId;
    _storeRepo = ref.read(storeRepo);
    // final likedStore = await ref
    //     .read(bookmarkedStoreProvider.notifier)
    //     .fetchBookmarkedStores(page: null);
    // for (var store in likedStore) {
    //   if (store.id == storeId) {
    //     _liked = true;
    //     break;
    //   } else {
    //     _liked = false;
    //   }
    // }
    // return _liked;
    return null;
  }

  void init(bool liked) {
    if (_liked == null) {
      _liked = liked;
      state = AsyncValue.data(_liked);
    } else {
      return;
    }
  }

  void toggleLike(/*HomeStoreModel store*/) {
    if (_liked!) {
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
      _liked = true;
      state = AsyncValue.data(_liked);
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
      _liked = false;
      state = AsyncValue.data(_liked);
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

final storeProvider =
    AsyncNotifierProvider.family<StoreViewModel, bool?, String>(
  () {
    return StoreViewModel();
  },
);
// final storeProvider = NotifierProvider.family<StoreViewModel, bool, String>(
//   () {
//     // ref.watch(bookmarkedStoreProvider);
//     return StoreViewModel();
//   },
// );
