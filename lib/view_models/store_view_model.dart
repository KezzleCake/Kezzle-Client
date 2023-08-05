import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
import 'package:kezzle/features/bookmark/view_models/bookmarked_store_vm.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/stores_repo.dart';

class StoreViewModel extends FamilyAsyncNotifier<bool, String> {
  late final StoreRepo _repository;
  late final _storeId;
  late bool _liked;
  // like를 expose 시켜야할거같은데 ... 초기값은 그러면 어떻게 받아오지?
  // bool _liked = false;

  @override
  FutureOr<bool> build(String storeId) async {
    // 이건 언제 되는건가요
    print('특정 스토어 빌드');
    _storeId = storeId;
    _repository = ref.read(storeRepo);

    // 초기값은 또 받아와야될거같음..
    // 유저정보로 api 요청해서 해당 스토어의 좋아요 상태 가져오기?? -> 이런건 없음근데..
    // 일단 임의 초기값 false
    _liked = false;

    // await ref.watch(bookmarkedStoreProvider);

    // final bookmarkedStoreList = ref.read(bookmarkedStoreProvider).requireValue;
    print('북마크 스토어 리스트');

    state = AsyncValue.data(_liked);
    return _liked;
  }

  // 스토어 좋아요
  Future<void> likeStore(HomeStoreModel store) async {
    // 현재 로그인한 사용자 정보 읽기
    final user = ref.read(authRepo).user;
    // 스토어 좋아요 시, 스토어 아이디와 유저 정보를 넘겨준다.
    // 서버에 데이터 보내기
    final response = await _repository.likeStore(_storeId, user!);
    if (response != null && response.statusCode == 200) {
      _liked = true;
      state = AsyncValue.data(_liked);
      // 리스트에 넣어준거구나
      ref.read(bookmarkedStoreProvider.notifier).addBookmarkedStore(store);
    } else {
      return;
    }
  }

  // 스토어 좋아요 취소
  Future<void> dislikeStore() async {
    // 현재 로그인한 사용자 정보 읽기
    final user = ref.read(authRepo).user;
    // 스토어 좋아요 취소 시, 스토어 아이디와 유저 정보를 넘겨준다.
    // 서버에 데이터 보내기
    await _repository.dislikeStore(_storeId, user!);
    _liked = false;
    state = AsyncValue.data(_liked);
    // 리스트에서 빼준거구나~
    // ref.read(bookmarkedStoreProvider.notifier).dislikesStore(_storeId);
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
    AsyncNotifierProvider.family<StoreViewModel, bool, String>(
  () {
    return StoreViewModel();
  },
);
