import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/features/profile/models/user_model.dart';

class UserRepository {
  final String endpoint = 'ddd';

  // 유저 만들기(닉네임 정보를 토대로 데이터 저장)
  Future<void> createProfile(UserModel profile, String token) async {
    // 헤더에 토큰 넣어서 서버로 보내기??
  }
  // 로그인한 유저(이미 있는 유저) 정보 가져오기
  Future<Map<String, dynamic>?> fetchProfile(String token, String uid) async {
    // 서버에 요청해서 프로필 정보 가져오기
    return {};
  }

  // 닉네임 수정
  Future<void> updateProfile(UserModel profile) async {
    // 서버에 요청해서 닉네임 수정
  }
}

final userRopo = Provider(
  (ref) => UserRepository(),
);
