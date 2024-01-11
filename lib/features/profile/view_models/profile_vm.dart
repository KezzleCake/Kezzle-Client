import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:kezzle/features/authentication/login_screen.dart';
import 'package:kezzle/features/authentication/repos/authentication_repo.dart';
import 'package:kezzle/features/profile/models/user_model.dart';
import 'package:kezzle/features/profile/repos/user_repo.dart';
// import 'package:kezzle/router.dart';

class ProfileVM extends AutoDisposeAsyncNotifier<UserModel> {
  late final UserRepo _userRepo;
  late final AuthRepo _authRepo;

  @override
  FutureOr<UserModel> build() async {
    // 딜레이 테스트
    // await Future.delayed(const Duration(seconds: 7));

    _userRepo = ref.read(userRepo);
    _authRepo = ref.read(authRepo);

    // 로그인된 상태면 서버에 요청해서 데이터 가져오기.
    if (_authRepo.isLoggedIn) {
      // print('로그인된상태');
      // 토큰을 가져오기.
      // final String? token = await _authRepo.user!.getIdToken();
      // 서버에 요청해서 프로필 정보  json으로 가져오기
      final Map<String, dynamic>? profile =
          await _userRepo.fetchProfile(_authRepo.user!);
      if (profile != null) {
        print('프로필 있음');
        // print(profile);
        // ref.watch(authRepo).dbUserExists = true;
        // return UserModel.fromJson(profile);

        List<String> fetchedroles = [];
        if (profile['roles'] != null) {
          fetchedroles = List<String>.from(profile['roles']);
        }

        return UserModel(
          uid: _authRepo.user!.uid,
          email: _authRepo.user!.email!,
          nickname: profile['nickname'] as String,
          oathProvider: _authRepo.user!.providerData[0].providerId,
          roles: fetchedroles,
        );
      } else {
        print('프로필 없음');
        return UserModel.empty();
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
  // Future<void> createProfile(
  //     /*UserCredential credential,*/ String nickname) async {
  //   state = const AsyncValue.loading();
  //   // 토큰을 가져와서
  //   final String? token = await _authRepo.user!.getIdToken();

  //   // if (credential.user == null) {
  //   //   throw Exception("유저 정보가 없습니다.");
  //   // }

  //   // 유저 프로필 정보를 만들어서
  //   // final profile = UserModel(
  //   //   uid: credential.user!.uid,
  //   //   email: credential.user!.email! ?? "kezzle@google.com",
  //   //   nickname: nickname,
  //   //   // 프로바이더가 잘 나오는지 모르겠네.. 일단...적어놓자..
  //   //   oathProvider: credential.user!.providerData[0].providerId ?? "kakao.com",
  //   // );
  //   // 서버에 저장
  //   // await _userRepo.createProfile(profile);
  //   // state = AsyncValue.data(profile);

  //   // 유저 프로필 정보를 만들어서
  //   final profile = UserModel(
  //     uid: _authRepo.user!.uid,
  //     email: _authRepo.user!.email!,
  //     nickname: nickname,
  //     oathProvider: _authRepo.user!.providerData[0].providerId,
  //   );
  //   // 서버에 저장 후, state 변경
  //   // await _userRepo.createProfile(profile, _authRepo.user!);
  //   state = AsyncValue.data(profile);
  // }

  // 닉네임 수정 시, 변경 내용을 서버에 저장
  Future<void> updateProfile(String nickname) async {
    // profile에서 닉네임만 수정
    // final UserModel profile = UserModel(
    //   uid: state.value!.uid,
    //   nickname: nickname,
    //   email: state.value!.email,
    //   oathProvider: state.value!.oathProvider,
    // );
    state = const AsyncValue.loading();
    // 서버에 업데이트
    final response = await _userRepo.updateProfile(_authRepo.user!, nickname);

    // state 변경
    // state = AsyncValue.data(profile);
    if (response != null) {
      // 업데이트 성공 시, state 변경
      state = AsyncValue.data(state.value!.copyWith(nickname: nickname));
    } else {
      // 업데이트 실패 시, 그냥 두기
    }
  }

  Future<void> deleteProfile() async {
    // 서버에서 삭제
    final response = await _userRepo.deleteProfile(_authRepo.user!);

    // 파이어베이스에서 삭제 겁나 어려움 미친
    if (response != null && response.statusCode == 200) {
      // 서버에서 삭제 성공 시, 파이어베이스도 회원탈퇴
      // credential을 받아서
      // 로그아웃
      //ref.read(authRepo).signOut();

      // await _authRepo.user!
      //     .reauthenticateWithCredential(_authRepo.oauthCredential);
      if (FirebaseAuth.instance.currentUser != null) {
        await _authRepo.user?.delete();
      } else {
        // 서버에서 삭제 실패 시, 그냥 두기
      }
    }
  }

  // user의 role이 admin인지 확인
  bool get isAdmin {
    if (state.value == null) {
      // print('이렇게 하면 고쳐지는 게 맞나');
      return false;
    }
    return state.value!.roles.contains('isAdmin');
  }
}

final profileProvider = AsyncNotifierProvider.autoDispose<ProfileVM, UserModel>(
  () => ProfileVM(),
);
