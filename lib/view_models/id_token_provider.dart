import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';

class IdTokenProvider extends AsyncNotifier<IdTokenResult> {
  late AuthRepo _authRepo;
  IdTokenResult? tokenData;

  @override
  FutureOr<IdTokenResult> build() async {
    // 처음 쓸 때는 idToken 가져오기
    _authRepo = ref.read(authRepo);
    tokenData = await _authRepo.user!.getIdTokenResult(true);
    return tokenData!;
  }

  // id토큰값을 읽어오는 함수, 만료된 토큰인지 확인하고 만료된 경우에는 새로운 토큰을 발급받아서 반환함.
  Future<String> getIdToken() async {
    tokenData ??= await _authRepo.user!.getIdTokenResult(true);
    // 저장된 토큰이 만료되었는지 확인
    if (tokenData!.expirationTime!.isBefore(DateTime.now())) {
      // 만료되었으면 새로운 토큰 발급받기
      tokenData = await _authRepo.user!.getIdTokenResult(true);
      return tokenData!.token!;
    } else {
      // 만료되지 않았으면 그냥 토큰 반환
      return tokenData!.token!;
    }
  }
}

final tokenProvider = AsyncNotifierProvider<IdTokenProvider, IdTokenResult>(
  () {
    return IdTokenProvider();
  },
);
