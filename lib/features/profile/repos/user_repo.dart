import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepository {
  // 유저 만들기
  Future<void> createProfile(UserModel) async {}

  // 유저 정보 가져오기

  // 닉네임 수정
}

final userRopo = Provider(
  (ref) => UserRepository(),
);
