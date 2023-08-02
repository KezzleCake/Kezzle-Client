import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
import 'package:kezzle/features/profile/models/user_model.dart';
import 'package:kezzle/features/profile/repos/user_repo.dart';

class ProfileVM extends AsyncNotifier<UserModel> {
  late final UserRepository _userRepo;
  late final AuthenticatoinRepository _authRepo;

  @override
  FutureOr<UserModel> build() async {
    // 딜레이 테스트
    // await Future.delayed(const Duration(seconds: 7));

    _userRepo = ref.read(userRepo);
    _authRepo = ref.read(authRepo);

    // 로그인된 상태면 서버에 요청해서 데이터 가져오기.
    if (_authRepo.isLoggedIn) {
      // 토큰을 가져오기.
      // final String? token = await _authRepo.user!.getIdToken();
      // 서버에 요청해서 프로필 정보  json으로 가져오기
      final Map<String, dynamic>? profile =
          await _userRepo.fetchProfile(_authRepo.user!);
      if (profile != null) {
        return UserModel.fromJson(profile);
        // return UserModel(
        //   uid: '1',
        //   email: 'vvvv@nate.com',
        //   nickname: '으응?',
        //   oathProvider: 'nate.com',
        // );
      }
    }

    // 로그인 안된 상태면 빈 데이터 반환
    return UserModel.empty();
    // 지금은 일단 더미 데이터 반환
    // return UserModel(
    //   uid: '180',
    //   email: 'kezzle180@nate.com',
    //   nickname: '푸치짱귀여움',
    //   oathProvider: 'nate.com',
    // );
  }

  // 새로 로그인한 유저 정보 받아서 프로필 정보 서버에 저장
  Future<void> createProfile(
      /*UserCredential credential,*/ String nickname) async {
    state = const AsyncValue.loading();
    // 토큰을 가져와서
    final String? token = await _authRepo.user!.getIdToken();

    // if (credential.user == null) {
    //   throw Exception("유저 정보가 없습니다.");
    // }

    // 유저 프로필 정보를 만들어서
    // final profile = UserModel(
    //   uid: credential.user!.uid,
    //   email: credential.user!.email! ?? "kezzle@google.com",
    //   nickname: nickname,
    //   // 프로바이더가 잘 나오는지 모르겠네.. 일단...적어놓자..
    //   oathProvider: credential.user!.providerData[0].providerId ?? "kakao.com",
    // );
    // 서버에 저장
    // await _userRepo.createProfile(profile);
    // state = AsyncValue.data(profile);

    // 유저 프로필 정보를 만들어서
    final profile = UserModel(
      uid: _authRepo.user!.uid,
      email: _authRepo.user!.email!,
      nickname: nickname,
      oathProvider: _authRepo.user!.providerData[0].providerId,
    );
    // 서버에 저장 후, state 변경
    await _userRepo.createProfile(profile, _authRepo.user!);
    state = AsyncValue.data(profile);
  }

  // 닉네임 수정 시, 변경 내용을 서버에 저장
  Future<void> updateProfile(String nickname) async {
    // profile에서 닉네임만 수정
    // final UserModel profile = UserModel(
    //   uid: state.value!.uid,
    //   nickname: nickname,
    //   email: state.value!.email,
    //   oathProvider: state.value!.oathProvider,
    // );
    // 서버에 업데이트
    await _userRepo.updateProfile(_authRepo.user!, nickname);

    // state 변경
    // state = AsyncValue.data(profile);
    state = AsyncValue.data(state.value!.copyWith(nickname: nickname));
  }
}

final profileProvider = AsyncNotifierProvider<ProfileVM, UserModel>(
  () => ProfileVM(),
);
