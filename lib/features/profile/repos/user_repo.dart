import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kezzle/utils/dio/dio.dart';
// import 'package:kezzle/features/profile/models/user_model.dart';

class UserRepo {
  final ProviderRef ref;
  UserRepo(this.ref);

  // 유저 만들기(닉네임 정보를 토대로 데이터 저장)
  Future<Map<String, dynamic>?> createProfile(
      String nickname, User user) async {
    // 헤더에 토큰 넣어서 서버로 보내기??
    var options = BaseOptions(
      baseUrl: dotenv.env['SERVER_ENDPOINT']!,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      // headers: {
      //   'Authorization': 'Bearer ${await user.getIdToken(true)}',
      // },
    );
    Dio dio = Dio(options);
    // Dio dio = ref.watch(dioProvider);
    // 정의할 바디 데이터 (Map 형태로 정의)
    final Map<String, dynamic> postData = {
      'nickname': nickname,
    };
    try {
      final response = await dio.post(
        'users',
        data: postData,
      );
      return response.data;
      // if (response.statusCode == 200) {
      //   // print(response.data);
      //   return response.data;
      // } else {
      //   print('로그인 실패');
      //   return null;
      // }
    } catch (e) {
      print(e);
      // print('회원가입 실패');
      return null;
    } finally {
      // dio.close();
    }
  }

  // 로그인한 유저(이미 있는 유저) 정보 가져오기
  Future<Map<String, dynamic>?> fetchProfile(User user) async {
    // 서버에 요청해서 프로필 정보 가져오기
    var options = BaseOptions(
        baseUrl: dotenv.env['SERVER_ENDPOINT']!,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          'Authorization': 'Bearer ${await user.getIdToken()}',
        });
    Dio dio = Dio(options);
    try {
      final response = await dio.get('users/${user.uid}');
      if (response.statusCode == 200) {
        // print(response.data);
        return response.data;
      } else {
        // print('로그인 실패');
        return null;
      }
    } catch (e) {
      print(e);
      // print('로그인 실패');
      return null;
    } finally {
      dio.close();
    }
  }

  // 닉네임 수정
  Future<Map<String, dynamic>?> updateProfile(
      User user, String newNickname) async {
    var options = BaseOptions(
        baseUrl: dotenv.env['SERVER_ENDPOINT']!,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Authorization': 'Bearer ${await user.getIdToken()}',
        });
    Dio dio = Dio(options);
    // 정의할 바디 데이터 (Map 형태로 정의)
    final Map<String, dynamic> patchData = {
      'nickname': newNickname,
    };
    try {
      final response = await dio.patch(
        'users/${user.uid}',
        data: patchData,
      );
      return response.data;
      // if (response.statusCode == 200) {
      //   // print(response.data);
      //   return response.data;
      // } else {
      //   print('로그인 실패');
      //   return null;
      // }
    } catch (e) {
      print(e);
      print('닉네임 수정 실패');
      return null;
    } finally {
      dio.close();
    }
  }

  // 탈퇴 -> 회원 삭제
  Future<Response<dynamic>?> deleteProfile(User user) async {
    var options = BaseOptions(
        baseUrl: dotenv.env['SERVER_ENDPOINT']!,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Authorization': 'Bearer ${await user.getIdToken()}',
        });
    Dio dio = Dio(options);
    try {
      final response = await dio.delete(
        'users/${user.uid}',
      );
      return response;
      // if (response.statusCode == 200) {
      //   // print(response.data);
      //   return response.data;
      // } else {
      //   print('로그인 실패');
      //   return null;
      // }
    } catch (e) {
      print(e);
      print('회원탈퇴 실패');
      return null;
    } finally {
      dio.close();
    }
  }
}

final userRepo = Provider(
  (ref) => UserRepo(ref),
);
