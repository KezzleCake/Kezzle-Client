import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';

class IdTokenProvider extends AsyncNotifier<IdTokenResult?> {
  late AuthRepo _authRepo;
  IdTokenResult? tokenData;

  @override
  FutureOr<IdTokenResult?> build() async {
    // 처음 쓸 때는 idToken 가져오기
    _authRepo = ref.read(authRepo);
    if (_authRepo.user == null) {
      return null;
    } else {
      tokenData = await _authRepo.user!.getIdTokenResult(true);
    }
    return tokenData!;
  }

  // id토큰값을 읽어오는 함수, 만료된 토큰인지 확인하고 만료된 경우에는 새로운 토큰을 발급받아서 반환함.
  Future<String> getIdToken({bool? newtoken}) async {
    if (tokenData == null || newtoken == true) {
      // 값 캐싱
      tokenData = await _authRepo.user!.getIdTokenResult(true);
      // state 변경
      state = AsyncValue.data(tokenData!);
      return tokenData!.token!;
    } else {
      return tokenData!.token!;
    }

    // tokenData ??= await _authRepo.user!.getIdTokenResult(true);
    // 저장된 토큰이 만료되었는지 확인
    // if (tokenData!.expirationTime!.isBefore(DateTime.now())) {
    //   // 만료되었으면 새로운 토큰 발급받기
    //   tokenData = await _authRepo.user!.getIdTokenResult(true);
    //   return tokenData!.token!;
    // } else {
    //   // 만료되지 않았으면 그냥 토큰 반환
    //   return tokenData!.token!;
    // }
  }

  // 토큰을 리셋하는 함수 . 토큰에 null 값 넣기
  void resetToken() {
    tokenData = null;
    state = AsyncValue.data(tokenData);
  }
}

final tokenProvider = AsyncNotifierProvider<IdTokenProvider, IdTokenResult?>(
  () {
    return IdTokenProvider();
  },
  dependencies: [authState],
);
