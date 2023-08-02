import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/features/profile/models/user_model.dart';

class UserRepo {
  final String endpoint = 'ddd';

  // 유저 만들기(닉네임 정보를 토대로 데이터 저장)
  Future<void> createProfile(UserModel profile, User user) async {
    // 헤더에 토큰 넣어서 서버로 보내기??
  }

  // 로그인한 유저(이미 있는 유저) 정보 가져오기
  Future<Map<String, dynamic>?> fetchProfile(User user) async {
    // 서버에 요청해서 프로필 정보 가져오기
    // var options = BaseOptions(
    //     baseUrl: 'https://www.kezzle.com/api/v1/',
    //     connectTimeout: const Duration(seconds: 3),
    //     receiveTimeout: const Duration(seconds: 3),
    //     headers: {
    //       'Authorization': 'Bearer ${await user.getIdToken()}',
    //     });
    // Dio dio = Dio(options);
    // try {
    //   final response = await dio.get('users?uid=${user.uid}');
    //   if (response.statusCode == 200) {
    //     return response.data;
    //   } else {
    //     return null;
    //   }
    // } catch (e) {
    //   print(e);
    // } finally {
    //   dio.close();
    // }
    return {};
  }

  // 닉네임 수정
  Future<void> updateProfile(User user, String newNickname) async {
    // 서버에 요청해서 닉네임 수정
  }
}

final userRepo = Provider(
  (ref) => UserRepo(),
);
