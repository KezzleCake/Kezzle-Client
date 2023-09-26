import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
// import 'package:kezzle/features/profile/repos/user_repo.dart';
import 'package:kezzle/models/home_store_model.dart';
import 'package:kezzle/repo/stores_repo.dart';

// 스토어 모델명 그냥 바꿀까..?
class BookmarkedStoreViewModel
    extends AutoDisposeAsyncNotifier<List<HomeStoreModel>> {
  StoreRepo? _storeRepo;
  AuthRepo? _authRepo;

  // 더미 데이터!!
  late List<HomeStoreModel> _bookmarkedStoreList;

  @override
  FutureOr<List<HomeStoreModel>> build() async {
    _storeRepo = ref.read(storeRepo);
    _authRepo = ref.read(authRepo);

    //사용자가 찜한 스토어목록 가져오기
    final result = await fetchBookmarkedStores(page: null);
    _bookmarkedStoreList = result;
    return result;
    // return [];
  }

  // 좋아요한 스토어 목록 가져오는 메서드
  Future<List<HomeStoreModel>> fetchBookmarkedStores({int? page}) async {
    User? user = _authRepo!.user;

    final List<dynamic>? result = await _storeRepo!.fetchBookmarkedStores(
      user: user!,
      page: page,
    );
    // print(result);
    if (result == null) {
      return [];
    } else {
      final List<HomeStoreModel> fetcedBookmarkedStores = [];
      for (int i = 0; i < result.length; i++) {
        fetcedBookmarkedStores.add(HomeStoreModel.fromJson(result[i]));
      }

      // final List<HomeStoreModel> fetcedBookmarkedStores =
      //     result.map((e) => HomeStoreModel.fromJson(e)).toList();
      return fetcedBookmarkedStores;
    }
  }

  // 위도 경도.. 바뀌면 새로 가져와야됨.
  // refresh 함수 만들어주자.
  // 반경이나, 위치 변환시, 새로고침시에 새 스토어 리스트 가져와서 갱신해주는 메서드
  Future<void> refresh() async {
    // 데이터 새로 가져오고, 갱신
    // 사용자가 찜한 스토어목록 가져오기
    final stores = await fetchBookmarkedStores(page: null);
    // 복사본 유지
    _bookmarkedStoreList = stores;
    // 아예 새로운 리스트로 갱신
    state = AsyncValue.data(_bookmarkedStoreList);
  }

  void addBookmarkedStore(HomeStoreModel store) {
    store.isLiked = true;
    _bookmarkedStoreList.add(store);
    state = AsyncValue.data(_bookmarkedStoreList);
  }

  void deleteBookmarkedStore(String storeId) {
    _bookmarkedStoreList.removeWhere((element) => element.id == storeId);
    state = AsyncValue.data(_bookmarkedStoreList);
  }
}

// notifier를 expose , 뷰모델 초기화.
// final bookmarkedStoreProvider =
//     AsyncNotifierProvider<BookmarkedStoreViewModel, List<HomeStoreModel>>(
//   () {
//     return BookmarkedStoreViewModel();
//   },
// );

final bookmarkedStoreProvider = AsyncNotifierProvider.autoDispose<
    BookmarkedStoreViewModel, List<HomeStoreModel>>(
  () {
    return BookmarkedStoreViewModel();
  },
  dependencies: [authRepo],
);
