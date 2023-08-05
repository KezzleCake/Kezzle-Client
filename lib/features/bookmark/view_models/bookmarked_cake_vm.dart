// 스토어 모델명 그냥 바꿀까..?
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
import 'package:kezzle/models/cake_model.dart';
import 'package:kezzle/repo/cakes_repo.dart';

class BookmarkedStoreViewModel extends AsyncNotifier<List<CakeModel>> {
  late final CakesRepo _cakeRepository;
  late final AuthRepo _authRepository;

  // 더미 데이터!!
  List<CakeModel> _bookmarkedCakeList = [
    CakeModel(
      id: '1',
      url: 'assets/heart_cake.png',
      storeId: '1',
      liked: true,
    ),
    CakeModel(
      id: '2',
      url: 'assets/smile_cake.png',
      storeId: '2',
      liked: true,
    ),
  ];

  @override
  FutureOr<List<CakeModel>> build() async {
    _cakeRepository = ref.read(cakesRepo);
    _authRepository = ref.read(authRepo);
    // api 로부터 응답받는데 걸리는 시간 2초 가정
    // await Future.delayed(Duration(seconds: 2));
    // 여기도 설정된 위도경도 가져와서 api 요청해야됨.
    // final lat = ref.watch(searchSettingViewModelProvider).latitude;
    // final lon = ref.watch(searchSettingViewModelProvider).longitude;

    // 사용자가 찜한 스토어목록 가져오기
    // final result =
    //     await _cakeRepository.fetchBookmarkedCakes(_authRepository.user!);
    // final List<CakeModel> likedCakes = [];
    return _bookmarkedCakeList;
  }

  // 위도 경도.. 바뀌면 새로 가져와야됨.
  // refresh 함수 만들어주자.
  // 반경이나, 위치 변환시, 새로고침시에 새 스토어 리스트 가져와서 갱신해주는 메서드
  Future<void> refresh() async {
    // final lat = ref.watch(searchSettingViewModelProvider).latitude;
    // final lon = ref.watch(searchSettingViewModelProvider).longitude;
    // 데이터 새로 가져오고, 갱신
    // 사용자가 찜한 스토어목록 가져오기
    // final cakes =
    // await _cakeRepository.fetchBookmarkedCakes(_authRepository.user!);
    // _bookmarkedCakeList = cakes; -> 복사본 유지..

    // 아예 새로운 리스트로 갱신
    state = const AsyncValue.data([]);
  }
}

// // notifier를 expose , 뷰모델 초기화.
// final bookmarkedStoreProvider =
//     AsyncNotifierProvider<BookmarkedStoreViewModel, List<HomeStoreModel>>(
//   () => BookmarkedStoreViewModel(),
// );
